// Update Agent Achivement every day
Global class SchUpdateAG implements Schedulable {

  public static String CRON_EXP = '0 0 0 3 9 ? 2022';

    Global void execute(SchedulableContext ctx) {
        
        Date ThisDay = date.today();
        string q = '';
        if (ThisDay.day() == 1)
            //list<Agent_Achievement__c> ag2 = [
            q = 'SELECT id, OwnerId, Attendance_Refresh__c, CSAT_Refresh__c, Hold_Time_Refresh__c, Productivity_Refresh__c, QA_Refresh__c FROM Agent_Achievement__c WHERE Document_Date__c = LAST_MONTH';
        else 
            q = 'SELECT id, OwnerId, Attendance_Refresh__c, CSAT_Refresh__c, Hold_Time_Refresh__c, Productivity_Refresh__c, QA_Refresh__cFROM Agent_Achievement__c WHERE Document_Date__c = THIS_MONTH';


        UpdateAGBatch UserAgent = new UpdateAGBatch(q);
        Database.executeBatch(UserAgent, 1);

        
    } // end execute
} // end class