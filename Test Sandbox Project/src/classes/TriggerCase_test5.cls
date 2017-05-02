@isTest(seeAllData=true)
private class TriggerCase_test5 {
	static testmethod void cases13(){
        
        Account acc2 = [select id, duplicate_key__C, personcontactid,contact__c from account where duplicate_key__C != null limit 1];
        
        Case cs4 = new Case();
        cs4.Duplicate_Key__c = acc2.Duplicate_Key__c;
        cs4.origin = 'Web';
        cs4.status = 'New';
        cs4.case_created_by__c = 'Customer';
        cs4.Migration__c = true;
        cs4.Subject = 'testing';
        cs4.Description = 'gagal bayar';
        
        Test.startTest();
        insert cs4;
        Case cs11 = cs4.clone(false);
        cs11.Description = 'kai input voucher';
        insert cs11;
        Case cs12 = cs4.clone(false);
        cs12.Description = 'kritik';
        insert cs12;
        Case cs13 = cs4.clone(false);
        cs13.Description = 'input voucher';
        insert cs13;
        Test.stopTest();
    }
    
    static testmethod void cases14(){
        
        Account acc2 = [select id, duplicate_key__C, personcontactid,contact__c from account where duplicate_key__C != null limit 1];
        
        Case cs4 = new Case();
        cs4.Duplicate_Key__c = acc2.Duplicate_Key__c;
        cs4.origin = 'Web';
        cs4.status = 'New';
        cs4.case_created_by__c = 'Customer';
        cs4.Migration__c = true;
        cs4.Subject = 'testing';
        cs4.Description = 'gagal bayar';
        
        Test.startTest();
        insert cs4;
        Case cs8 = cs4.clone(false);
        cs8.Description = 'hack';
        insert cs8;
        Case cs9 = cs4.clone(false);
        cs9.Description = 'blok';
        insert cs9;
        Case cs10 = cs4.clone(false);
        cs10.Description = 'pishing';
        insert cs10;
        Test.stopTest();
    }
    
    static testmethod void cases15(){
        
        Account acc2 = [select id, duplicate_key__C, personcontactid,contact__c from account where duplicate_key__C != null limit 1];
        
        Case cs4 = new Case();
        cs4.Duplicate_Key__c = acc2.Duplicate_Key__c;
        cs4.origin = 'Web';
        cs4.status = 'New';
        cs4.case_created_by__c = 'Customer';
        cs4.Migration__c = true;
        cs4.Subject = 'testing';
        cs4.Description = 'gagal bayar';
        
        Test.startTest();
        insert cs4;
        Case cs8 = cs4.clone(false);
        cs8.Description = 'logo gm';
        insert cs8;
        Case cs9 = cs4.clone(false);
        cs9.Description = 'topads';
        insert cs9;
        Case cs10 = cs4.clone(false);
        cs10.Description = 'iklan topads';
        insert cs10;
        Case cs1 = cs4.clone(false);
        cs1.Description = 'gm';
        insert cs1;
        Test.stopTest();
    }
}