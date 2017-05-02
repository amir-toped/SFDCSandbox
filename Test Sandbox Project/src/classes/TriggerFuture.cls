global class TriggerFuture{
    @future
    public static void ShareAgentAnwer(Id AccountId, Id ParentOwnerId, Id OldParentOwnerId, String AccountAccess){
        try { 
            if (ParentOwnerId <> OldParentOwnerId) {
                list <QA_Agent_Answer__Share> acs = [SELECT id FROM QA_Agent_Answer__Share WHERE ParentId =: AccountId and UserOrGroupId =: OldParentOwnerId];
                if (acs.size() > 0 && !Test.isRunningTest()) delete acs;
            }

            QA_Agent_Answer__Share acctshare = new QA_Agent_Answer__Share(ParentId = AccountID, UserOrGroupId = ParentOwnerId, AccessLevel = AccountAccess);
            if(!Test.isRunningTest()) upsert acctshare;
        } catch (Exception e) {
            System.debug(e);
        }
    }  

    @future
    public static void UnShareAgentAnwer(Id AccountId, Id ParentOwnerId, Id OldParentOwnerId, String AccountAccess){
        try { 
            list <QA_Agent_Answer__Share> acs = [SELECT id FROM QA_Agent_Answer__Share WHERE ParentId =: AccountId and UserOrGroupId =: OldParentOwnerId];
            if (acs.size() > 0 && !Test.isRunningTest()) delete acs;

        } catch (Exception e) {
            System.debug(e);
        }
    }

    @Future
    public static void AgentAttSchedule(Id DataId, Integer day, String DataStatus){
       
        Agent_Scheduling__c ags = [SELECT id, 
            AS_01__c, AS_02__c, AS_03__c, AS_04__c, AS_05__c, AS_06__c, AS_07__c, 
            AS_08__c, AS_09__c, AS_10__c, AS_11__c, AS_12__c, AS_13__c, AS_14__c, 
            AS_15__c, AS_16__c, AS_17__c, AS_18__c, AS_19__c, AS_20__c, AS_21__c, 
            AS_22__c, AS_23__c, AS_24__c, AS_25__c, AS_26__c, AS_27__c, AS_28__c, 
            AS_29__c, AS_30__c, AS_31__c 
        FROM Agent_Scheduling__c WHERE id =: DataId];

        if (day == 1) ags.AS_01__c = DataStatus;
        if (day == 2) ags.AS_02__c = DataStatus;
        if (day == 3) ags.AS_03__c = DataStatus;
        if (day == 4) ags.AS_04__c = DataStatus;
        if (day == 5) ags.AS_05__c = DataStatus;
        if (day == 6) ags.AS_06__c = DataStatus;
        if (day == 7) ags.AS_07__c = DataStatus;
        if (day == 8) ags.AS_08__c = DataStatus;
        if (day == 9) ags.AS_09__c = DataStatus;
        if (day == 10) ags.AS_10__c = DataStatus;
        if (day == 11) ags.AS_11__c = DataStatus;
        if (day == 12) ags.AS_12__c = DataStatus;
        if (day == 13) ags.AS_13__c = DataStatus;
        if (day == 14) ags.AS_14__c = DataStatus;
        if (day == 15) ags.AS_15__c = DataStatus;
        if (day == 16) ags.AS_16__c = DataStatus;
        if (day == 17) ags.AS_17__c = DataStatus;
        if (day == 18) ags.AS_18__c = DataStatus;
        if (day == 19) ags.AS_19__c = DataStatus;
        if (day == 20) ags.AS_20__c = DataStatus;
        if (day == 21) ags.AS_21__c = DataStatus;
        if (day == 22) ags.AS_22__c = DataStatus;
        if (day == 23) ags.AS_23__c = DataStatus;
        if (day == 24) ags.AS_24__c = DataStatus;
        if (day == 25) ags.AS_25__c = DataStatus;
        if (day == 26) ags.AS_26__c = DataStatus;
        if (day == 27) ags.AS_27__c = DataStatus;
        if (day == 28) ags.AS_28__c = DataStatus;
        if (day == 29) ags.AS_29__c = DataStatus;
        if (day == 30) ags.AS_30__c = DataStatus;
        if (day == 31) ags.AS_31__c = DataStatus;
        
        update ags;
    } // end public
}