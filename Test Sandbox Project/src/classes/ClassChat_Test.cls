@isTest(seeAllData=true)
private class ClassChat_Test{
    static testMethod void createOP() {
        Case q = [select id from Case order by createddate desc limit 1];
        ApexPages.StandardController stc = new ApexPages.StandardController(q);
        ApexPages.currentPage().getParameters().put('id',q.id);
        CaseChat classCC = new CaseChat(stc); 
        
        Test.startTest();
        classCC.getChating();
        classCC.Post();
        Test.stopTest();
    }
}