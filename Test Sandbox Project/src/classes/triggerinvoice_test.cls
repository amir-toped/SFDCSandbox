@isTest(seeAllData=true)
private class triggerinvoice_test {
    static testmethod void update_customer(){
        Account acc = new Account();
        acc.FirstName = 'Wilhan';
        acc.LastName = 'Robin';
        acc.RecordTypeId = label.recordtype_id;
        acc.PersonEmail = 'taufik.susanto@mii.co.id';
        acc.Duplicate_Key__c = 'taufik.susanto@mii.co.id';
        insert acc;
        Invoice__c invc = new Invoice__c();
        invc.Account__c = acc.id;
        invc.Invoice_Date__c = date.today();
        invc.Invoice_No__c = 'INV/XXXXX';
        invc.Invoice_Status__c = 'Finished';
        insert invc;
    }	
}