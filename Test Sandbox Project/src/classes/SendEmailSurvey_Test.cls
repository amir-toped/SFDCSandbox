@isTest
public class SendEmailSurvey_Test {
	static testmethod void TestAutoClosed(){
        Test.startTest();
        String que = 'select id, name, status__C, ready_to_send__c from email_log__C limit 1';
        SendEmailSurvey autocloseChat = new SendEmailSurvey(que);
        Database.executeBatch(autocloseChat, 1);
        Test.stopTest();
    }
}