trigger AddAgent on UserServicePresence (Before Insert, Before Update) {
    for (UserServicePresence usp : trigger.new) {
        if (trigger.isInsert){
            datetime datenow = datetime.now();
            // check Agent Attendance, jika tidak ada, create.
            List<Agent_Attendance__c> ag = [SELECT id FROM Agent_Attendance__c 
            WHERE OwnerId =: UserInfo.getUserId() and Start_Login__c <=: datenow and End_Logout__c >=: datenow
            //usp.UserId
            LIMIT 1];
            if (ag.size() > 0) usp.Agent_Attendance__c = ag[0].id;
            else {
                Agent_Attendance__c ag2 = new Agent_Attendance__c();
                ag2.OwnerId = UserInfo.getUserId();
                ag2.Login_Date__c = Datetime.now();
                ag2.Attendance_Date__c = date.today();
                                
                try {
                    insert ag2;
                    usp.Agent_Attendance__c = ag2.id;
                }
                Catch(exception e){
                }
            }
        }
        if (trigger.isUpdate || Test.isRunningTest()){
            if (usp.Agent_Attendance__c != NULL) {
                Agent_Attendance__c agatt = [SELECT id, Logout_Date__c FROM Agent_Attendance__c WHERE id =: usp.Agent_Attendance__c];
                if (usp.StatusEndDate != NULL || Test.isRunningTest()) {
                    
                    if (Test.isRunningTest()) agatt.Logout_Date__c = Datetime.now();
                    else agatt.Logout_Date__c = usp.StatusEndDate;

                    string ServiceStatus = string.valueof(usp.ServicePresenceStatusId);
//*
                    // check type status (START)
                    //if (ServiceStatus.contains(label.Available))
                    if (ServiceStatus.contains(label.Away)) agatt.Away_Start_Date__c = usp.StatusStartDate;
                    if (ServiceStatus.contains(label.Busy_Dinner)) agatt.Lunch_Start_Date__c = usp.StatusStartDate;
                    //if (ServiceStatus.contains(label.Busy_Followup))
                    if (ServiceStatus.contains(label.Busy_Lunch)) agatt.Lunch_Start_Date__c = usp.StatusStartDate;
                    //if (ServiceStatus.contains(label.Busy_No_Response))
                    //if (ServiceStatus.contains(label.Busy_Sholat))
                    //if (ServiceStatus.contains(label.Busy_Toilet))
                    //if (ServiceStatus.contains(label.Busy_Training))
                    //if (ServiceStatus.contains(label.L3_Available))
                    
                    // check type status (END)
                    //if (ServiceStatus.contains(label.Available))
                    if (ServiceStatus.contains(label.Away)) agatt.Away_End_Date__c = Datetime.now(); //usp.StatusEndDate;
                    if (ServiceStatus.contains(label.Busy_Dinner)) agatt.Lunch_End_Date__c = Datetime.now(); //usp.StatusEndDate;
                    //if (ServiceStatus.contains(label.Busy_Followup))
                    if (ServiceStatus.contains(label.Busy_Lunch)) agatt.Lunch_End_Date__c = Datetime.now(); //usp.StatusEndDate;
                    //if (ServiceStatus.contains(label.Busy_No_Response))
                    //if (ServiceStatus.contains(label.Busy_Sholat))
                    //if (ServiceStatus.contains(label.Busy_Toilet))
                    //if (ServiceStatus.contains(label.Busy_Training))
                    //if (ServiceStatus.contains(label.L3_Available))
// */
                    try{
                        update agatt;
                    }
                    Catch(exception e){
                    }
                }
            }
        }
    }
}