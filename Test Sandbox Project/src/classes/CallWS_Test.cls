@isTest(seeAllData=true)
private class CallWS_Test {
    static testMethod void WS() {
        Account acc = new Account();
        acc.firstname = 'budi';
        acc.lastname = 'idub';
        acc.duplicate_key__c = 'sodasusu@gmail.com';
        acc.personemail = 'sodasusu@gmail.com';
        acc.recordtypeid = label.recordtype_id;
        insert acc;
        
        Case cs = new Case();
        cs.accountid = acc.id;
        cs.origin = 'Web';
        cs.status = 'New';
        cs.case_created_by__c = 'Customer';
        insert cs;
        Test.startTest();
        CallWS.getData(label.url_read, cs.id, acc.id);
        Test.stopTest();
    }
}