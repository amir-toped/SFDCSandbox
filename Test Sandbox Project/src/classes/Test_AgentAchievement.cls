@isTest(seeAllData=true)
private class Test_AgentAchievement{

    static testMethod void myTest() {
        Test.startTest();

        case cs = [SELECT id FROM Case 
            where account.personcontact.email != NULL
        limit 1];

        // insert Case Chat
        Case_chat__c cc = new Case_chat__c();
        cc.user__c = UserInfo.getUserId();
        cc.Document_Date__c = Date.newInstance(2017, 1, 31);
        cc.case__c = cs.id;
        cc.messages2__c = 'testing';
        cc.email__c = 'taufik.susanto@mii.co.id';
        insert cc;
        cc.Document_Date__c = Date.newInstance(2017, 1, 31);
        update cc;

        // insert task
        Task tsk = new Task();
        tsk.ActivityDate = Date.newInstance(2017, 1, 1);
        tsk.Start_Call__c = Date.newInstance(2017, 1, 1); //System.Now();
        tsk.End_Call__c = Date.newInstance(2017, 1, 2); //System.Now();
        insert tsk;

        // insert survey
        Agent_Response_Case__c tsk2 = new Agent_Response_Case__c();
        
        tsk2.User_Agent__c = UserInfo.getUserId();
        tsk2.Date_Survey_Taken__c = Date.newInstance(2017, 1, 31);
        tsk2.Case__c = cs.id;
        tsk2.Response__c = 1;
        insert tsk2;

        Agent_Achievement__c agst = new Agent_Achievement__c();
        agst.Name = 'test';
        agst.Document_Date__c = Date.newInstance(2017, 1, 1);        

        insert agst;
        
        agst.Attendance_Refresh__c = TRUE;
        agst.CSAT_Refresh__c = TRUE;
        agst.Hold_Time_Refresh__c = TRUE;
        agst.Productivity_Refresh__c = TRUE;
        agst.QA_Refresh__c = TRUE;

        update agst;
        
        Test.stopTest();
    }
}