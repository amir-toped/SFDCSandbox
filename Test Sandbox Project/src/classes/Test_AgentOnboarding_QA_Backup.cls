@isTest(seeAllData=true)
private class Test_AgentOnboarding_QA_Backup{

    static testMethod void myTest() {
        QA_Question__c qa = new QA_Question__c();
        qa.Active__c = TRUE;
        qa.Bobot_FE_01__c = 10;
        qa.Bobot_FE_02__c = 10;
        qa.Bobot_FE_03__c = 10;
        qa.Bobot_FE_04__c = 10;
        qa.Bobot_FE_05__c = 10;
        qa.Bobot_FE_06__c = 10;
        qa.Bobot_FE_07__c = 10;
        qa.Bobot_FE_08__c = 10;
        qa.Bobot_FE_09__c = 10;
        qa.Bobot_FE_10__c = 10;

        qa.Bobot_NFE_01__c = 10;
        qa.Bobot_NFE_02__c = 10;
        qa.Bobot_NFE_03__c = 10;
        qa.Bobot_NFE_04__c = 10;
        qa.Bobot_NFE_05__c = 10;
        qa.Bobot_NFE_06__c = 10;
        qa.Bobot_NFE_07__c = 10;
        qa.Bobot_NFE_08__c = 10;
        qa.Bobot_NFE_09__c = 10;
        qa.Bobot_NFE_10__c = 10;
        qa.Bobot_NFE_11__c = 10;
        qa.Bobot_NFE_12__c = 10;
        qa.Bobot_NFE_13__c = 10;
        qa.Bobot_NFE_14__c = 10;
        qa.Bobot_NFE_15__c = 10;
        
        qa.Bobot_FE__c = 60;
        qa.Bobot_NFE__c = 40;
        
        qa.Q_FE_01__c = 'test';
        qa.Q_FE_02__c = 'test';
        qa.Q_FE_03__c = 'test';
        qa.Q_FE_04__c = 'test';
        qa.Q_FE_05__c = 'test';
        qa.Q_FE_06__c = 'test';
        qa.Q_FE_07__c = 'test';
        qa.Q_FE_08__c = 'test';
        qa.Q_FE_09__c = 'test';
        qa.Q_FE_10__c = 'test';
        
        qa.Q_NFE_01__c = 'test';
        qa.Q_NFE_02__c = 'test';
        qa.Q_NFE_03__c = 'test';
        qa.Q_NFE_04__c = 'test';
        qa.Q_NFE_05__c = 'test';
        qa.Q_NFE_06__c = 'test';
        qa.Q_NFE_07__c = 'test';
        qa.Q_NFE_08__c = 'test';
        qa.Q_NFE_09__c = 'test';
        qa.Q_NFE_10__c = 'test';
        qa.Q_NFE_11__c = 'test';
        qa.Q_NFE_12__c = 'test';
        qa.Q_NFE_13__c = 'test';
        qa.Q_NFE_14__c = 'test';
        qa.Q_NFE_15__c = 'test';
        
        qa.Document_Date__c = Date.newInstance(2017, 2, 17); //date.today();
        
        qa.S_FE_01__c = 'parameter';
        qa.S_FE_02__c = 'parameter';
        qa.S_FE_03__c = 'parameter';
        qa.S_FE_04__c = 'parameter';
        qa.S_FE_05__c = 'parameter';
        qa.S_FE_06__c = 'parameter';
        qa.S_FE_07__c = 'parameter';
        qa.S_FE_08__c = 'parameter';
        qa.S_FE_09__c = 'parameter';
        qa.S_FE_10__c = 'parameter';

        qa.S_NFE_01__c = 'parameter';
        qa.S_NFE_02__c = 'parameter';
        qa.S_NFE_03__c = 'parameter';
        qa.S_NFE_04__c = 'parameter';
        qa.S_NFE_05__c = 'parameter';
        qa.S_NFE_06__c = 'parameter';
        qa.S_NFE_07__c = 'parameter';
        qa.S_NFE_08__c = 'parameter';
        qa.S_NFE_09__c = 'parameter';
        qa.S_NFE_10__c = 'parameter';
        qa.S_NFE_11__c = 'parameter';
        qa.S_NFE_12__c = 'parameter';
        qa.S_NFE_13__c = 'parameter';
        qa.S_NFE_14__c = 'parameter';
        qa.S_NFE_15__c = 'parameter';
        
        qa.Type_Agent__c = 'Call Center';

        
        Test.startTest();
        insert qa;
        
        // QA_Periode__c
        QA_Periode__c qap = new QA_Periode__c();
        qap.Count_Sample__c = '1';
        qap.Count_Week__c = '1';
        qap.Document_Date__c = Date.newInstance(2017, 2, 17); //date.today();
        qap.QA_Question__c = qa.id;
        
        insert qap;
        
        //  QA_Agent_Answer__c
        QA_Agent_Answer__c qaa = [SELECT id, Status__c, User_Agent__c FROM QA_Agent_Answer__c Where QA_Question__c =: qa.id LIMIT 1];
        qaa.Status__c = 'Waiting Approval';
        qaa.Share_to_User_Agent__c = TRUE;
        update qaa;
        qaa.Share_to_User_Agent__c = FALSE;
        update qaa;
        user us = [SELECT id FROM User WHERE Profile.Name = 'System Administrator' and id !=:qaa.User_Agent__c limit 1];
        qaa.User_Agent__c = us.id;
        qaa.Share_to_User_Agent__c = TRUE;
        update qaa;
        
        //TriggerFuture.ShareAgentAnwer(qaa.id, qaa.Manager__c, qaa.Manager__c, 'Edit');
        //TriggerFuture.UnShareAgentAnwer(qaa.id, qaa.User_Agent__c, qaa.User_Agent__c, 'Read');
        //Test.stopTest();
    }
}