trigger trigger_invoice on Invoice__c (after insert) {
    for(Invoice__c x:trigger.new){
        if(x.account__c!= null){
            Account acc = [select customer_status__c from account where id =: x.account__c];
            acc.customer_status__c = 'Regular';
            update acc;
        }
    }
}