global class SchedulePublicArticleService implements Schedulable {    
    private static final String HC_ONLINE = 'Online';
    private static final String HC_DRAFT = 'Draft';
    private static final String HC_ARCHIVED = 'Archived';
    private static final String EN_US = 'en_US';
    private static final String PUBLISH = 'publish';
    private static final String DRAFT = 'draft';
    private static final String CLOSED = 'closed';
    private static final String POST = 'post';
    private static final String ERROR = 'error';
    
    global void execute(SchedulableContext sc) {
        Date todayDate = Date.today();
		Datetime todayDatetime = Datetime.newInstanceGmt(todayDate.year(), todayDate.month(), todayDate.day(), 0, 0, 0);
        DescribeSObjectResult describeResultHc = Help_Center__kav.getSObjectType().getDescribe();
        List<String> hcFieldList = new List<String>(describeResultHc.fields.getMap().keySet());
        String hcFields = String.join(hcFieldList, ',');
        String q = '';
        
        //PUBLISH
        if (Test.isRunningTest()) {
        	q = ' SELECT ' + hcFields + ', (SELECT DataCategoryName FROM DataCategorySelections) FROM Help_Center__kav WHERE PublishStatus = :HC_ONLINE AND language = :EN_US AND LastModifiedDate > :todayDatetime LIMIT 1 ';
        }
        else {
            q = ' SELECT ' + hcFields + ', (SELECT DataCategoryName FROM DataCategorySelections) FROM Help_Center__kav WHERE PublishStatus = :HC_ONLINE AND language = :EN_US AND LastModifiedDate > :todayDatetime ';
        }
        PublicArticleBatch pabOnline = new PublicArticleBatch(q);
        Database.executeBatch(pabOnline, 1);
        
        //DRAFT
        if (Test.isRunningTest()) {
        	q = ' SELECT ' + hcFields + ', (SELECT DataCategoryName FROM DataCategorySelections) FROM Help_Center__kav WHERE PublishStatus = :HC_DRAFT AND language = :EN_US AND LastModifiedDate > :todayDatetime LIMIT 1 ';
        }
        else {
            q = ' SELECT ' + hcFields + ', (SELECT DataCategoryName FROM DataCategorySelections) FROM Help_Center__kav WHERE PublishStatus = :HC_DRAFT AND language = :EN_US AND LastModifiedDate > :todayDatetime ';
        }
        PublicArticleBatch pabDraft = new PublicArticleBatch(q);
        Database.executeBatch(pabDraft, 1);
        
        //ARCHIVED
        if (Test.isRunningTest()) {
        	q = ' SELECT ' + hcFields + ', (SELECT DataCategoryName FROM DataCategorySelections) FROM Help_Center__kav WHERE PublishStatus = :HC_DRAFT AND language = :EN_US AND LastModifiedDate > :todayDatetime LIMIT 1 ';
        }
        else {
            q = ' SELECT ' + hcFields + ', (SELECT DataCategoryName FROM DataCategorySelections) FROM Help_Center__kav WHERE PublishStatus = :HC_DRAFT AND language = :EN_US AND LastModifiedDate > :todayDatetime ';
        }
        PublicArticleBatch pabArchived = new PublicArticleBatch(q);
        Database.executeBatch(pabArchived, 1);
        
        DescribeSObjectResult describeResultHca = Help_Center_Article__c.getSObjectType().getDescribe();
        List<String> hcaFieldList = new List<String>(describeResultHca.fields.getMap().keySet());
        String hcaFields = String.join(hcaFieldList, ',');
        String qError = '';
        //ERROR
        if (Test.isRunningTest()) {
        	qError = ' SELECT ' + hcaFields + ' FROM Help_Center_Article__c WHERE Sync_Status__c = :ERROR AND LastModifiedDate < :todayDatetime LIMIT 1 ';
        }
        else {
            qError = ' SELECT ' + hcaFields + ' FROM Help_Center_Article__c WHERE Sync_Status__c = :ERROR AND LastModifiedDate < :todayDatetime ';
        }
        PublicArticleErrorBatch paError = new PublicArticleErrorBatch(qError);
        Database.executeBatch(paError, 1);
        
        //DELETED
        DescribeSObjectResult describeResultKa = KnowledgeArticle.getSObjectType().getDescribe();
        List<String> kaFieldList = new List<String>(describeResultKa.fields.getMap().keySet());
        String kaFields = String.join(kaFieldList, ',');
        Set<Id> idSFList = new Set<Id>();
        List<Help_Center_Article__c> hcaList = [SELECT Id, Id_SF__c FROM Help_Center_Article__c LIMIT 50000];
        for (Help_Center_Article__c hca : hcaList) {
            idSFList.add(hca.Id_SF__c);
        }
        String qDeleted = '';
        if (Test.isRunningTest()) {
            qDeleted = ' SELECT ' + kaFields + ' FROM KnowledgeArticle WHERE IsDeleted = true AND Id IN :idSFList LIMIT 1 ALL ROWS ';
        }
        else {
            qDeleted = ' SELECT ' + kaFields + ' FROM KnowledgeArticle WHERE IsDeleted = true AND Id IN :idSFList ALL ROWS ';
        }
        PublicArticleDeleteBatch paDelete = new PublicArticleDeleteBatch(qDeleted, idSFList);
        Database.executeBatch(paDelete, 1);
    }
}