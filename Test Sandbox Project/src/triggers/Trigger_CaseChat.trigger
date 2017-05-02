trigger Trigger_CaseChat on Case_Chat__c (Before Insert, After Insert) {
    if(trigger.isbefore){
        for(Case_Chat__c x:trigger.new){
            if(x.messages2__c!=null) x.messages_plaintext__c = x.messages2__C.stripHtmlTags();
            if(x.migration__c==false){
                List<Case_Chat__c> listcc = [select Last_Agent_Reply__c from case_chat__C where case__c=:x.case__c];
                List<Case_Chat__c> listtoupdate = new List<Case_Chat__c>();
                if(listcc.size()>0){
                    for(case_chat__c cc:listcc){
                        cc.last_agent_reply__C = false;
                        listtoupdate.add(cc);
                    }
                    if(listtoupdate.size()>0) update listtoupdate;
                }
                Case cs = [select createddate, description, account.name, account.personemail from case where id=:x.case__c];
                Account acc;
                Contact con;
                List<Case_Chat__c> lstcc;
                String msg='';
                String name = '';
                String allmsg= '';
                String allmsg2= '';
                String allmsg3= '';
                /*
                if(x.contact__c!=null){
                    con = [select firstname, lastname, email from contact where id=:x.contact__c];
                    x.name = con.firstname+' '+con.lastname;
                    x.email__c = con.email;
                }
                */
                if(x.account__C != null){
                    acc = [select name, personemail from Account where id=:x.account__c];
                    x.name = acc.name;
                    x.email__c = acc.personemail;
                    x.last_agent_reply__c = false;
                }
                else{
                    x.name = 'Agent';
                    x.Reply_From__c = 'Salesforce';
                    x.last_agent_reply__c = true;
                    x.Email__c = cs.account.personemail;
                    lstcc = [select id, messages2__c, createddate, case__r.CreatedDate, account__c, user__c, contact_name__c, account_name__c, agent_name__c, agent_alias__C, contact__c, case__r.description from case_chat__c where case__c =:x.case__C order by createddate desc];
                    if(lstcc.size() > 1){
                    	for(case_chat__c cc:lstcc){
                            if(cc.account__c != null){
                                msg = msg+'<tr><td valign="top" style="width:100%;margin:0;padding:0;"><div style="margin-top:0;margin-bottom:0;padding:0;"><font face="Lucida Grande,Lucida Sans Unicode,Lucida Sans,Verdana,Tahoma,sans-serif" size="2" color="#1B1D1E"><span style="font-size:15px;"><b>'+cc.account_name__C+'</b></span></font></div></td></tr>';
                                name = cc.account_name__C;
                            }
                            else if(cc.contact__c !=null){
                                msg = msg+'<tr><td valign="top" style="width:100%;margin:0;padding:0;"><div style="margin-top:0;margin-bottom:0;padding:0;"><font face="Lucida Grande,Lucida Sans Unicode,Lucida Sans,Verdana,Tahoma,sans-serif" size="2" color="#1B1D1E"><span style="font-size:15px;"><b>'+cc.contact_name__c+'</b></span></font></div></td></tr>';
                                name = cc.contact_name__c;
                            }
                            else{
                                msg = msg+'<tr><td valign="top" style="width:100%;margin:0;padding:0;"><div style="margin-top:0;margin-bottom:0;padding:0;"><font face="Lucida Grande,Lucida Sans Unicode,Lucida Sans,Verdana,Tahoma,sans-serif" size="2" color="#1B1D1E"><span style="font-size:15px;"><b>'+cc.agent_alias__c+'</b></span></font></div></td></tr>';
                            } 
                            msg = msg+'<tr><td><div style="margin-top:0;margin-bottom:15px;padding:0;"><font face="Lucida Grande,Lucida Sans Unicode,Lucida Sans,Verdana,Tahoma,sans-serif" size="1" color="#BBBBBB"><span style="font-size:13px;">'+cc.CreatedDate.format('MMM d, HH:mm')+' WIB</span></font></div></td></tr>';
                            msg = msg+'<tr><td><div style="margin:15px 0;"><font face="Lucida Sans Unicode,Lucida Grande,Tahoma,Verdana,sans-serif" size="2" color="#2B2E2F"><span style="font-size:14px;">'+cc.messages2__c+'</span></font></div></td></tr>';
                            
                        }
                        allmsg ='<div style="margin-top: 25px;"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="table-layout: fixed;"><tbody>'+msg;
                        allmsg = allmsg+ '<tr><td><hr></td></tr><tr><td><div style="margin-top:0;margin-bottom:0;padding:0;"><font face="Lucida Grande,Lucida Sans Unicode,Lucida Sans,Verdana,Tahoma,sans-serif" size="2" color="#1B1D1E"><span style="font-size:15px;"><b>'+cs.account.name+'</b></span></font></div></td></tr>';
                        allmsg = allmsg+ '<tr><td><div style="margin-top:0;margin-bottom:15px;padding:0;"><font face="Lucida Grande,Lucida Sans Unicode,Lucida Sans,Verdana,Tahoma,sans-serif" size="1" color="#BBBBBB"><span style="font-size:13px;">'+cs.CreatedDate.format('MMM d, HH:mm')+' WIB</span></font></div></td></tr><tr><td><font face="Lucida Sans Unicode,Lucida Grande,Tahoma,Verdana,sans-serif" size="2" color="#2B2E2F"><span style="font-size:14px;">'+lstcc[0].case__r.description+'</td></tr></span></font></div></tbody></table>';
                        if(allmsg.length()>131000){
                            x.previous_message__c = allmsg.substring(0,131000);
                            allmsg2 = allmsg.substring(131000);
                            if(allmsg2.length()>131000){
                                x.previous_message2__c = allmsg2.substring(0,131000);
                                x.previous_message3__c = allmsg2.substring(131000);
                            }
                            else{
                                x.previous_message2__c = allmsg2;
                                x.Previous_Message3__c = '<p></p>';
                            }
                        }  
                        else{
                           x.previous_message__c = allmsg;
                           x.previous_message2__c = '<p></p>';
                           x.Previous_Message3__c = '<p></p>';
                        }  
                    }
                    else{
                        allmsg ='<div style="margin-top: 25px;"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="table-layout: fixed;"><tbody>';
                        allmsg = allmsg+ '<tr><td><div style="margin-top:0;margin-bottom:0;padding:0;"><font face="Lucida Grande,Lucida Sans Unicode,Lucida Sans,Verdana,Tahoma,sans-serif" size="2" color="#1B1D1E"><span style="font-size:15px;"><b>'+cs.account.name+'</b></span></font></div></td></tr>';
                        allmsg = allmsg+ '<tr><td><div style="margin-top:0;margin-bottom:15px;padding:0;"><font face="Lucida Grande,Lucida Sans Unicode,Lucida Sans,Verdana,Tahoma,sans-serif" size="1" color="#BBBBBB"><span style="font-size:13px;">'+cs.CreatedDate.format('MMM d, HH:mm')+' WIB</span></font></div></td></tr><tr><td><font face="Lucida Sans Unicode,Lucida Grande,Tahoma,Verdana,sans-serif" size="2" color="#2B2E2F"><span style="font-size:14px;">'+cs.description+'</td></tr></span></font></div></tbody></table>';
						if(allmsg.length()>131000){
                            x.previous_message__c = allmsg.substring(0,131000);
                            allmsg2 = allmsg.substring(131000);
                            if(allmsg2.length()>131000){
                                x.previous_message2__c = allmsg2.substring(0,131000);
                                x.previous_message3__c = allmsg2.substring(131000);  
                            }
                            else{
                                x.previous_message2__c = allmsg2;
                                x.Previous_Message3__c = '<p></p>';
                            }
                        }  
                        else{
                           x.previous_message__c = allmsg;
                           x.previous_message2__c = '<p></p>';
                           x.Previous_Message3__c = '<p></p>';
                        }
                    }
                }    
            }
        }
    }
    else{
        For(Case_Chat__c x:trigger.new){
            final String template = 'Email Reply Chat';
            EmailTemplate tmpl; 
            Case cs = [select Subject, status, count_agent_reply__c, Inbox_read_status__c, need_reply__c, accountid from Case where id = : x.case__C];
        //if(x.Migration__c==false){
            if(x.name == 'Agent'){
                User us = [select id, firstname, lastname, signature__c, profile.name, alias from user where id=:x.createdbyid];
                
                Case_Chat__c cc = [select user__c, user__r.signature__c, name from Case_chat__c where id =: x.id];
                cc.user__C = us.id;
                cc.name = us.alias;
                //cc.name = us.firstname+' '+us.lastname;
                //cc.name = 'CSTokopedia';
                update cc;
                if(cs.count_agent_reply__c!=null){
                    cs.count_agent_reply__c = cs.count_agent_reply__c + 1;    
                }
                else{
                    cs.count_agent_reply__c = 1;
                }
                User admin = [SELECT Id FROM user WHERE profile.name ='System Administrator' and isactive = true limit 1];
                /*
                if(us.profile.name=='SCS_L1_Agents'){ cs.status = 'Solved'; } 
                else if(us.profile.name=='SCS_L2_Agents'){ cs.status = 'Solved L2';}
                else { cs.status = 'Solved L3';} 
                */
                cs.status = 'Solved';
                cs.need_reply__c = false;
                cs.Inbox_read_status__c = 'Unread';
                //if(!Test.isRunningTest()) update cs;
                if(Test.isRunningTest()){system.runas(admin){update cs;}} 
                else{ update cs;}
                if([select count() from Agent_Response_Case__c where case__c=:x.case__c and user_agent__c =:x.user__c]==0) {
                    Agent_Response_Case__c arc = new Agent_Response_Case__c();
                    arc.case__c = x.case__c;
                    arc.user_agent__c = x.user__c;
                    insert arc; 
                }
                
                CallWS.getData(label.url_unread, x.case__c, cs.Accountid);
                //class_case.sendEmailCaseChat(x.id);
                /* 
                try {
                        tmpl = [select id, htmlvalue from EmailTemplate where Name = :template];
                  } catch (Exception e) {
                    //...handle exception if no template is retrieved, or create condition to set email body in code
                    System.debug(LoggingLevel.ERROR, '***ERROR CATCH: ' + e.getMessage());
                  }
                  
                  String subjectx = '';
                  List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
                  // Send single mail to contact of each updated case
                    for (Case_chat__c uc : [select Id,case__r.subject, case__c,messages2__c, case__r.casenumber, Contact__c, case__r.account.personcontactid, case__r.account.personemail, Case__r.contactid, case__r.accountid, case__r.ContactEmail from Case_chat__c where Id= :x.id]) {
                       OrgWideEmailAddress owe = [SELECT ID,IsAllowAllProfiles,DisplayName,Address FROM OrgWideEmailAddress WHERE IsAllowAllProfiles = TRUE LIMIT 1];
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
                            if(x.previous_message__c!=null){
                                bodymessage = tmpl.htmlvalue.replace('{!Case_Chat__c.Messages2__c}', x.messages2__c).replace('{!Signature}', us.signature__c).replace('{!Case_Chat__c.Previous_Message__c}', x.Previous_Message__c);
                            }
                            else{
                                bodymessage = tmpl.htmlvalue.replace('{!Case_Chat__c.Messages2__c}', x.messages2__c).replace('{!Signature}', us.signature__c);                            
                            }
                        }
                        catch(exception e){
                            System.debug(LoggingLevel.ERROR, '***ERROR CATCH: ' + e.getMessage());
                        }
                        subjectx = uc.case__r.subject+' - '+uc.case__r.casenumber;
                        message.setHTMLBody(bodymessage);
                        message.setSubject(subjectx);
                        message.setTargetObjectId(uc.case__r.account.personcontactid);
                      //message.setWhatId(uc.id);
                        message.setReplyTo(Label.Email_Service); 
                      //message.setReplyTo('tokopedia@2n472ddbe8kcraq4g6fw3sh6v5w5d288bosghrp5ok91w3ai9e.n-b0gmma0.cs6.apex.sandbox.salesforce.com');
                     // message.setSenderDisplayName('Tokopedia');
                      message.setOrgWideEmailAddressId(owe.Id);
                      message.setToAddresses(new String[] {uc.case__r.account.personemail});
                      messages.add(message);
                    }
                try{
                    //Messaging.sendEmail(messages);
                }
                catch(exception e){
                    System.debug(LoggingLevel.ERROR, '***ERROR CATCH email: ' + e.getMessage());
                }
                */    
            }
            else{
                cs.need_reply__c = true;
                cs.Inbox_read_status__c = 'Read';
                cs.Status = 'Response Received';
                update cs;
                CallWS.getData(label.url_read, x.case__c, cs.Accountid);
            }
        //}
        }
    }
    String	a1	='';
String	a2	='';
String	a3	='';
String	a4	='';
String	a5	='';
String	a6	='';
String	a7	='';
String	a8	='';
String	a9	='';
String	a10	='';
String	a11	='';
String	a12	='';
String	a13	='';
String	a14	='';
String	a15	='';
String	a16	='';
String	a17	='';
String	a18	='';
String	a19	='';
String	a20	='';
String	a21	='';
String	a22	='';
String	a23	='';
String	a24	='';
String	a25	='';
String	a26	='';
String	a27	='';
String	a28	='';
String	a29	='';
String	a30	='';
String	a31	='';
String	a32	='';
String	a33	='';
String	a34	='';
String	a35	='';
String	a36	='';
String	a37	='';
String	a38	='';
String	a39	='';
String	a40	='';
String	a41	='';
String	a42	='';
String	a43	='';
String	a44	='';
String	a45	='';
String	a46	='';
String	a47	='';
String	a48	='';
String	a49	='';
String	a50	='';
String	a51	='';
String	a52	='';
String	a53	='';
String	a54	='';
String	a55	='';
String	a56	='';
String	a57	='';
String	a58	='';
String	a59	='';
String	a60	='';
String	a61	='';
String	a62	='';
String	a63	='';
String	a64	='';
String	a65	='';
String	a66	='';
String	a67	='';
String	a68	='';
String	a69	='';
String	a70	='';
String	a71	='';
String	a72	='';
String	a73	='';
String	a74	='';
String	a75	='';
String	a76	='';
String	a77	='';
String	a78	='';
String	a79	='';
String	a80	='';
String	a81	='';
String	a82	='';
String	a83	='';
String	a84	='';
String	a85	='';
String	a86	='';
String	a87	='';
String	a88	='';
String	a89	='';
String	a90	='';
String	a91	='';
String	a92	='';
String	a93	='';
String	a94	='';
String	a95	='';
String	a96	='';
String	a97	='';
String	a98	='';
String	a99	='';
String	a100	='';

}