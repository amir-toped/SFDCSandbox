@isTest(seeAllData=true)
private class TriggerCase_test {
    static testmethod void cases(){
        Account acc = new Account();
        acc.firstname = 'budi';
        acc.lastname = 'idub';
        acc.duplicate_key__c = 'ketanitem@gmail.com';
        acc.personemail = 'ketanitem@gmail.com';
        acc.recordtypeid = label.recordtype_id;
        insert acc;
        
        Case cs = new Case();
        cs.accountid = acc.id;
        cs.origin = 'Web';
        cs.status = 'New';
        cs.case_created_by__c = 'Customer';
        
        Case cs1 = new Case();
        cs1.Is_Guest__c = 'Yes';
        cs1.Full_Name__c = 'ali oncom';
        cs1.Email_Guest__c = 'sodasusu@gmail.com';
        cs1.origin = 'Web';
        cs1.status = 'New';
        cs1.case_created_by__c = 'Customer';
        
        Account acc2 = [select id, duplicate_key__C, personcontactid,contact__c from account where duplicate_key__C != null limit 1];
       
		Case cs3 = new Case();
        cs3.AccountId = acc2.id;
        cs3.ContactId = acc2.PersonContactId;
        cs3.Contact__c = acc2.Contact__c;
        cs3.Need_Call__c = true;
        cs3.Case_Mobile__c = '62666454444';
        cs3.origin = 'Web';
        cs3.status = 'New';
        cs3.case_created_by__c = 'Customer';
        cs3.Migration__c = false;
        cs3.Subject = 'Kendala Akun';
        cs3.Description = 'Masalah akun';        
        
        
        Test.startTest();
        insert cs;
        insert cs1;
        insert cs3;
        
        cs.Status = 'Closed';
        cs1.Status = 'Closed';
        update cs;
        update cs1;
        Test.stopTest();
    }
    
    static testmethod void cases2(){
        
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
        Case cs1 = cs4.clone(false);
        cs1.Subject = 'pulsa tidak masuk';
        insert cs1;
        Case cs2 = cs4.clone(false);
        cs2.Subject = 'salah mengisi nomor telepon';
        insert cs2;
        Case cs5 = cs4.clone(false);
        cs5.Subject = 'pln';
        insert cs5;
        Case cs6 = cs4.clone(false);
        cs6.Subject = 'air';
        insert cs6;
        Case cs7 = cs4.clone(false);
        cs7.Subject = 'bpjs';
        insert cs7;
        Case cs8 = cs4.clone(false);
        cs8.Subject = 'paket data';
        insert cs8;
        Case cs9 = cs4.clone(false);
        cs9.Subject = 'pengisian pulsa selalu gagal';
        insert cs9;
        Case cs10 = cs4.clone(false);
        cs10.Subject = 'kendala pembayaran & pulsa';
        cs10.Produk_Tokopedia__c = 'pulsa';
        insert cs10;
        
        Test.stopTest();
    }
    
    static testmethod void cases3(){
        
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
        Case cs11 = cs4.clone(false);
        cs11.Subject = 'salah mengirim nomor telepon';
        insert cs11;
        Case cs12 = cs4.clone(false);
        cs12.Subject = 'saldo';
        insert cs12;
        Case cs13 = cs4.clone(false);
        cs13.Subject = 'pln';
        insert cs13;
        Case cs14 = cs4.clone(false);
        cs14.Subject = 'voucher game';
        insert cs14;
        Case cs15 = cs4.clone(false);
        cs15.Subject = 'angsuran kredit';
        insert cs15;
        Case cs16 = cs4.clone(false);
        cs16.Subject = 'donasi';
        insert cs16;
        Case cs17 = cs4.clone(false);
        cs17.Subject = 'pascabayar';
        insert cs17;
        Case cs18 = cs4.clone(false);
        cs18.Subject = 'tv kabel';
        insert cs18;
        Case cs19 = cs4.clone(false);
        cs19.Subject = 'seluler';
        insert cs19;
        Case cs20 = cs4.clone(false);
        cs20.Subject = 'tokocash ';
        cs20.Description = 'kendala transaksi';
        insert cs20;
        
        Test.stopTest();
    }
}