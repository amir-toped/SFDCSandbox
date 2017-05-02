trigger Tsk_Initial on Task (Before Update) {
    if (trigger.isUpdate) {
        for (task tsk : trigger.new){
            if (tsk.WhoId != NULL) {
                for (contact ct : [SELECT id, Person_Account__c FROM Contact WHERE id=:tsk.WhoId]){
                    if (ct.Person_Account__c != NULL) tsk.WhatId = ct.Person_Account__c;
                }
            }
            
            // check comment, apakah ada nomor Case
            
            Integer result = 0;
            if (tsk.Description != NULL)
            result = tsk.Description.indexOf('cs:');
            if (result > 0) tsk.Case_Number__c = tsk.Description.substring(result+3,result+8+3);
            for (case cs : [SELECT id FROM Case WHERE CaseNumber=:tsk.Case_Number__c]){
                tsk.Case__c = cs.id;
            }
        }
    }
}