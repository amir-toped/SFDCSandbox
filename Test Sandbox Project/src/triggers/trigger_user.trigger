trigger trigger_user on User (before insert, before update) {
    for(User x:trigger.new){
        if(x.Signature__c==null){
            x.Signature__c = label.signature;
            x.Signature_copy__c = label.signature;
        }
        else{
            x.Signature_copy__c = x.Signature__c;
        }
    }
}