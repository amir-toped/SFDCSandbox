@isTest(seeAllData=true)
public class ObjCase_test4 {
    static testmethod void casetest4() {
        Test.startTest();
        Account acc = new Account();
        acc.firstname = 'budi';
        acc.lastname = 'idub';
        acc.duplicate_key__c = 'ketanitem@gmail.com';
        acc.personemail = 'ketanitem@gmail.com';
        acc.recordtypeid = label.recordtype_id;
        insert acc;
		
		Contact con = new Contact();
        con.firstname = 'budi';
        con.lastname = 'idub';
        con.email = 'ketanijo@gmail.com';
        insert con;
        
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
        
        Case cs2 = new Case();
        cs2.contactid = con.id;
        cs2.origin = 'Web';
        cs2.status = 'New';
        cs2.case_created_by__c = 'Customer';
        
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
        
        insert cs3;
        Test.stopTest();
    }
}