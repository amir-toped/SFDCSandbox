@isTest(seeAllData=true)
private class Test_AgentAttendance{

    static testMethod void myTest() {
        Test.startTest();

        Agent_Shift__c agst;
        
        list<Agent_Shift__c> listagst = [SELECT id, Name, Document_Date__c, End_Hour__c, End_Minute__c, End_Next_Day__c, 
            End_Time__c, Last_Login__c, Start_Hour__c, Start_Login__c, Start_Minute__c, Start_Time__c, Type_Shift__c
            FROM Agent_Shift__c WHERE Type_Shift__c = '1'
            limit 1];
            
        if (listagst.size() > 0) {
            agst = [SELECT id, Name, Document_Date__c, End_Hour__c, End_Minute__c, End_Next_Day__c, 
                End_Time__c, Last_Login__c, Start_Hour__c, Start_Login__c, Start_Minute__c, Start_Time__c, Type_Shift__c
                FROM Agent_Shift__c WHERE Type_Shift__c = '1'
                limit 1];
        }
        else {
            agst = new Agent_Shift__c();
        }


        agst.Name = '1';
        agst.Document_Date__c = Date.newInstance(2017, 2, 17);

        agst.Start_Hour__c = 6;
        agst.Start_Minute__c = 30;

        //agst.Start_Login__c
        //agst.Start_Time__c

        agst.End_Hour__c = 15;
        agst.End_Minute__c = 30;
        //agst.End_Next_Day__c
        //agst.End_Time__c
        
        //agst.Last_Login__c
        agst.Type_Shift__c = '1';

        if (listagst.size() > 0) update agst;
        else insert agst;
        
        // Agent_Scheduling__c
        Agent_Scheduling__c ags = new Agent_Scheduling__c();
        ags.Agent__c = UserInfo.getUserId();
        ags.Document_Date__c = Date.newInstance(2017, 1, 1);
        
        ags.Break_Shift_01__c = '2';
        ags.Break_Shift_02__c = '2';
        ags.Break_Shift_03__c = '2';
        ags.Break_Shift_04__c = '2';
        ags.Break_Shift_05__c = '2';
        ags.Break_Shift_06__c = '2';
        ags.Break_Shift_07__c = '2';
        ags.Break_Shift_08__c = '2';
        ags.Break_Shift_09__c = '2';
        ags.Break_Shift_10__c = '2';
        ags.Break_Shift_11__c = '2';
        ags.Break_Shift_12__c = '2';
        ags.Break_Shift_13__c = '2';
        ags.Break_Shift_14__c = '2';
        ags.Break_Shift_15__c = '2';
        ags.Break_Shift_16__c = '2';
        ags.Break_Shift_17__c = '2';
        ags.Break_Shift_18__c = '2';
        ags.Break_Shift_19__c = '2';
        ags.Break_Shift_20__c = '2';
        ags.Break_Shift_21__c = '2';
        ags.Break_Shift_22__c = '2';
        ags.Break_Shift_23__c = '2';
        ags.Break_Shift_24__c = '2';
        ags.Break_Shift_25__c = '2';
        ags.Break_Shift_26__c = '2';
        ags.Break_Shift_27__c = '2';
        ags.Break_Shift_28__c = '2';
        ags.Break_Shift_29__c = '2';
        ags.Break_Shift_30__c = '2';
        ags.Break_Shift_31__c = '2';
        
        ags.Schedule_Shift__c = '1';
        
        ags.SS_01__c = '1';
        ags.SS_02__c = '1';
        ags.SS_03__c = '1';
        ags.SS_04__c = '1';
        ags.SS_05__c = '1';
        ags.SS_06__c = '1';
        ags.SS_07__c = '1';
        ags.SS_08__c = '1';
        ags.SS_09__c = '1';
        ags.SS_10__c = '1';
        ags.SS_11__c = '1';
        ags.SS_12__c = '1';
        ags.SS_13__c = '1';
        ags.SS_14__c = '1';
        ags.SS_15__c = '1';
        ags.SS_16__c = '1';
        ags.SS_17__c = '1';
        ags.SS_18__c = '1';
        ags.SS_19__c = '1';
        ags.SS_20__c = '1';
        ags.SS_21__c = '1';
        ags.SS_22__c = '1';
        ags.SS_23__c = '1';
        ags.SS_24__c = '1';
        ags.SS_25__c = '1';
        ags.SS_26__c = '1';
        ags.SS_27__c = '1';
        ags.SS_28__c = '1';
        ags.SS_29__c = '1';
        ags.SS_30__c = '1';
        ags.SS_31__c = '1';
        
        insert ags;
        
        // Agent_Attendance__c
        Agent_Attendance__c att = new Agent_Attendance__c ();
        
        att.Name = 'test';
        att.Agent_Scheduling__c = ags.id;
        att.Attendance_Date__c = Date.newInstance(2017, 1, 1);
        att.Shift__c = '1';
        
        insert att;
        
        //AgentAttendance btnatt = new AgentAttendance();
        PageReference pageRef = page.AgentAttendance;
        Test.setCurrentPage(pageRef);

        user us = new user();
        ApexPages.StandardController stdController = new ApexPages.StandardController(us);
        AgentAttendance btnatt = new AgentAttendance(stdController);
                
        btnatt.Save();
        btnatt.SubmitApproval();
        btnatt.btnlogin();
        btnatt.btnlogoff();
        
        Test.stopTest();
    }
}