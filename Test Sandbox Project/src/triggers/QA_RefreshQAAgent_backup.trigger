trigger QA_RefreshQAAgent_backup on QA_Periode__c (After Insert, Before Update) {
    for (QA_Periode__c qp : trigger.new){
    if (qp.Refresh_QA_Agent__c || Trigger.isInsert){
        if (!Trigger.IsInsert) qp.Refresh_QA_Agent__c = FALSE;
        
        // check di periode yang sama.
        List<String> TempOwner = new List<string>();
        String Temp='';
        for (QA_Agent_Answer__c qan : [SELECT User_Agent__c FROM QA_Agent_Answer__c WHERE Periode__c =: qp.Periode__c and User_Agent__c != NULL order by User_Agent__c ]){
            if (Temp != string.valueof(qan.User_Agent__c)) {
                TempOwner.add(String.valueof(qan.User_Agent__c));
                Temp = string.valueof(qan.User_Agent__c);
            }
        }
        
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
            from QA_Question__c WHERE id =: qp.QA_Question__c
        ]){
            
            List<QA_Agent_Answer__c> ListQAN = new List<QA_Agent_Answer__c>();
            
            for (User us : [SELECT id FROM User WHERE isActive = TRUE and Type_Agent__c =: qa.Type_Agent__c and Id NOT IN :TempOwner]){
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
    } // end if
    } // end for
} // end trigger.