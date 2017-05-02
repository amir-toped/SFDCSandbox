@isTest(seeAllData=true)
private class EmailDemoReceive_Test {
	static testMethod void ProcessApplicantTest(){
        
        // Create a new email, envelope object and Attachment
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        
        email.subject = 'test';
        email.fromName = 'test test';
        email.plainTextBody = 'Hello, this a test email body. for testing purposes only.Phone:123456 Bye';
        Messaging.InboundEmail.BinaryAttachment[] binaryAttachments = new Messaging.InboundEmail.BinaryAttachment[1];  
        Messaging.InboundEmail.BinaryAttachment binaryAttachment = new Messaging.InboundEmail.BinaryAttachment();
        binaryAttachment.Filename = 'test.txt';
        String algorithmName = 'HMacSHA1';
        Blob b = Crypto.generateMac(algorithmName, Blob.valueOf('test'),
        Blob.valueOf('test_key'));
        binaryAttachment.Body = b;
        binaryAttachments[0] =  binaryAttachment ;
        email.binaryAttachments = binaryAttachments ;
        envelope.fromAddress = 'user@acme.com';
        
        // setup controller object
        EmailDemoReceive catcher = new EmailDemoReceive();
        Messaging.InboundEmailResult result = catcher.handleInboundEmail(email, envelope);
        //System.assertEquals( result.success  ,true);    

    }
    
    /*
    static testMethod void ProcessApplicantTest2(){
        
        // Create a new email, envelope object and Attachment
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        
        Case csnm = [select casenumber, Account_Email__c from case where accountid != null limit 1];
        email.subject = csnm.CaseNumber;
        email.fromName = 'test test';
        email.plainTextBody = 'Hello, this a test email body. for testing purposes only.Phone:123456 Bye';
        Messaging.InboundEmail.BinaryAttachment[] binaryAttachments = new Messaging.InboundEmail.BinaryAttachment[1];  
        Messaging.InboundEmail.BinaryAttachment binaryAttachment = new Messaging.InboundEmail.BinaryAttachment();
        binaryAttachment.Filename = 'test.txt';
        String algorithmName = 'HMacSHA1';
        Blob b = Crypto.generateMac(algorithmName, Blob.valueOf('test'),
        Blob.valueOf('test_key'));
        binaryAttachment.Body = b;
        binaryAttachments[0] =  binaryAttachment ;
        email.binaryAttachments = binaryAttachments ;
        envelope.fromAddress = csnm.Account_Email__c;
        
        // setup controller object
        EmailDemoReceive catcher = new EmailDemoReceive();
        Messaging.InboundEmailResult result = catcher.handleInboundEmail(email, envelope);
        //System.assertEquals( result.success  ,true);    

    }
*/
}