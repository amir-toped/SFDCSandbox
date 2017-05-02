@isTest(seeAllData=true)
private class ResponseQuestionFromEmail_Test {
    static testMethod void SchTesting(){
        Case cs = [select id, accountid from case limit 1];
        //ApexPages.currentPage().getParameters().put('srvid',label.Survey_ID	);
        //ApexPages.currentPage().getParameters().put('srvqid',label.Survey_Question_ID);
        //ApexPages.currentPage().getParameters().put('accid',cs.AccountId);
        //ApexPages.currentPage().getParameters().put('caseid',cs.id);
        //ApexPages.currentPage().getParameters().put('answer','1');
        Test.startTest();
        ResponseQuestionFromEmail sbdos = new ResponseQuestionFromEmail();
        sbdos.response();
        Test.stopTest();
    }
}