public class SpikeTicketCounterManager {
	
    public static Map<String, List<Spike_Ticket_Notification_Scenerio__mdt>> spikeTicketNotificationScenerios;
    
    static{
        spikeTicketNotificationScenerios = new Map<String, List<Spike_Ticket_Notification_Scenerio__mdt>>();
        List<Spike_Ticket_Notification_Scenerio__mdt> scenerios = [
            SELECT Category_1__c, Category_2__c, Category_3__c, Threshold__c, Type__c 
            FROM Spike_Ticket_Notification_Scenerio__mdt WHERE Active__c = true
        ]; 
        if(!scenerios.isEmpty()){
            for(Spike_Ticket_Notification_Scenerio__mdt scenerio :scenerios){
                String uniqueKey = scenerio.Category_1__c + scenerio.Category_2__c + scenerio.Category_3__c;
                if(spikeTicketNotificationScenerios.containsKey(uniqueKey)){
                    spikeTicketNotificationScenerios.get(uniqueKey).add(scenerio);
                } else {
                    spikeTicketNotificationScenerios.put(uniqueKey, new List<Spike_Ticket_Notification_Scenerio__mdt>{scenerio});
                }
            }
        }
    } 
    
    private static List<Spike_Ticket_Notification_Scenerio__mdt> getScenerios(Spike_Ticket_Counter__c stc){
        return spikeTicketNotificationScenerios.get(stc.Category_1__c + stc.Category_2__c + stc.Category_3__c);
    }
    
    public static void checkForThresholdCrossed(List<Spike_Ticket_Counter__c> counters){
        for(Spike_Ticket_Counter__c counter :counters){
            List<Spike_Ticket_Notification_Scenerio__mdt> scenerios = getScenerios(counter);
            if(scenerios != null){
                for(Spike_Ticket_Notification_Scenerio__mdt scenerio :scenerios){
                    if(scenerio.Type__c == 'Last Hour Same Day' && counter.This_Hour_Growth__c >= scenerio.Threshold__c){
                        counter.Last_Hour_Same_Day_Threshold_Crossed__c = true;
                    } else if(scenerio.Type__c == 'Same Hour Previous Day' && counter.Same_Hour_Previous_Day_Growth__c >= scenerio.Threshold__c){
                        counter.Same_Hour_Previous_Day_Threshold_Crossed__c = true; 
                    }
                }
            }
        }
    }
    
    public static void setSpikeTicketCounters(List<Case> inputCases){
        List<Case> cases = new List<Case>();
        
        Set<String> Categories1 = new Set<String>();
        Set<String> Categories2 = new Set<String>();
        Set<String> Categories3 = new Set<String>();
        
        for(Case c :inputCases){
            if(c.Category__c != null || c.Case_SubCategory_1__c != null || c.Sub_Category2__c != null){
                if(c.Category__c != null){
                    Categories1.add(c.Category__c); 
                }
                if(c.Case_SubCategory_1__c != null){
                    Categories2.add(c.Case_SubCategory_1__c);
                }
                if(c.Sub_Category2__c != null){
                    Categories3.add(c.Sub_Category2__c); 
                }
                cases.add(c);
            }
        }
        if(cases.isEmpty()){
         	return;   
        }
        DateTime thisHour = getThisHourDate();
        DateTime lastHour = getLastHourDate();
        DateTime previousDayThisHour = getPreviousDayThisHourDate();
        DateTime previousDayLastHour = getPreviousDayLastHourDate();
        
        List<Spike_Ticket_Counter__c> existingCounters = [
            SELECT Last_Hour_Count__c, This_Hour_Count__c, Same_Hour_Previous_Day_Count__c, CreatedDate, Category_1__c, Category_2__c, Category_3__c
            FROM Spike_Ticket_Counter__c
            WHERE (CreatedDate >=: lastHour OR (CreatedDate >=: previousDayLastHour AND CreatedDate <: previousDayThisHour)) 
            AND Category_1__c IN :Categories1 AND Category_2__c IN :Categories2 AND Category_3__c IN :Categories3
        ];
        Map<String, Spike_Ticket_Counter__c> thisHourCountersMap = new Map<String, Spike_Ticket_Counter__c>();
        Map<String, Spike_Ticket_Counter__c> lastHourCountersMap = new Map<String, Spike_Ticket_Counter__c>();
        Map<String, Spike_Ticket_Counter__c> previousDaySameHourCountersMap = new Map<String, Spike_Ticket_Counter__c>();
        
        for(Spike_Ticket_Counter__c stc :existingCounters){
            String uniqueKey = stc.Category_1__c + stc.Category_2__c + stc.Category_3__c;
            if(stc.CreatedDate >= thisHour){
                thisHourCountersMap.put(uniqueKey, stc);
            } else if(stc.CreatedDate >= lastHour){
                lastHourCountersMap.put(uniqueKey, stc);
            } else if(stc.CreatedDate >= previousDayLastHour && stc.CreatedDate < previousDayThisHour){
                previousDaySameHourCountersMap.put(uniqueKey, stc);
            }
        }
        List<Spike_Ticket_Counter__c> counters = new List<Spike_Ticket_Counter__c>();
        for(Case c :cases){
            String uniqueKey = c.Category__c + c.Case_SubCategory_1__c + c.Sub_Category2__c;
            Spike_Ticket_Counter__c counter;
            
            if(thisHourCountersMap.containsKey(uniqueKey)){
                counter = thisHourCountersMap.get(uniqueKey);
                counter.This_Hour_Count__c += 1;
            } else {
                counter = new Spike_Ticket_Counter__c(
                    Category_1__c = c.Category__c,
                    Category_2__c = c.Case_SubCategory_1__c,
                    Category_3__c = c.Sub_Category2__c,
                    This_Hour_Count__c = 1
                );
            }
            if(lastHourCountersMap.containsKey(uniqueKey)){
                counter.Last_Hour_Count__c = lastHourCountersMap.get(uniqueKey).This_Hour_Count__c;
            }
            if(previousDaySameHourCountersMap.containsKey(uniqueKey)){
                counter.Same_Hour_Previous_Day_Count__c = previousDaySameHourCountersMap.get(uniqueKey).This_Hour_Count__c;
            }
            counters.add(counter);
        }
        upsert counters;
    }
    
    public static DateTime getLastHourDate(){
        DateTime lastHourDate = DateTime.now().addHours(-1);
        return DateTime.newInstance(lastHourDate.date(), Time.newInstance(lastHourDate.hour(), 0, 0, 0));
    }
    
    public static DateTime getThisHourDate(){
        DateTime lastHourDate = DateTime.now();
        return DateTime.newInstance(lastHourDate.date(), Time.newInstance(lastHourDate.hour(), 0, 0, 0));
    }
    
    public static DateTime getPreviousDayLastHourDate(){
        DateTime lastHourDate = DateTime.now().addHours(-25);
        return DateTime.newInstance(lastHourDate.date(), Time.newInstance(lastHourDate.hour(), 0, 0, 0));
    }
    
    public static DateTime getPreviousDayThisHourDate(){
        DateTime lastHourDate = DateTime.now().addHours(-24);
        return DateTime.newInstance(lastHourDate.date(), Time.newInstance(lastHourDate.hour(), 0, 0, 0));
    }
}