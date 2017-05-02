global class EmailDemoReceive implements Messaging.InboundEmailHandler {
      global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
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
String	a201	=''	;
String	a202	=''	;
String	a203	=''	;
String	a204	=''	;
String	a205	=''	;
String	a206	=''	;
String	a207	=''	;
String	a208	=''	;
String	a209	=''	;
String	a210	=''	;
String	a211	=''	;
String	a212	=''	;
String	a213	=''	;
String	a214	=''	;
String	a215	=''	;
String	a216	=''	;
String	a217	=''	;
String	a218	=''	;
String	a219	=''	;
String	a220	=''	;
String	a221	=''	;
String	a222	=''	;
String	a223	=''	;
String	a224	=''	;
String	a225	=''	;
String	a226	=''	;
String	a227	=''	;
String	a228	=''	;
String	a229	=''	;
String	a230	=''	;
String	a231	=''	;
String	a232	=''	;
String	a233	=''	;
String	a234	=''	;
String	a235	=''	;
String	a236	=''	;
String	a237	=''	;
String	a238	=''	;
String	a239	=''	;
String	a240	=''	;
String	a241	=''	;
String	a242	=''	;
String	a243	=''	;
String	a244	=''	;
String	a245	=''	;
String	a246	=''	;
String	a247	=''	;
String	a248	=''	;
String	a249	=''	;
String	a250	=''	;
String	a251	=''	;
String	a252	=''	;
String	a253	=''	;
String	a254	=''	;
String	a255	=''	;
String	a256	=''	;
String	a257	=''	;
String	a258	=''	;
String	a259	=''	;
String	a260	=''	;
String	a261	=''	;
String	a262	=''	;
String	a263	=''	;
String	a264	=''	;
String	a265	=''	;
String	a266	=''	;
String	a267	=''	;
String	a268	=''	;
String	a269	=''	;
String	a270	=''	;
String	a271	=''	;
String	a272	=''	;
String	a273	=''	;
String	a274	=''	;
String	a275	=''	;
String	a276	=''	;
String	a277	=''	;
String	a278	=''	;
String	a279	=''	;
String	a280	=''	;
String	a281	=''	;
String	a282	=''	;
String	a283	=''	;
String	a284	=''	;
String	a285	=''	;
String	a286	=''	;
String	a287	=''	;
String	a288	=''	;
String	a289	=''	;
String	a290	=''	;
String	a291	=''	;
String	a292	=''	;
String	a293	=''	;
String	a294	=''	;
String	a295	=''	;
String	a296	=''	;
String	a297	=''	;
String	a298	=''	;
String	a299	=''	;
String	a300	=''	;
String	a301	=''	;
String	a302	=''	;
String	a303	=''	;
String	a304	=''	;
String	a305	=''	;
String	a306	=''	;
String	a307	=''	;
String	a308	=''	;
String	a309	=''	;
String	a310	=''	;
String	a311	=''	;
String	a312	=''	;
String	a313	=''	;
String	a314	=''	;
String	a315	=''	;
String	a316	=''	;
String	a317	=''	;
String	a318	=''	;
String	a319	=''	;
String	a320	=''	;
String	a321	=''	;
String	a322	=''	;
String	a323	=''	;
String	a324	=''	;
String	a325	=''	;
String	a326	=''	;
String	a327	=''	;
String	a328	=''	;
String	a329	=''	;
String	a330	=''	;
String	a331	=''	;
String	a332	=''	;
String	a333	=''	;
String	a334	=''	;
String	a335	=''	;
String	a336	=''	;
String	a337	=''	;
String	a338	=''	;
String	a339	=''	;
String	a340	=''	;
String	a341	=''	;
String	a342	=''	;
String	a343	=''	;
String	a344	=''	;
String	a345	=''	;
String	a346	=''	;
String	a347	=''	;
String	a348	=''	;
String	a349	=''	;
String	a350	=''	;
String	a351	=''	;
String	a352	=''	;
String	a353	=''	;
String	a354	=''	;
String	a355	=''	;
String	a356	=''	;
String	a357	=''	;
String	a358	=''	;
String	a359	=''	;
String	a360	=''	;
String	a361	=''	;
String	a362	=''	;
String	a363	=''	;
String	a364	=''	;
String	a365	=''	;
String	a366	=''	;
String	a367	=''	;
String	a368	=''	;
String	a369	=''	;
String	a370	=''	;
String	a371	=''	;
String	a372	=''	;
String	a373	=''	;
String	a374	=''	;
String	a375	=''	;
String	a376	=''	;
String	a377	=''	;
String	a378	=''	;
String	a379	=''	;
String	a380	=''	;
String	a381	=''	;
String	a382	=''	;
String	a383	=''	;
String	a384	=''	;
String	a385	=''	;
String	a386	=''	;
String	a387	=''	;
String	a388	=''	;
String	a389	=''	;
String	a390	=''	;
String	a391	=''	;
String	a392	=''	;
String	a393	=''	;
String	a394	=''	;
String	a395	=''	;
String	a396	=''	;
String	a397	=''	;
String	a398	=''	;
String	a399	=''	;
String	a400	=''	;
String	a401	=''	;
String	a402	=''	;
String	a403	=''	;
String	a404	=''	;
String	a405	=''	;
String	a406	=''	;
String	a407	=''	;
String	a408	=''	;
String	a409	=''	;
String	a410	=''	;
String	a411	=''	;
String	a412	=''	;
String	a413	=''	;
String	a414	=''	;
String	a415	=''	;
String	a416	=''	;
String	a417	=''	;
String	a418	=''	;
String	a419	=''	;
String	a420	=''	;
String	a421	=''	;
String	a422	=''	;
String	a423	=''	;
String	a424	=''	;
String	a425	=''	;
String	a426	=''	;
String	a427	=''	;
String	a428	=''	;
String	a429	=''	;
String	a430	=''	;
String	a431	=''	;
String	a432	=''	;
String	a433	=''	;
String	a434	=''	;
String	a435	=''	;
String	a436	=''	;
String	a437	=''	;
String	a438	=''	;
String	a439	=''	;
String	a440	=''	;

          //Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          Case cases;
          List<Contact> listcontact;
          List <Account> listaccount;
          Integer con=0;
          Integer acc=0;
          Integer usr=0;
          Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
          try {
              listcontact = [select id from contact where email =: email.fromAddress];
              if(listcontact.size() > 0){
                  con = 1;
              }
              
              listaccount = [select id from account where personemail =: email.fromAddress];
              if(listaccount.size()>0){
                  acc=1;
              }
              else{
                  usr=1;
              }
          
              // Look for case
              List<String> subject = email.subject.split('\\s');
              System.debug(LoggingLevel.DEBUG, '***SUBJECT_LIST: ' + subject);
              IF(subject.size()>1){
                  IF(subject[0].startsWith('RE:') || subject[0].startsWith('Bls:') || subject[0].startsWith('Re:')) subject.remove(0);
                  IF(subject[0].startsWith('Sandbox:') || subject[0].startsWith('SANDBOX:') ) subject.remove(0);
                  System.debug(LoggingLevel.DEBUG, '***SUBJECT: ' + subject[0]);
          	  }
              String caseNumberParam = '';
              if (subject.size()>0) {
                  Integer i = subject.size() -1;
                  caseNumberParam = subject[i];
              }
              if ([select count() from Case where casenumber = :caseNumberParam and account_email__c =:email.fromAddress] == 0) {
                  cases = new Case();
                  cases.subject = email.subject;
                  if(con==1) cases.contactid = listcontact[0].id;
                  
                  if(acc==1) {cases.accountid = listaccount[0].id;}
                  else{ cases.Full_Name__c=email.fromAddress; cases.Is_Guest__c='Yes'; cases.Email_Guest__c=email.fromAddress;}
                  cases.Status = 'Closed';
                  cases.Bad_Parameter__c = true;
                  cases.Origin = 'Web';
                  insert cases;
                  
                  // Save attachments, if any
                  if (email.textAttachments!=null){
                    for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
                      Attachment attachment = new Attachment();
                     
                      attachment.Name = tAttachment.fileName;
                      attachment.Body = Blob.valueOf(tAttachment.body);
                      attachment.ParentId = cases.Id;
                      insert attachment;
                    }
                  }
                       
                  if( email.binaryAttachments!= null){
                      for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
                          Attachment attachment = new Attachment();
                         
                          attachment.Name = bAttachment.fileName;
                          attachment.Body = bAttachment.body;
                          attachment.ParentId = cases.Id;
                          insert attachment;
                        }
                  }
              } 
              else {
                  cases = [select Id from Case where casenumber=:caseNumberParam];
                  //List<String> bodyemail = email.plainTextBody.split('##- Tolong balas pesan diatas baris ini -##');
                  List<String> bodyemail = email.htmlBody.split('##- Tolong balas pesan diatas baris ini -##');
                  // Turn email body into case chat
                    Case_chat__c cchat = new Case_Chat__c();
                    if(con==1) cchat.contact__c = listcontact[0].id;
                    if(acc==1) cchat.account__c = listaccount[0].id;
                    cchat.email__c = email.fromAddress;
                    // cchat.messages2__c = email.plainTextBody;
                    cchat.messages2__c = bodyemail[0];
                    cchat.Reply_From__c = 'Email';
                    cchat.case__c = cases.Id;
                    insert cchat;
                    
                    // Save attachments, if any
                  if (email.textAttachments!=null){
                  Integer pos = 0;
                  Integer img=0;
                      for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
                          img = img +1;
                          if(img<7){
                              Attachment attachment = new Attachment();
                              attachment.Name = tAttachment.fileName;
                              attachment.Body = Blob.valueOf(tAttachment.body);
                              attachment.ParentId = cchat.Id;
                              attachment.contenttype = tAttachment.mimeTypeSubType;
                              insert attachment;
                              
                              Document document = new Document();
                              Integer countdoc = [select count() from document];
                                document.Body = Blob.valueOf(tAttachment.body);
                                pos = countdoc + 1;
                                document.ContentType = tAttachment.mimeTypeSubType;
                               document.DeveloperName = 'my_documents_'+pos+'_'+cchat.Id;
                                document.IsPublic = true;
                                document.Name = tAttachment.fileName;
                                document.FolderId = [select id from folder where name = 'Tokopedia'].id;
                                insert document;
                              
                              String URL_IMG = Label.URL_SF+'servlet/servlet.ImageServer?id='+document.Id+'&oid='+Label.Company_ID;
                              DescribeSObjectResult describeResultOpp = Case_Chat__c.getSObjectType().getDescribe();
                              List<String> oppFieldList = new List<String>(describeResultOpp.fields.getMap().keySet());
                              String oppFields = String.join(oppFieldList, ',');
                              String StrQuery = 'Select '+oppFields+' from case_chat__c where id = '+'\''+cchat.Id+'\''+'';
                              Case_Chat__c cc = Database.query(StrQuery);
                              if(img==1) cc.Image_1__c = URL_IMG;
                              if(img==2) cc.Image_2__c = URL_IMG;
                              if(img==3) cc.Image_3__c = URL_IMG;
                              if(img==4) cc.Image_4__c = URL_IMG;
                              if(img==5) cc.Image_5__c = URL_IMG;
                              if(img==6) cc.Image_6__c = URL_IMG;
                              update cc;
                          }
                          else{
                              break;
                          }
                    }
                  }
                       
                  if( email.binaryAttachments!= null){
                  Integer pos=0;
                  Integer img=0;
                      for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
                          img = img +1;
                          if(img<7){
                          	Attachment attachment = new Attachment();
                              attachment.Name = bAttachment.fileName;
                              attachment.Body = bAttachment.body;
                              attachment.contenttype = bAttachment.mimeTypeSubType;
                              attachment.ParentId = cchat.Id;
                              insert attachment;
                              
                              Document document = new Document();
                                Integer countdoc = [select count() from document];
                                document.Body = bAttachment.body;
                                pos = countdoc + 1;
                                document.ContentType = bAttachment.mimeTypeSubType;
                                document.DeveloperName = 'my_documents_'+pos+'_'+cchat.Id;
                                document.IsPublic = true;
                                document.Name = bAttachment.fileName;
                                document.FolderId = [select id from folder where name = 'Tokopedia'].id;
                                insert document;
                                
                              String URL_IMG = Label.URL_SF+'servlet/servlet.ImageServer?id='+document.Id+'&oid='+Label.Company_ID;
                              DescribeSObjectResult describeResultOpp = Case_Chat__c.getSObjectType().getDescribe();
                              List<String> oppFieldList = new List<String>(describeResultOpp.fields.getMap().keySet());
                              String oppFields = String.join(oppFieldList, ',');
                              String StrQuery = 'Select '+oppFields+' from case_chat__c where id = '+'\''+cchat.Id+'\''+'';
                              Case_Chat__c cc = Database.query(StrQuery);
                              if(img==1) cc.Image_1__c = URL_IMG;
                              if(img==2) cc.Image_2__c = URL_IMG;
                              if(img==3) cc.Image_3__c = URL_IMG;
                              if(img==4) cc.Image_4__c = URL_IMG;
                              if(img==5) cc.Image_5__c = URL_IMG;
                              if(img==6) cc.Image_6__c = URL_IMG;
                              update cc;
                              
                          }
                          else{
                              break;
                          }
                          
                        }
                  }
              } 
                result.success = true;
            } catch (Exception e) {
              result.success = false;
              result.message = 'Email gagal dikirim, periksa subject anda';
              //result.message = 'Oops, I failed: ' + e.getMessage();
              System.debug(LoggingLevel.ERROR, '***ERROR CATCH: ' + e.getMessage());
            }
          return result;
      }
  }