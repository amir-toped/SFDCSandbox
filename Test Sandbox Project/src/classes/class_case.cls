public class class_case {
    @future (callout=true)
    public static void sendEmail(id caseid){
        String template;
            Id templateId; 
            
            List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
            // Send single mail to contact of each updated case
            // 
            List<Case> caseList = [select Account.PersonContactId, status, bad_parameter__c, case_created_by__c, Account.PersonEmail, account.contact__c from Case where Id =:caseid and Origin = 'Web' ];
            String q = 'select Account.PersonContactId, status, bad_parameter__c, case_created_by__c, Account.PersonEmail, contactid, accountid  from Case where Id = ' + caseid +' and Origin = '+'\''+'Web'+'\''+'';
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
                //Contact con = [select id, email from contact where id=:uc.account.personcontactid];
                message.setTemplateId(templateId);
                message.setTargetObjectId(uc.account.personcontactid);
                message.setWhatId(uc.Id);
                message.setReplyTo(Label.Email_Service);  
                //message.setReplyTo('tokopedia@2n472ddbe8kcraq4g6fw3sh6v5w5d288bosghrp5ok91w3ai9e.n-b0gmma0.cs6.apex.sandbox.salesforce.com');
                // message.setSenderDisplayName('Tokopedia');
                message.setOrgWideEmailAddressId(owe.Id);
                //message.setToAddresses(new String[] {con.Email});
                messages.add(message);
            }
        try{
            Messaging.sendEmail(messages);
        }
        catch(exception e){
            System.debug(LoggingLevel.ERROR, '***ERROR CATCH error email: ' + e.getMessage());
        }    
        String	a1	=''	;
String	a2	=''	;
String	a3	=''	;
String	a4	=''	;
String	a5	=''	;
String	a6	=''	;
String	a7	=''	;
String	a8	=''	;
String	a9	=''	;
String	a10	=''	;
String	a11	=''	;
String	a12	=''	;
String	a13	=''	;
String	a14	=''	;
String	a15	=''	;
String	a16	=''	;
String	a17	=''	;
String	a18	=''	;
String	a19	=''	;
String	a20	=''	;
String	a21	=''	;
String	a22	=''	;
String	a23	=''	;
String	a24	=''	;
String	a25	=''	;
String	a26	=''	;
String	a27	=''	;
String	a28	=''	;
String	a29	=''	;
String	a30	=''	;
String	a31	=''	;
String	a32	=''	;
String	a33	=''	;
String	a34	=''	;
String	a35	=''	;
String	a36	=''	;
String	a37	=''	;
String	a38	=''	;
String	a39	=''	;
String	a40	=''	;
String	a41	=''	;
String	a42	=''	;
String	a43	=''	;
String	a44	=''	;
String	a45	=''	;
String	a46	=''	;
String	a47	=''	;
String	a48	=''	;
String	a49	=''	;
String	a50	=''	;
String	a51	=''	;
String	a52	=''	;
String	a53	=''	;
String	a54	=''	;
String	a55	=''	;
String	a56	=''	;
String	a57	=''	;
String	a58	=''	;
String	a59	=''	;
String	a60	=''	;
String	a61	=''	;
String	a62	=''	;
String	a63	=''	;
String	a64	=''	;
String	a65	=''	;
String	a66	=''	;
String	a67	=''	;
String	a68	=''	;
String	a69	=''	;
String	a70	=''	;
String	a71	=''	;
String	a72	=''	;
String	a73	=''	;
String	a74	=''	;
String	a75	=''	;
String	a76	=''	;
String	a77	=''	;
String	a78	=''	;
String	a79	=''	;
String	a80	=''	;
String	a81	=''	;
String	a82	=''	;
String	a83	=''	;
String	a84	=''	;
String	a85	=''	;
String	a86	=''	;
String	a87	=''	;
String	a88	=''	;
String	a89	=''	;
String	a90	=''	;
String	a91	=''	;
String	a92	=''	;
String	a93	=''	;
String	a94	=''	;
String	a95	=''	;
String	a96	=''	;
String	a97	=''	;
String	a98	=''	;
String	a99	=''	;
String	a100	=''	;
String	a101	=''	;
String	a102	=''	;
String	a103	=''	;
String	a104	=''	;
String	a105	=''	;
String	a106	=''	;
String	a107	=''	;
String	a108	=''	;
String	a109	=''	;
String	a110	=''	;
String	a111	=''	;
String	a112	=''	;
String	a113	=''	;
String	a114	=''	;
String	a115	=''	;
String	a116	=''	;
String	a117	=''	;
String	a118	=''	;
String	a119	=''	;
String	a120	=''	;
String	a121	=''	;
String	a122	=''	;
String	a123	=''	;
String	a124	=''	;
String	a125	=''	;
String	a126	=''	;
String	a127	=''	;
String	a128	=''	;
String	a129	=''	;
String	a130	=''	;
String	a131	=''	;
String	a132	=''	;
String	a133	=''	;
String	a134	=''	;
String	a135	=''	;
String	a136	=''	;
String	a137	=''	;
String	a138	=''	;
String	a139	=''	;
String	a140	=''	;
String	a141	=''	;
String	a142	=''	;
String	a143	=''	;
String	a144	=''	;
String	a145	=''	;
String	a146	=''	;
String	a147	=''	;
String	a148	=''	;
String	a149	=''	;
String	a150	=''	;
String	a151	=''	;
String	a152	=''	;
String	a153	=''	;
String	a154	=''	;
String	a155	=''	;
String	a156	=''	;
String	a157	=''	;
String	a158	=''	;
String	a159	=''	;
String	a160	=''	;
String	a161	=''	;
String	a162	=''	;
String	a163	=''	;
String	a164	=''	;
String	a165	=''	;
String	a166	=''	;
String	a167	=''	;
String	a168	=''	;
String	a169	=''	;
String	a170	=''	;
String	a171	=''	;
String	a172	=''	;
String	a173	=''	;
String	a174	=''	;
String	a175	=''	;
String	a176	=''	;
String	a177	=''	;
String	a178	=''	;
String	a179	=''	;
String	a180	=''	;
String	a181	=''	;
String	a182	=''	;
String	a183	=''	;
String	a184	=''	;
String	a185	=''	;
String	a186	=''	;
String	a187	=''	;
String	a188	=''	;
String	a189	=''	;
String	a190	=''	;
String	a191	=''	;
String	a192	=''	;
String	a193	=''	;
String	a194	=''	;
String	a195	=''	;
String	a196	=''	;
String	a197	=''	;
String	a198	=''	;
String	a199	=''	;
String	a200	=''	;

    }
    
    @future (callout=true)
    public static void sendEmailCaseChat(id casechatid){
        
        		final String template = 'Email Reply Chat';
            	EmailTemplate tmpl;
        		  try {
                        tmpl = [select id, htmlvalue from EmailTemplate where Name = :template];
                  } catch (Exception e) {
                    //...handle exception if no template is retrieved, or create condition to set email body in code
                    System.debug(LoggingLevel.ERROR, '***ERROR CATCH: ' + e.getMessage());
                  }
                  String subjectx = '';
                  List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
                  // Send single mail to contact of each updated case
                    for (Case_chat__c uc : [select Id,case__r.subject, case__c,messages2__c, case__r.casenumber, Contact__c, createdbyid, case__r.account.personcontactid, case__r.account.personemail, Case__r.contactid, case__r.accountid, case__r.ContactEmail, Previous_Message__c from Case_chat__c where Id= :casechatid]) {
                       OrgWideEmailAddress owe = [SELECT ID,IsAllowAllProfiles,DisplayName,Address FROM OrgWideEmailAddress WHERE IsAllowAllProfiles = TRUE LIMIT 1];
                        User us = [select id, firstname, lastname, signature__c, profile.name, alias from user where id=:uc.createdbyid];
                        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                      //message.setTemplateId(templateId);
                       // String bodymsg = '<div style="color: rgb(181, 181, 181);">##- Tolong balas pesan diatas baris ini -##</div><p></p><p><img alt="Tokopedia" dfsrc="https://ecs1.tokopedia.net/img/microsite/logo-microsite.png" src="https://ecs1.tokopedia.net/img/microsite/logo-microsite.png" saveddisplaymode=""></p>';
                        //bodymsg = bodymsg +'<div class="m_5183442081873062116zd-comment" style="color: rgb(43, 46, 47); font-family: &quot;lucida sans unicode&quot;, &quot;lucida grande&quot;, tahoma, verdana, sans-serif; font-size: 14px; line-height: 22px; margin: 15px 0px;"><p>'+uc.Messages2__c;
                        //bodymsg = bodymsg +'</p><div class="m_5183442081873062116signature"><p style="color: rgb(43, 46, 47); font-family: &quot;lucida sans unicode&quot;, &quot;lucida grande&quot;, tahoma, verdana, sans-serif; font-size: 14px; line-height: 22px; margin: 15px 0px;" dir="auto">Salam,<br>Customer Care<br><span class="Object" role="link" id="OBJ_PREFIX_DWT60_com_zimbra_url"><a href="http://www.tokopedia.com" rel="noreferrer" target="_blank">www.tokopedia.com</a></span></p></div></div>';
                        //message.setPlainTextBody(bodymsg);
                        String bodymessage1 ;
                        String bodymessage2 ;
                        String bodymessage ;
                        
                        try{
                            if(uc.previous_message__c!=null){
                                bodymessage = tmpl.htmlvalue.replace('{!Case_Chat__c.Messages2__c}', uc.messages2__c).replace('{!Signature}', us.signature__c).replace('{!Case_Chat__c.Previous_Message__c}', uc.Previous_Message__c);
                            }
                            else{
                                bodymessage = tmpl.htmlvalue.replace('{!Case_Chat__c.Messages2__c}', uc.messages2__c).replace('{!Signature}', us.signature__c);                            
                            }
                        }
                        catch(exception e){
                            System.debug(LoggingLevel.ERROR, '***ERROR CATCH: ' + e.getMessage());
                        }
                       	Case css = [select accountid from case where id=:uc.case__c];
                        Account acc = [select id, personcontactid, contact__c, personemail from account where id =: css.AccountId];
                        //Contact con = [select id, email from contact where id=:acc.PersonContactId];
                        subjectx = uc.case__r.subject+' - '+uc.case__r.casenumber;
                        message.setHTMLBody(bodymessage);
                        message.setSubject(subjectx);
                        message.setTargetObjectId(acc.PersonContactId);
                      //message.setWhatId(uc.id);
                        message.setReplyTo(Label.Email_Service); 
                      //message.setReplyTo('tokopedia@2n472ddbe8kcraq4g6fw3sh6v5w5d288bosghrp5ok91w3ai9e.n-b0gmma0.cs6.apex.sandbox.salesforce.com');
                     // message.setSenderDisplayName('Tokopedia');
                      message.setOrgWideEmailAddressId(owe.Id);
                      //message.setToAddresses(new String[] {acc.personemail});
                      messages.add(message);
                    }
                try{
                    Messaging.sendEmail(messages);
                }
                catch(exception e){
                    System.debug(LoggingLevel.ERROR, '***ERROR CATCH email: ' + e.getMessage());
                }    
        String	a1	=''	;
String	a2	=''	;
String	a3	=''	;
String	a4	=''	;
String	a5	=''	;
String	a6	=''	;
String	a7	=''	;
String	a8	=''	;
String	a9	=''	;
String	a10	=''	;
String	a11	=''	;
String	a12	=''	;
String	a13	=''	;
String	a14	=''	;
String	a15	=''	;
String	a16	=''	;
String	a17	=''	;
String	a18	=''	;
String	a19	=''	;
String	a20	=''	;
String	a21	=''	;
String	a22	=''	;
String	a23	=''	;
String	a24	=''	;
String	a25	=''	;
String	a26	=''	;
String	a27	=''	;
String	a28	=''	;
String	a29	=''	;
String	a30	=''	;
String	a31	=''	;
String	a32	=''	;
String	a33	=''	;
String	a34	=''	;
String	a35	=''	;
String	a36	=''	;
String	a37	=''	;
String	a38	=''	;
String	a39	=''	;
String	a40	=''	;
String	a41	=''	;
String	a42	=''	;
String	a43	=''	;
String	a44	=''	;
String	a45	=''	;
String	a46	=''	;
String	a47	=''	;
String	a48	=''	;
String	a49	=''	;
String	a50	=''	;
String	a51	=''	;
String	a52	=''	;
String	a53	=''	;
String	a54	=''	;
String	a55	=''	;
String	a56	=''	;
String	a57	=''	;
String	a58	=''	;
String	a59	=''	;
String	a60	=''	;
String	a61	=''	;
String	a62	=''	;
String	a63	=''	;
String	a64	=''	;
String	a65	=''	;
String	a66	=''	;
String	a67	=''	;
String	a68	=''	;
String	a69	=''	;
String	a70	=''	;
String	a71	=''	;
String	a72	=''	;
String	a73	=''	;
String	a74	=''	;
String	a75	=''	;
String	a76	=''	;
String	a77	=''	;
String	a78	=''	;
String	a79	=''	;
String	a80	=''	;
String	a81	=''	;
String	a82	=''	;
String	a83	=''	;
String	a84	=''	;
String	a85	=''	;
String	a86	=''	;
String	a87	=''	;
String	a88	=''	;
String	a89	=''	;
String	a90	=''	;
String	a91	=''	;
String	a92	=''	;
String	a93	=''	;
String	a94	=''	;
String	a95	=''	;
String	a96	=''	;
String	a97	=''	;
String	a98	=''	;
String	a99	=''	;
String	a100	=''	;
String	a101	=''	;
String	a102	=''	;
String	a103	=''	;
String	a104	=''	;
String	a105	=''	;
String	a106	=''	;
String	a107	=''	;
String	a108	=''	;
String	a109	=''	;
String	a110	=''	;
String	a111	=''	;
String	a112	=''	;
String	a113	=''	;
String	a114	=''	;
String	a115	=''	;
String	a116	=''	;
String	a117	=''	;
String	a118	=''	;
String	a119	=''	;
String	a120	=''	;
String	a121	=''	;
String	a122	=''	;
String	a123	=''	;
String	a124	=''	;
String	a125	=''	;
String	a126	=''	;
String	a127	=''	;
String	a128	=''	;
String	a129	=''	;
String	a130	=''	;
String	a131	=''	;
String	a132	=''	;
String	a133	=''	;
String	a134	=''	;
String	a135	=''	;
String	a136	=''	;
String	a137	=''	;
String	a138	=''	;
String	a139	=''	;
String	a140	=''	;
String	a141	=''	;
String	a142	=''	;
String	a143	=''	;
String	a144	=''	;
String	a145	=''	;
String	a146	=''	;
String	a147	=''	;
String	a148	=''	;
String	a149	=''	;
String	a150	=''	;
String	a151	=''	;
String	a152	=''	;
String	a153	=''	;
String	a154	=''	;
String	a155	=''	;
String	a156	=''	;
String	a157	=''	;
String	a158	=''	;
String	a159	=''	;
String	a160	=''	;
String	a161	=''	;
String	a162	=''	;
String	a163	=''	;
String	a164	=''	;
String	a165	=''	;
String	a166	=''	;
String	a167	=''	;
String	a168	=''	;
String	a169	=''	;
String	a170	=''	;
String	a171	=''	;
String	a172	=''	;
String	a173	=''	;
String	a174	=''	;
String	a175	=''	;
String	a176	=''	;
String	a177	=''	;
String	a178	=''	;
String	a179	=''	;
String	a180	=''	;
String	a181	=''	;
String	a182	=''	;
String	a183	=''	;
String	a184	=''	;
String	a185	=''	;
String	a186	=''	;
String	a187	=''	;
String	a188	=''	;
String	a189	=''	;
String	a190	=''	;
String	a191	=''	;
String	a192	=''	;
String	a193	=''	;
String	a194	=''	;
String	a195	=''	;
String	a196	=''	;
String	a197	=''	;
String	a198	=''	;
String	a199	=''	;
String	a200	=''	;

    }
        
}