trigger RollUpScore on Learning_Assignment__c (after update) {
    for(Learning_Assignment__c l:trigger.New){
        List<Training_Plan_Section_Assignment__c> sa = [SELECT id, Training_Plan_Section_Assignment_Score__c, Training_Plan_Assignment__r.Training_Plan_Score__c FROM Training_Plan_Section_Assignment__c WHERE id =: l.Training_Plan_Section_Assignment__c ];
        if((Trigger.old[0].Total_score__c != Trigger.new[0].Total_score__c) && l.Total_Score__c!=0){
            //if(sa.size()>0){
            sa[0].Training_Plan_Section_Assignment_Score__c = sa[0].Training_Plan_Section_Assignment_Score__c + l.Total_Score__c;
            
            //sa[0].Training_Plan_Assignment__r.Training_Plan_Score__c = sa[0].Training_Plan_Section_Assignment_Score__c;
           // 
            //}
        }//update sa[0];
    }
}