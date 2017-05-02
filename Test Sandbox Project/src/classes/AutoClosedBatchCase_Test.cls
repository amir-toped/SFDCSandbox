@isTest
public class AutoClosedBatchCase_Test {
    static testmethod void TestAutoClosed(){
        Test.startTest();
        String q = 'select id, status from case limit 1 '  ;
        AutoClosedBatchCase autoclose = new AutoClosedBatchCase(q);
        Database.executeBatch(autoclose, 1);
        Test.stopTest();
    }
}