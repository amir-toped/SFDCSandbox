@isTest(seeAllData=true)
public class PublicArticleServiceTest {
    static testmethod void pasTest() {
        Test.startTest();
        
    	String ERROR = 'error';
        
        Help_Center__kav hc = new Help_Center__kav();
        hc.Title = 'Title 1';
        hc.Summary = 'Summary 1';
        hc.UrlName = 'Title-1';
        hc.Body__c = 'Body 1';
        insert hc;
        
        Help_Center_Article__c hca = new Help_Center_Article__c();
        hca.Id_SF__c = 'kA1N00000008ytlKAA';
        hca.Id_WP__c = '202';
        hca.Sync_Status__c = ERROR;
        insert hca;
        
        Help_Center__kav hc2 = new Help_Center__kav();
        hc2.Title = 'Title 2';
        hc2.Summary = 'Summary 2';
        hc2.UrlName = 'Title-2';
        hc2.Body__c = 'Body 2';
        insert hc2;
        
        DescribeSObjectResult describeResultHca = Help_Center_Article__c.getSObjectType().getDescribe();
        List<String> hcaFieldList = new List<String>(describeResultHca.fields.getMap().keySet());
        String hcaFields = String.join(hcaFieldList, ',');
        String qError = 'SELECT ' + hcaFields + ' FROM Help_Center_Article__c LIMIT 1';
        PublicArticleErrorBatch paError = new PublicArticleErrorBatch(qError);
        
        SchedulePublicArticleService spas = new SchedulePublicArticleService();
        spas.execute(null);
        
        SchedulePublicArticleManual.syncManual();
        Test.stopTest();
    }
}