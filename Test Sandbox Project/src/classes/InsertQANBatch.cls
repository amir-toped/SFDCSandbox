global class InsertQANBatch implements Database.Batchable<sObject>, Database.Stateful {

    global String query;    

    global id QAquestion;
    global id QAPeriod;
    
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;

    global InsertQANBatch(String q, id DataId, id DataId2) {
        this.query = q;
        this.QAquestion = Dataid;
        this.QAPeriod = DataId2;
    }

    global Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug(LoggingLevel.DEBUG, '***QUERY BATCH: ' + query);
        
        if (test.isrunningtest()) query = 'SELECT id FROM User WHERE id =\''+Label.QAAgentAnswerUser+'\' and isActive = TRUE';
            
            return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<User> scope){
        // process each batch of records
        System.debug(LoggingLevel.DEBUG, '***SCOPE: ' + scope);

        QA_Periode__c qp = [SELECT id, Count_Week__c, Count_Sample__c, Document_Date__c FROM QA_Periode__c WHERE id =: QAPeriod];

        for (QA_Question__c qa : [SELECT id, Active__c, Bobot_Desc__c, Bobot_FE__c, Bobot_NFE__c, Create_QA_Agent__c, 
            Document_Date__c, FE_Attribute__c, NFE_Attribute__c, 
            Q_FE_01__c, Q_FE_02__c, Q_FE_03__c, Q_FE_04__c, Q_FE_05__c, 
            Q_FE_06__c, Q_FE_07__c, Q_FE_08__c, Q_FE_09__c, Q_FE_10__c, 
            Q_NFE_01__c, Q_NFE_02__c, Q_NFE_03__c, Q_NFE_04__c, Q_NFE_05__c, 
            Q_NFE_06__c, Q_NFE_07__c, Q_NFE_08__c, Q_NFE_09__c, Q_NFE_10__c, 
            Q_NFE_11__c, Q_NFE_12__c, Q_NFE_13__c, Q_NFE_14__c, Q_NFE_15__c, 
            S_FE_01__c, S_FE_02__c, S_FE_03__c, S_FE_04__c, S_FE_05__c, 
            S_FE_06__c, S_FE_07__c, S_FE_08__c, S_FE_09__c, S_FE_10__c, 
            S_NFE_01__c, S_NFE_02__c, S_NFE_03__c, S_NFE_04__c, S_NFE_05__c, 
            S_NFE_06__c, S_NFE_07__c, S_NFE_08__c, S_NFE_09__c, S_NFE_10__c, 
            S_NFE_11__c, S_NFE_12__c, S_NFE_13__c, S_NFE_14__c, S_NFE_15__c, 
            Total_Bobot_FE__c, Total_Bobot_NFE__c,
            Type_Agent__c
            from QA_Question__c WHERE id =: QAquestion
        ]){
            
            List<QA_Agent_Answer__c> ListQAN = new List<QA_Agent_Answer__c>();
            
            for (User us : scope){
                for (integer i = 1; i <= integer.valueof(qp.Count_Week__c); i++) {
                    for (integer j = 1; j <= integer.valueof(qp.Count_Sample__c); j++) {
            
                        QA_Agent_Answer__c qan = new QA_Agent_Answer__c();
                        qan.OwnerId = us.id;
                        qan.QA_Periode__c = qp.id;
                        qan.User_Agent__c = us.id;
                        qan.QA_Question__c = qa.id;
                        qan.Type_Agent__c = qa.Type_Agent__c;
                        qan.Sample_No__c = j;
                        qan.Week__c = string.valueof(i);
        
                        qan.Q_FE_01__c = qa.Q_FE_01__c;
                        qan.Q_FE_02__c = qa.Q_FE_02__c;
                        qan.Q_FE_03__c = qa.Q_FE_03__c;
                        qan.Q_FE_04__c = qa.Q_FE_04__c;
                        qan.Q_FE_05__c = qa.Q_FE_05__c;
                        qan.Q_FE_06__c = qa.Q_FE_06__c;
                        qan.Q_FE_07__c = qa.Q_FE_07__c;
                        qan.Q_FE_08__c = qa.Q_FE_08__c;
                        qan.Q_FE_09__c = qa.Q_FE_09__c;
                        qan.Q_FE_10__c = qa.Q_FE_10__c;
        
                        qan.Q_NFE_01__c = qa.Q_NFE_01__c;
                        qan.Q_NFE_02__c = qa.Q_NFE_02__c;
                        qan.Q_NFE_03__c = qa.Q_NFE_03__c;
                        qan.Q_NFE_04__c = qa.Q_NFE_04__c;
                        qan.Q_NFE_05__c = qa.Q_NFE_05__c;
                        qan.Q_NFE_06__c = qa.Q_NFE_06__c;
                        qan.Q_NFE_07__c = qa.Q_NFE_07__c;
                        qan.Q_NFE_08__c = qa.Q_NFE_08__c;
                        qan.Q_NFE_09__c = qa.Q_NFE_09__c;
                        qan.Q_NFE_10__c = qa.Q_NFE_10__c;
                        qan.Q_NFE_11__c = qa.Q_NFE_11__c;
                        qan.Q_NFE_12__c = qa.Q_NFE_12__c;
                        qan.Q_NFE_13__c = qa.Q_NFE_13__c;
                        qan.Q_NFE_14__c = qa.Q_NFE_14__c;
                        qan.Q_NFE_15__c = qa.Q_NFE_15__c;
        
                        qan.S_FE_01__c = qa.S_FE_01__c;
                        qan.S_FE_02__c = qa.S_FE_02__c;
                        qan.S_FE_03__c = qa.S_FE_03__c;
                        qan.S_FE_04__c = qa.S_FE_04__c;
                        qan.S_FE_05__c = qa.S_FE_05__c;
                        qan.S_FE_06__c = qa.S_FE_06__c;
                        qan.S_FE_07__c = qa.S_FE_07__c;
                        qan.S_FE_08__c = qa.S_FE_08__c;
                        qan.S_FE_09__c = qa.S_FE_09__c;
                        qan.S_FE_10__c = qa.S_FE_10__c;
        
                        qan.S_NFE_01__c = qa.S_NFE_01__c;
                        qan.S_NFE_02__c = qa.S_NFE_02__c;
                        qan.S_NFE_03__c = qa.S_NFE_03__c;
                        qan.S_NFE_04__c = qa.S_NFE_04__c;
                        qan.S_NFE_05__c = qa.S_NFE_05__c;
                        qan.S_NFE_06__c = qa.S_NFE_06__c;
                        qan.S_NFE_07__c = qa.S_NFE_07__c;
                        qan.S_NFE_08__c = qa.S_NFE_08__c;
                        qan.S_NFE_09__c = qa.S_NFE_09__c;
                        qan.S_NFE_10__c = qa.S_NFE_10__c;
                        qan.S_NFE_11__c = qa.S_NFE_11__c;
                        qan.S_NFE_12__c = qa.S_NFE_12__c;
                        qan.S_NFE_13__c = qa.S_NFE_13__c;
                        qan.S_NFE_14__c = qa.S_NFE_14__c;
                        qan.S_NFE_15__c = qa.S_NFE_15__c;
                        
                        qan.Q_Total_Bobot_FE__c = qa.Total_Bobot_FE__c;
                        qan.Q_Total_Bobot_NFE__c = qa.Total_Bobot_NFE__c;
                        
                        qan.Document_Date__c = Datetime.newInstance(qp.Document_Date__c.Year(), qp.Document_Date__c.Month(), qp.Document_Date__c.Day(), 12, 30, 2); //datetime.valueof(qp.Document_Date__c);
                        qan.FE_Attribute__c = qa.FE_Attribute__c;
                        qan.NFE_Attribute__c = qa.NFE_Attribute__c;
                        //qan.Week__c = 'Week 1';
                        
                        ListQAN.add(qan);
                    } // end j
                } // end i
            } // end for user.
            
            if (ListQAN.size() > 0) insert ListQAN;
        } // end Create.
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