@isTest(seeAllData = true)
class SchUpdateAG_Test {

   static testmethod void test() {
   Test.startTest();
  
      String jobId = System.schedule('Sch update AG',
      SchUpdateAG.CRON_EXP, 
         new SchUpdateAG());

   Test.stopTest();

   }
}