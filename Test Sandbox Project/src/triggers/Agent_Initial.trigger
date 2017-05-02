trigger Agent_Initial on Agent_Attendance__c (Before Insert) {
    for (Agent_Attendance__c ag : trigger.new) {
        if (ag.Manager_Email_F__c != NULL) ag.Manager_Email__c = ag.Manager_Email_F__c;
        ag.Attendance_Date__c = date.today();
        if (ag.name == NULL) ag.name = UserInfo.getName()+' '+ag.Attendance_Date__c;
        boolean createAgentSch = TRUE;    
        // check agent Scheduling
        for (Agent_Scheduling__c ags : [SELECT id, SS_01__c, SS_02__c, SS_03__c, SS_04__c, SS_05__c, SS_06__c, SS_07__c, 
                    SS_08__c, SS_09__c, SS_10__c, SS_11__c, SS_12__c, SS_13__c, SS_14__c, 
                    SS_15__c, SS_16__c, SS_17__c, SS_18__c, SS_19__c, SS_20__c, SS_21__c, 
                    SS_22__c, SS_23__c, SS_24__c, SS_25__c, SS_26__c, SS_27__c, SS_28__c, 
                    SS_29__c, SS_30__c, SS_31__c 
            FROM Agent_Scheduling__c WHERE Agent__c =: ag.OwnerId and Periode__c =: ag.Login_Periode__c
            LIMIT 1])
        {
        string col= '';
        createAgentSch = FALSE;
            ag.Agent_Scheduling__c = ags.id;

            if (ag.Attendance_Date__c.day() < 10) col = '0'+string.valueof(ag.Attendance_Date__c.day());
            else col = string.valueof(ag.Attendance_Date__c.day());

            if (ags.get('SS_'+col+'__c') != 'X' && ags.get('SS_'+col+'__c') != 'C' && ags.get('SS_'+col+'__c') != '' && ags.get('SS_'+col+'__c') != NULL)
//            if (temp.get('SS_'+col+'__c') != 'X' && temp.get('SS_'+col+'__c') != 'C' && temp.get('SS_'+col+'__c') != '' && temp.get('SS_'+col+'__c') != NULL)
                ag.Shift__c = String.valueof(ags.get('SS_'+col+'__c'));
        }
        if (createAgentSch) {
            Agent_Scheduling__c newags = new Agent_Scheduling__c();
            newags.Agent__c = ag.OwnerId;
            newags.Document_Date__c = date.valueof(ag.Login_Date__c);
            
            insert newags;
            ag.Agent_Scheduling__c = newags.id;
        }

        // Check Shift
        String TempShift = '';
        if (ag.Shift__c != NULL) {    
            TempShift = ag.Shift__c;

            for (Agent_Shift__c ags2 : [SELECT id, End_Hour__c, End_Logout__c, End_Minute__c, End_Next_Day__c, End_Time__c,
                Add_Day__c, Last_Login__c, Start_Hour__c, Start_Login__c, Start_Minute__c, Start_Time__c
                FROM Agent_Shift__c
                WHERE Type_Shift__c =:TempShift
                LIMIT 1
            ]) {
                Date EndDate = ag.Attendance_Date__c.addDays(integer.valueof(ags2.Add_Day__c)) ;
            
                DateTime StartTime = DateTime.newInstance(ag.Attendance_Date__c.Year(), ag.Attendance_Date__c.Month(), ag.Attendance_Date__c.day(), integer.valueof(ags2.Start_Hour__c), integer.valueof(ags2.Start_Minute__c), 0);
                DateTime StartLogin = DateTime.newInstance(ag.Attendance_Date__c.Year(), ag.Attendance_Date__c.Month(), ag.Attendance_Date__c.day(), integer.valueof(ags2.Start_Hour__c)-2, integer.valueof(ags2.Start_Minute__c), 0);
                DateTime LastLogin = DateTime.newInstance(ag.Attendance_Date__c.Year(), ag.Attendance_Date__c.Month(), ag.Attendance_Date__c.day(), integer.valueof(ags2.Start_Hour__c), integer.valueof(ags2.Start_Minute__c)+15, 0);
                
                DateTime EndTime = DateTime.newInstance(EndDate.Year(), EndDate.Month(), EndDate.day(), integer.valueof(ags2.End_Hour__c), integer.valueof(ags2.End_Minute__c), 0); //Shift1Start;
                DateTime EndLogout = DateTime.newInstance(EndDate.Year(), EndDate.Month(), EndDate.day(), integer.valueof(ags2.End_Hour__c)+2, integer.valueof(ags2.End_Minute__c), 0); //Shift1Start;
                    
                ag.Start_Time__c = StartTime;
                ag.End_Time__c = EndTime;
        
                ag.Start_Login__c = StartLogin;
                ag.End_Logout__c = EndLogout;
        
                ag.Last_Login__c = LastLogin;
            
            }
        }
        // check_last_login, khusus login bukan menggunakan omnichannel.
        if (ag.Login_Date__c == NULL) {
            for (LoginHistory lh : [SELECT Id, LoginTime, LoginType, Status, SourceIp, UserId FROM LoginHistory 
            WHERE UserId =: ag.ownerId and LoginTime = Today //'00528000005eOzRAAU'
            order by id asc limit 1]){
                ag.Login_Date__c = lh.LoginTime;
            }
        }
    } // end for
} // end