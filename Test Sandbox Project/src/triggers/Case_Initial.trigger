trigger Case_Initial on Case (Before insert) {
    for (case cs : trigger.new){
        if (cs.Contact_Id__c != NULL && cs.Contact_Id__c != '')
        cs.Contact__c = cs.Contact_Id__c;
    }
}