@isTest(seeAllData=true)
private class TriggerCase_test3 {
	static testmethod void cases7(){
        
        Account acc2 = [select id, duplicate_key__C, personcontactid,contact__c from account where duplicate_key__C != null limit 1];
        
        Case cs4 = new Case();
        cs4.Duplicate_Key__c = acc2.Duplicate_Key__c;
        cs4.origin = 'Web';
        cs4.status = 'New';
        cs4.case_created_by__c = 'Customer';
        cs4.Migration__c = true;
        cs4.Subject = 'testing';
        cs4.Description = 'topads tidak terkirim';
        
        Test.startTest();
        insert cs4;
        Case cs5 = cs4.clone(false);
        cs5.Description = 'iklan belum muncul';
        insert cs5;
        Case cs6 = cs4.clone(false);
        cs6.Description = 'produk tidak aktif';
        insert cs6;
        Case cs7 = cs4.clone(false);
        cs7.Description = 'kredit belum bertambah';
        insert cs7;
        Case cs8 = cs4.clone(false);
        cs8.Description = 'admin toko';
        insert cs8;
        Case cs9 = cs4.clone(false);
        cs9.Description = 'etalase produk hilang';
        insert cs9;
        Case cs10 = cs4.clone(false);
        cs10.Description = 'etalase hilang';
        insert cs10;
        
        Test.stopTest();
    }
    
    static testmethod void cases8(){
        
        Account acc2 = [select id, duplicate_key__C, personcontactid,contact__c from account where duplicate_key__C != null limit 1];
        
        Case cs4 = new Case();
        cs4.Duplicate_Key__c = acc2.Duplicate_Key__c;
        cs4.origin = 'Web';
        cs4.status = 'New';
        cs4.case_created_by__c = 'Customer';
        cs4.Migration__c = true;
        cs4.Subject = 'testing';
        cs4.Description = 'free return produk tidak aktif';
        
        Test.startTest();
        insert cs4;
        Case cs5 = cs4.clone(false);
        cs5.Description = 'free return berhenti berlangganan';
        insert cs5;
        Case cs6 = cs4.clone(false);
        cs6.Description = 'etalase produk tidak muncul';
        insert cs6;
        Case cs7 = cs4.clone(false);
        cs7.Description = 'gambar produk';
        insert cs7;
        Case cs8 = cs4.clone(false);
        cs8.Description = 'gagal upload produk';
        insert cs8;
        Case cs9 = cs4.clone(false);
        cs9.Description = 'produk dihapus';
        insert cs9;
        Case cs10 = cs4.clone(false);
        cs10.Description = 'pengawasan';
        insert cs10;
        
        Test.stopTest();
    }
    
    static testmethod void cases9(){
        
        Account acc2 = [select id, duplicate_key__C, personcontactid,contact__c from account where duplicate_key__C != null limit 1];
        
        Case cs4 = new Case();
        cs4.Duplicate_Key__c = acc2.Duplicate_Key__c;
        cs4.origin = 'Web';
        cs4.status = 'New';
        cs4.case_created_by__c = 'Customer';
        cs4.Migration__c = true;
        cs4.Subject = 'testing';
        cs4.Description = 'kolom pencarian';
        
        Test.startTest();
        insert cs4;
        Case cs5 = cs4.clone(false);
        cs5.Description = 'presentase transaksi';
        insert cs5;
        Case cs6 = cs4.clone(false);
        cs6.Description = 'poin reputasi';
        insert cs6;
        Case cs7 = cs4.clone(false);
        cs7.Description = 'produk terjual';
        insert cs7;
        Case cs8 = cs4.clone(false);
        cs8.Description = 'transaksi berhasil statistik';
        insert cs8;
        Case cs9 = cs4.clone(false);
        cs9.Description = 'smiley';
        insert cs9;
        Case cs10 = cs4.clone(false);
        cs10.Description = 'kota asal belum tersedia';
        insert cs10;
        
        Test.stopTest();
    }
}