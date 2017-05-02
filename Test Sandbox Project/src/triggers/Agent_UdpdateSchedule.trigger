trigger Agent_UdpdateSchedule on Agent_Attendance__c (after Insert, after Update) {
    for (Agent_Attendance__c ag : trigger.new) {
        integer tgl = ag.Attendance_Date__c.day();
        String Status = ag.Login_Status__c;
        id ScheduleID = ag.Agent_Scheduling__c;
        //triggerfuture.AgentAttSchedule(Id DataId, Integer day, String DataStatus);
        triggerfuture.AgentAttSchedule(ScheduleID, tgl, Status);
    }
}