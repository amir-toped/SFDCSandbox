@isTest(seeAllData=true)
private class ClassCase_Test {
    static testmethod void sendemail(){
        Case cs = [select id from case where accountid != null and account.personemail!=null limit 1];
        Test.startTest();
        class_case.sendEmail(cs.id);
        Test.stopTest();
    }
    static testmethod void sendemail2(){
        //Case cs = [select id from case where accountid != null and account.personemail!=null limit 1];
        Case_Chat__c cc = [select id from case_chat__c where user__c!=null limit 1];
        Test.startTest();
        class_case.sendEmailCaseChat(cc.id);
        Test.stopTest();
    }
}