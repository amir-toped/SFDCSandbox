public with sharing class AgentAttendance{
    private Final User opp;
    public List<Agent_Attendance__c> lstDel{get; set;}
    public Agent_Attendance__c ag{get; set;}
    public String LoginTime {get; set;}
    public String LogOutTime {get; set;}
    public String idprospect{
        get {
            return this.opp.id;
        }
        private set;
    }
   
    public AgentAttendance(ApexPages.StandardController std){
        this.opp = (User)std.getRecord();
        
        date thisday = date.Today();
        
        lstDel = [SELECT id, Login_Date__c, Logout_Date__c FROM Agent_Attendance__c WHERE OwnerId =:UserInfo.getUserId() //opp.id 
            and Attendance_Date__c =: thisday
            //Start_Login__c 
            limit 1
        ];
        LoginTime = '';
        LogOutTime = '';
        
        if (lstDel.size()> 0) LoginTime = lstDel[0].Login_Date__c.format('MM/dd/yy HH:mm a');//GMT;
        if (lstDel.size()> 0) if (lstDel[0].Logout_Date__c != NULL) LogOutTime = lstDel[0].Logout_Date__c.format('MM/dd/yy HH:mm a');//GMT;
        //System.Now().format('MM/dd/yy HH:mm a', 'PST');//GMT

        
//        lstDel = [SELECT Id, Name, PIC_2_Phone__c, PIC_2_Name__c, PIC_1_Owner_Phone__c, PIC1_Owner_Name__c, 
//                        PIC_UT_Phone__c, PIC_UT_Name__c, BC_Notes__c, Operating_unit_location__c, SPB_Notes__c, 
//                        S_Loc__c,
//                        Rec_Plant__c, Material__c, Serial_Number__c, WithOut_Forwader__c, SAP_ID__c, Status__c
//                    FROM Agent_Attendance__c WHERE User=:this.opp.id];
    }
    
    Public PageReference Save(){
        Savepoint spoint = Database.setSavepoint();
        try{
            List<Agent_Attendance__c> newppd = new List<Agent_Attendance__c>();
            Integer x=0;
            String SAPID = '';
            for(Agent_Attendance__c ppd:lstDel){

            }
            
            if(newppd.size()>0){ 
                update newppd;
                if(!Test.isRunningTest()){
                }
            }
            
            return null;
        }catch(System.DmlException e){
            Database.rollback(spoint); 
            return null;
        }
    }
        
    Public PageReference btnlogoff(){
        Savepoint spoint = Database.setSavepoint();
        try{
            if (lstDel.size() > 0) {
                lstDel[0].Logout_Date__c = Datetime.now();
                update lstDel;
            }
            else {
                Agent_Attendance__c newAtt = new Agent_Attendance__c();
                newAtt.OwnerId = UserInfo.getUserId();
                newAtt.Attendance_Date__c = date.today();
                newAtt.Logout_Date__c = Datetime.now();
                insert newAtt;
            }
            return null;
        }catch(System.DmlException e){
            Database.rollback(spoint); 
            System.debug('Error - VP AgentAttendance');
            return null;
        }
    }

    Public PageReference btnlogin(){
        Savepoint spoint = Database.setSavepoint();
        try{

            return null;
        }catch(System.DmlException e){
            Database.rollback(spoint); 
            return null;
        }
    }

    Public PageReference SubmitApproval(){
        Savepoint spoint = Database.setSavepoint();
        try{
            Id userid = UserInfo.getUserId();
            integer i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            
            for(Agent_Attendance__c ppd:lstDel){

            }
            return null;
        }catch(System.DmlException e){
            Database.rollback(spoint); 
            return null;
        }
    }

}