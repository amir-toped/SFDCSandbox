@isTest(seeAllData=true)
public class ObjCaseMigration_test {
    static testmethod void cases(){
        Test.startTest();
        
        Account acc2 = [select id, duplicate_key__C, personcontactid,contact__c from account where duplicate_key__C != null limit 1];
       
        Case cs3 = new Case();
        cs3.Duplicate_Key__c = acc2.Duplicate_Key__c;
        cs3.Tiket_ID__c = '1234';
        cs3.origin = 'Web';
        cs3.status = 'New';
        cs3.case_created_by__c = 'Customer';
        cs3.Migration__c = true;
        cs3.Subject = 'Kendala Akun';
        cs3.Description = 'Masalah akun';        
        
        insert cs3;
        
        Test.stopTest();
    }
    
}