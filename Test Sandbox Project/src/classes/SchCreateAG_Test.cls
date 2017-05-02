@isTest(seeAllData = true)
class SchCreateAG_Test {

   static testmethod void test() {
   Test.startTest();
  
      String jobId = System.schedule('Sch Create AG',
      SchCreateAG.CRON_EXP, 
         new SchCreateAG());

   Test.stopTest();

   }
}