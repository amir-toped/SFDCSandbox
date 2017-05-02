@isTest(seeAllData=true)
private class CaseChat_Obj_test {
	static testMethod void casecomment() {
        Case q = [select id, accountid, account_email__C, tiket_id__c from Case where accountid != null and tiket_id__c!=null and account_email__C != null order by createddate desc limit 1];
        user usr = [select id, email from user limit 1];
        Case_Chat__c cc1 = new Case_Chat__c(); 
        Case_Chat__c cc2 = new Case_Chat__c();
        Case_Chat__C cc3 = new Case_Chat__c();
        Case_Chat__C cc4 = new Case_Chat__c();
        Test.startTest();
        cc1.Case__c = q.id;
        cc1.Account__c = q.AccountId;
        cc1.Messages2__c = 'text';
        cc1.Migration__c = false;
        insert cc1;
        cc1.Migration__c = true;
        update cc1;
        cc2.Case__c = q.id;
        cc2.user__c = usr.Id;
        cc2.Messages2__c = 'text';
        cc2.Migration__c = false;
        insert cc2;
        cc2.Migration__c = true;
        update cc2;
        cc3.Tiket_ID__c = q.Tiket_ID__c;
        cc3.Duplicate_Key__c = q.Account_Email__c;
        cc3.Messages2__c = 'text';
        cc3.Migration__c = true;
        insert cc3;
        cc4.Tiket_ID__c = q.Tiket_ID__c;
        cc4.Agent_Email__c = usr.Email;
        cc4.Messages2__c = 'text';
        cc4.Migration__c = true;
        insert cc4;
        Test.stopTest();
    }
}