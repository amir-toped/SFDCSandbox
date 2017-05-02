@isTest(seeAllData=true)
private class Test_Acc_CreateContact{
    static testMethod void myTest() {
       // Account acc = [Select Name, PersonMobilePhone, Phone From Account where PersonMobilePhone != null and Phone != null Limit 1];
      //  Contact cntct = [Select Salutation, FirstName, LastName, Phone, MobilePhone, Person_Account__c From Contact where Salutation
        Test.startTest();
            Account acc = new Account();
            acc.LastName = 'Test';
            acc.PersonMobilePhone = '029292';
            acc.Phone = '12819';
            acc.RecordTypeId = '01228000000TCf0AAG';
        insert acc;
            acc.PersonMobilePhone = '9999';
            acc.Phone = '9777';
        update acc;
        Test.stopTest();
    }
}