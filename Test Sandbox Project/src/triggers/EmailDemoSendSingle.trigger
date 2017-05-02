trigger EmailDemoSendSingle on Case (after insert) {
    for(Case x:trigger.new){
        if(x.Migration__c==false){
            String template;
            Id templateId; 
            
            List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
            // Send single mail to contact of each updated case
            // 
            List<Case> caseList = [select Account.PersonContactId, status, bad_parameter__c, case_created_by__c, Account.PersonEmail from Case where Id =:x.Id and Origin = 'Web' ];
            String q = 'select Account.PersonContactId, status, bad_parameter__c, case_created_by__c, Account.PersonEmail, contactid, accountid  from Case where Id = ' + x.Id +' and Origin = '+'\''+'Web'+'\''+'';
            System.debug(LoggingLevel.DEBUG, '***query: ' + q);
            System.debug(LoggingLevel.DEBUG, '***caseList size: ' + caseList.size());
            
            for (Case uc : caseList) {
                if(uc.bad_parameter__c == true && uc.status == 'Closed'){
                    template = 'Email Validasi';
                }
                else{
                    if(uc.Case_Created_By__c=='Agent') {template='Email Case by Agent';}
                    else{ template='EmailThanksNote'; }    
                }
                
                try {
                    templateId = [select id from EmailTemplate where Name = :template].id;
                } catch (Exception e) {
                    //...handle exception if no template is retrieved, or create condition to set email body in code
                    System.debug(LoggingLevel.ERROR, '***ERROR CATCH: ' + e.getMessage());
                }
                OrgWideEmailAddress owe = [SELECT ID,IsAllowAllProfiles,DisplayName,Address FROM OrgWideEmailAddress WHERE IsAllowAllProfiles = TRUE LIMIT 1];
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.setTemplateId(templateId);
                message.setTargetObjectId(uc.Account.PersonContactId);
                message.setWhatId(uc.Id);
                message.setReplyTo(Label.Email_Service);  
                //message.setReplyTo('tokopedia@2n472ddbe8kcraq4g6fw3sh6v5w5d288bosghrp5ok91w3ai9e.n-b0gmma0.cs6.apex.sandbox.salesforce.com');
                // message.setSenderDisplayName('Tokopedia');
                message.setOrgWideEmailAddressId(owe.Id);
                message.setToAddresses(new String[] {uc.Account.PersonEmail});
                messages.add(message);
            }
            Messaging.sendEmail(messages);
        }
    /*
      String template;
      Id templateId; 
    
      List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
      // Send single mail to contact of each updated case
        for (Case uc : [select Account.PersonContactId, status, bad_parameter__c, case_created_by__c, Account.PersonEmail from Case where Id in :Trigger.new and Origin = 'Web']) {
            if(uc.bad_parameter__c == true && uc.status == 'Closed'){
                template = 'Email Validasi';
            }
            else{
                if(uc.Case_Created_By__c=='Agent') {template='Email Case by Agent';}
                else{ template='EmailThanksNote'; }    
            }
            
          try {
                templateId = [select id from EmailTemplate where Name = :template].id;
          } catch (Exception e) {
            //...handle exception if no template is retrieved, or create condition to set email body in code
            System.debug(LoggingLevel.ERROR, '***ERROR CATCH: ' + e.getMessage());
          }
            OrgWideEmailAddress owe = [SELECT ID,IsAllowAllProfiles,DisplayName,Address FROM OrgWideEmailAddress WHERE IsAllowAllProfiles = TRUE LIMIT 1];
          Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
          message.setTemplateId(templateId);
          message.setTargetObjectId(uc.Account.PersonContactId);
          message.setWhatId(uc.Id);
          message.setReplyTo(Label.Email_Service);  
          //message.setReplyTo('tokopedia@2n472ddbe8kcraq4g6fw3sh6v5w5d288bosghrp5ok91w3ai9e.n-b0gmma0.cs6.apex.sandbox.salesforce.com');
         // message.setSenderDisplayName('Tokopedia');
          message.setOrgWideEmailAddressId(owe.Id);
          message.setToAddresses(new String[] {uc.Account.PersonEmail});
          messages.add(message);
        }
        Messaging.sendEmail(messages);
*/
        }
        
}