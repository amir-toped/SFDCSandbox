trigger shift_calctime on Agent_Shift__c (Before Insert, Before Update) {
    for (Agent_Shift__c tsk : trigger.new){
        DateTime StartTime = DateTime.newInstance(tsk.Document_Date__c.Year(), tsk.Document_Date__c.Month(), 1, integer.valueof(tsk.Start_Hour__c), integer.valueof(tsk.Start_Minute__c), 0);
        DateTime StartLogin = DateTime.newInstance(tsk.Document_Date__c.Year(), tsk.Document_Date__c.Month(), 1, integer.valueof(tsk.Start_Hour__c)-2, integer.valueof(tsk.Start_Minute__c), 0);
        DateTime LastLogin = DateTime.newInstance(tsk.Document_Date__c.Year(), tsk.Document_Date__c.Month(), 1, integer.valueof(tsk.Start_Hour__c), integer.valueof(tsk.Start_Minute__c)+15, 0);
        //DateTime.newInstance(tsk.Document_Date__c.Year(), tsk.Document_Date__c.Month(), 1, tsk.Start_Hour__c, tsk.Start_Minute__c, 0); //Shift1Start;
        
        DateTime EndTime;
        DateTime EndLogout;
        if (tsk.End_Next_Day__c) {
            EndTime = DateTime.newInstance(tsk.Document_Date__c.Year(), tsk.Document_Date__c.Month(), 2, integer.valueof(tsk.End_Hour__c), integer.valueof(tsk.End_Minute__c), 0); //Shift1Start;
            EndLogout = DateTime.newInstance(tsk.Document_Date__c.Year(), tsk.Document_Date__c.Month(), 2, integer.valueof(tsk.End_Hour__c)+2, integer.valueof(tsk.End_Minute__c), 0); //Shift1Start;
        }
        else {
            EndTime = DateTime.newInstance(tsk.Document_Date__c.Year(), tsk.Document_Date__c.Month(), 1, integer.valueof(tsk.End_Hour__c), integer.valueof(tsk.End_Minute__c), 0); //Shift1Start;
            EndLogout = DateTime.newInstance(tsk.Document_Date__c.Year(), tsk.Document_Date__c.Month(), 1, integer.valueof(tsk.End_Hour__c)+2, integer.valueof(tsk.End_Minute__c), 0); //Shift1Start;
        }
            
        tsk.Start_Time__c = StartTime;
        tsk.End_Time__c = EndTime;

        tsk.Start_Login__c = StartLogin;
        tsk.End_Logout__c = EndLogout;

        tsk.Last_Login__c = LastLogin;

    } // end for
} // end trigger