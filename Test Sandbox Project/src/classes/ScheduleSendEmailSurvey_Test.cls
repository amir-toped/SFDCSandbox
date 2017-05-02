@isTest(seeAllData=true)
private class ScheduleSendEmailSurvey_Test {
	static testMethod void SchTesting(){
        Test.startTest();
        ScheduleSendEmailSurvey sbdos = new ScheduleSendEmailSurvey();
        sbdos.execute(null);
        Test.stopTest();
    }
}