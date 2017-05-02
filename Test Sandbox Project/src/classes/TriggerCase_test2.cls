@isTest(seeAllData=true)
private class TriggerCase_test2 {
	static testmethod void cases4(){
        
        Account acc2 = [select id, duplicate_key__C, personcontactid,contact__c from account where duplicate_key__C != null limit 1];
        
        Case cs4 = new Case();
        cs4.Duplicate_Key__c = acc2.Duplicate_Key__c;
        cs4.origin = 'Web';
        cs4.status = 'New';
        cs4.case_created_by__c = 'Customer';
        cs4.Migration__c = true;
        cs4.Subject = 'kode booking tidak valid';
        cs4.Description = 'booking';
        
        Test.startTest();
        insert cs4;
        Case cs21 = cs4.clone(false);
        cs21.Subject = 'tokocash';
        cs21.Description = 'kendala top up';
        insert cs21;
        Case cs22 = cs4.clone(false);
        cs22.Subject = 'tokocash';
        cs22.Description = 'penerimaan dana';
        insert cs22;
        Case cs23 = cs4.clone(false);
        cs23.Subject = 'tokocash';
        cs23.Description = 'pengiriman dana';
        insert cs23;
        Case cs24 = cs4.clone(false);
        cs24.Subject = 'tokocash';
        insert cs24;
        Case cs25 = cs4.clone(false);
        cs25.Subject = 'pembelian tiket gagal';
        insert cs25;
        Case cs26 = cs4.clone(false);
        cs26.Subject = 'pencarian tiket gagal';
        insert cs26;
        Case cs27 = cs4.clone(false);
        cs27.Subject = 'transaksi dengan kode voucher gagal';
        insert cs27;
        Test.stopTest();
    }
    
    static testmethod void cases5(){
        
        Account acc2 = [select id, duplicate_key__C, personcontactid,contact__c from account where duplicate_key__C != null limit 1];
        
        Case cs4 = new Case();
        cs4.Duplicate_Key__c = acc2.Duplicate_Key__c;
        cs4.origin = 'Web';
        cs4.status = 'New';
        cs4.case_created_by__c = 'Customer';
        cs4.Migration__c = true;
        cs4.Subject = 'testing';
        cs4.Description = 'salah';
        
        Test.startTest();
        insert cs4;
        Case cs5 = cs4.clone(false);
        cs5.Description = 'otp';
        insert cs5;
        Case cs6 = cs4.clone(false);
        cs6.Description = 'ganti hp ubah hp';
        insert cs6;
        Case cs7 = cs4.clone(false);
        cs7.Description = 'lupa password kata sandi';
        
        Test.stopTest();
    }
    
    static testmethod void cases6(){
        
        Account acc2 = [select id, duplicate_key__C, personcontactid,contact__c from account where duplicate_key__C != null limit 1];
        
        Case cs4 = new Case();
        cs4.Duplicate_Key__c = acc2.Duplicate_Key__c;
        cs4.origin = 'Web';
        cs4.status = 'New';
        cs4.case_created_by__c = 'Customer';
        cs4.Migration__c = true;
        cs4.Subject = 'testing';
        cs4.Description = 'penipuan';
        
        Test.startTest();
        insert cs4;
        Case cs5 = cs4.clone(false);
        cs5.Description = 'kendala teknis akun';
        insert cs5;
        Case cs6 = cs4.clone(false);
        cs6.Description = 'statistik gm';
        insert cs6;
        Case cs7 = cs4.clone(false);
        cs7.Description = 'gm belum aktif';
        insert cs7;
        
        Test.stopTest();
    }
}