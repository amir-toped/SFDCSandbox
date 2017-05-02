@isTest(seeAllData=true)
private class TriggerCase_test4 {
	static testmethod void cases10(){
        
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
        Case cs5 = cs4.clone(false);
        cs5.Description = 'tidak bisa kartu kredit';
        insert cs5;
        Case cs6 = cs4.clone(false);
        cs6.Description = 'klik bca';
        insert cs6;
        Case cs7 = cs4.clone(false);
        cs7.Description = 'withdraw';
        insert cs7;
        Test.stopTest();
    }
    
    static testmethod void cases11(){
        
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
        Case cs9 = cs4.clone(false);
        cs9.Description = 'kota pengiriman';
        insert cs9;
        Case cs10 = cs4.clone(false);
        cs10.Description = 'bpjs input voucher';
        insert cs10;
        Test.stopTest();
    }
    
    static testmethod void cases12(){
        
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
}