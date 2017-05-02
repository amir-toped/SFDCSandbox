@isTest
public class AutoClosedBatchCaseChat_Test {
	static testmethod void TestAutoClosed(){
        Test.startTest();
        String que = 'select id, user__c, account__C, case__C, duration__c, createddate from case_chat__C limit 1 '  ;
        AutoClosedBatchCaseChat autocloseChat = new AutoClosedBatchCaseChat(que);
        Database.executeBatch(autocloseChat, 1);
        Test.stopTest();
    }
}