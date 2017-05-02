@isTest(seeAllData=true)
private class TriggerCase_test6 {
	static testmethod void cases16(){
        
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
    
    static testmethod void cases17(){
        
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
    
    static testmethod void cases18(){
        
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
    
    static testmethod void cases19(){
        
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