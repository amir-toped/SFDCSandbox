trigger QA_InsertQAAgent on QA_Question__c (Before Update) {
    for (QA_Question__c qa : trigger.new){
        if (qa.Create_QA_Agent__c){
            qa.Create_QA_Agent__c = FALSE;
            
            List<QA_Agent_Answer__c> ListQAN = new List<QA_Agent_Answer__c>();
            
            for (User us : [SELECT id FROM User WHERE Type_Agent__c =: qa.Type_Agent__c]){
            
                QA_Agent_Answer__c qan = new QA_Agent_Answer__c();
                qan.OwnerId = us.id;
                qan.User_Agent__c = us.id;
                qan.QA_Question__c = qa.id;
                qan.Type_Agent__c = qa.Type_Agent__c;

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
                
                qan.Document_Date__c = datetime.now();
                qan.FE_Attribute__c = qa.FE_Attribute__c;
                qan.NFE_Attribute__c = qa.NFE_Attribute__c;
                qan.Week__c = 'Week 1';
                
                ListQAN.add(qan);
            } // end for user.
            
            if (ListQAN.size() > 0) insert ListQAN;
        } // end Create.
    } // end for
} // end trigger.