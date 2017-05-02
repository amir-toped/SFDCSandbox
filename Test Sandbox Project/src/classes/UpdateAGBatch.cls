global class UpdateAGBatch implements Database.Batchable<sObject>, Database.Stateful {

    global String query;    

    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;

    global UpdateAGBatch(String q) {
        this.query = q;
    }

    global Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug(LoggingLevel.DEBUG, '***QUERY BATCH: ' + query);
        
        if (test.isrunningtest()) query = 'SELECT id, OwnerId, Attendance_Refresh__c, CSAT_Refresh__c, Hold_Time_Refresh__c, Productivity_Refresh__c, QA_Refresh__c FROM Agent_Achievement__c limit 1';
            
            return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<Agent_Achievement__c> scope){
        // process each batch of records
        System.debug(LoggingLevel.DEBUG, '***SCOPE: ' + scope);
            
            list<Agent_Achievement__c> ListAG = new list<Agent_Achievement__c>();
            
            for (Agent_Achievement__c us : scope){
                us.Attendance_Refresh__c = TRUE;
                us.CSAT_Refresh__c = TRUE;
                us.Hold_Time_Refresh__c = TRUE;
                us.Productivity_Refresh__c = TRUE;
                us.QA_Refresh__c = TRUE;
                //us.Resolved_Refresh__c
                //us.Response_Refresh__c

                ListAG.add(us);
            } // end for AG
            if (ListAG.size() > 0) update ListAG;
    }    

    global void finish(Database.BatchableContext bc){
        System.debug(LoggingLevel.DEBUG, '***TOTAL: ' + recordsProcessed);

/*        
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        // call some utility to send email
        EmailUtils.sendMessage(a, recordsProcessed);
*/
    }    

}