@isTest(seeAllData=true)
private class ScheduleAutoClosed_Test {
    static testMethod void SchTesting(){
        Test.startTest();
        ScheduleAutoClosed sbdos = new ScheduleAutoClosed();
        sbdos.execute(null);
        Test.stopTest();
    }
}