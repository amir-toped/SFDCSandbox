trigger QAN_ShareData on QA_Agent_Answer__c (After Update) {
    for (QA_Agent_Answer__c QAN : trigger.new){
        if (QAN.Share_to_Capt__c && !Trigger.oldMap.get(QAN.Id).Share_to_Capt__c) { if(!system.isFuture()) TriggerFuture.ShareAgentAnwer(QAN.id, QAN.Manager__c, trigger.old[0].Manager__c, 'Edit'); }
        else if (!QAN.Share_to_Capt__c && Trigger.oldMap.get(QAN.Id).Share_to_Capt__c) { if(!system.isFuture()) TriggerFuture.UnShareAgentAnwer(QAN.id, QAN.Manager__c, trigger.old[0].Manager__c, 'Edit'); }

        if (QAN.Share_to_User_Agent__c && !Trigger.oldMap.get(QAN.Id).Share_to_User_Agent__c  ) { if(!system.isFuture()) TriggerFuture.ShareAgentAnwer(QAN.id, QAN.User_Agent__c, trigger.old[0].User_Agent__c, 'Read'); }
        else if (!QAN.Share_to_User_Agent__c && Trigger.oldMap.get(QAN.Id).Share_to_User_Agent__c   ) { if(!system.isFuture()) TriggerFuture.UnShareAgentAnwer(QAN.id, QAN.User_Agent__c, trigger.old[0].User_Agent__c, 'Read'); }

    }
}