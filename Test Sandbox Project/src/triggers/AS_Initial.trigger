trigger AS_Initial on Agent_Scheduling__c (Before Insert, Before Update) {
    for (Agent_Scheduling__c tsk : trigger.new){
        tsk.Ext_Id__c = tsk.Agent__c+'-'+tsk.Periode__c;
        //tsk.Agent_Shift_1__c = label.AgShift01;
        //tsk.Agent_Shift_2__c = label.AgShift02;
        //tsk.Agent_Shift_3__c = label.AgShift03;
        //tsk.Agent_Shift_4__c = label.AgShift04;
        //tsk.Agent_Shift_oh__c = label.AgShiftOH;
    } // end for
} // end trigger