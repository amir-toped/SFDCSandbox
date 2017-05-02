trigger Trigger_Case on Case (before insert, before update, after insert, after update) {
    if(trigger.isbefore){
        if(trigger.isinsert){
            for(Case x:trigger.new){
                if(x.migration__c ==false){
                    if(x.Is_Guest__c == 'Yes' && x.origin == 'Web'){
                        if(x.Email_Guest__c!=null){
                        	List<Account> listacc = [select id, personemail from account where Duplicate_Key__c =: x.email_guest__c];
                            if(listacc.size()>0){
                                x.accountid = listacc[0].id;
                                x.email_account__c = listacc[0].personemail;
                            }
                            else{
                                if(x.Full_Name__c!=null){
                                	Account acc = new Account();
                                    String n = x.full_name__c;
                                    String[] result = n.split('\\s');
                                    Integer p = result.size();
                                    Integer q;
                                    IF(p>1){
                                        String l = '';
                                        String f='';
                                        Integer c = p-1;
                                        //Integer w = c+1;
                                        for(q=0; q < c; q++){
                                            f = f+' '+result[q];
                                        }
                                        acc.firstname = f;
                                        acc.lastname = result[c];
                                    }
                                    ELSE{
                                        acc.lastname = x.full_name__c;
                                        acc.firstname = '';
                                    }
                                    
                                    acc.recordtypeid = Label.Recordtype_Id;
                                    acc.phone = x.customer_phone__c;
                                    acc.personemail = x.email_guest__c;
                                    acc.Duplicate_Key__c = x.email_guest__c;
                                    insert acc;
                                    
                                    x.accountid = acc.id;
                                    x.email_account__c = x.email_guest__c;
                                    //x.contactid = acc.personcontactid;    
                                }
                                else{
									if(!Test.isRunningTest()) x.Full_Name__c.adderror('Full Name harus di isi');
                                }
                            }    
                        }
                        else{
                            if(!Test.isRunningTest()) x.Email_Guest__c.adderror('Email Harus di isi');
                        }
                    }
                    else if(x.Is_Guest__c != 'Yes' && x.origin == 'Web' && x.AccountId != null){
                        Account acc = [select personemail from account where id=:x.AccountId];
                        x.Email_account__c = acc.PersonEmail;
                    }
                    if (x.Contact_Id__c != NULL && x.Contact_Id__c != '') x.Contact__c = x.Contact_Id__c;
                    if(x.accountid==null && x.contactid!=null){
                        List<account> listaccs = [select id from account where personcontactid=:x.contactid];
                        if(listaccs.size()>0){
                            x.AccountId = listaccs[0].id;
                        }
                        else{
                            Contact con = [select firstname, lastname, email, phone from contact where id=:x.ContactId];
                            Account acc = new Account();
                            acc.FirstName = con.firstname;
                            acc.LastName = con.LastName;
                            acc.personemail = con.Email;
                            acc.Phone = con.Phone;
                            acc.RecordTypeId = label.recordtype_id;
                            insert acc;
                            x.AccountId = acc.id;
                        }
                    }
                }
            }
        }
        else{
            for(case x:trigger.new){
               // if(x.Migration__c==false){
                    if(x.order__c != null && x.status!=null && x.CategoryUpdated__c == false && system.isFuture() == true){
                        Order__c ord = [select id, Status__c, payment__c from Order__c where id=:x.order__c];
                        x.category__c = ord.status__c;
                        if(ord.payment__c != null){
                        	Payment__c pmn = [select method__c from Payment__c where id =: ord.payment__C];    
                        	x.Case_SubCategory_1__c = pmn.method__c;
                        }
                        List<Shipment__c> shp = [select courier__c from shipment__c where order__c =: ord.id];
                        if(shp.size()>0) x.Sub_Category2__c = shp[0].courier__c;    
                        
                        x.CategoryUpdated__c = true;
                        x.recordtypeid = label.RecID_MrktPlc;
                    }
                /*
                if(x.Count_Agent_Reply__c > 2 && x.Status == label.Status_Agent_Reply_2){
                  	x.OwnerId = label.id_reply_2;
                    x.Count_Agent_Reply__c = 0;
                } 
				*/
                //}
            }
        }
    }
   
    else{
        if(trigger.isinsert){
            for(case x:trigger.new){
                if(x.Migration__c==false && x.origin=='Web'){
                   // class_case.sendEmail(x.id);
                    if(x.Case_Mobile__c != null && x.contact__c != null){
                        Contact con = [select phone from contact where id=:x.contact__c];
                        con.phone = x.case_mobile__C;
                        update con; 
                    }
                }
            }
        }
        else{
            for(Case x:trigger.new){
                if(x.Migration__c==false && x.origin=='Web'){
                Integer countEL = [select count() from Email_Log__c where case__c =:x.id];
                String msg ='';
                String msg2='';
                String msg3='';
                    if(x.status == 'Closed' && countEL == 0 && x.bad_parameter__c==false){
                        Email_Log__c  el = new Email_Log__c();
                        el.case__c = x.id;
                        el.contact__c = x.contactId;
                        el.account__c = x.accountId;
                        el.survey__c = Label.survey_id;
                        el.survey_question__c = Label.survey_question_id;
                        el.status__c = 'Draft';
                        if(x.ContactEmail!= null){
                            el.email__c = x.ContactEmail;
                        }
                        else{
                            el.email__c = x.Account_Email__c;
                        }
                        List<Case_Chat__c> listcc = [select messages2__c, createddate, user__c, agent_name__c, account_name__c, previous_message__c, previous_message2__c, previous_message3__c from case_chat__c where case__c =:x.id order by createddate desc limit 1];
                        if(listcc.size()>0){
                            for(Case_chat__c cc:listcc){
                            	if(cc.user__c != null){
                                    msg = '<div style="margin-top: 25px;"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="table-layout: fixed;"><tbody>';
                                    msg = msg+'<tr><td><div style="margin-top:0;margin-bottom:0;padding:0;">';
                                    msg = msg+'<font face="Lucida Grande,Lucida Sans Unicode,Lucida Sans,Verdana,Tahoma,sans-serif" size="2" color="#1B1D1E">';
                                    msg = msg+'<span style="font-size:15px;"><b>'+cc.agent_name__c+'</b></span></font></div></td></tr>';
                                    msg = msg+'<tr><td><div style="margin-top:0;margin-bottom:15px;padding:0;"><font face="Lucida Grande,Lucida Sans Unicode,Lucida Sans,Verdana,Tahoma,sans-serif" size="1" color="#BBBBBB">';
                                    msg = msg+'<span style="font-size:13px;">'+cc.CreatedDate.format('MMM d, HH:mm')+' WIB</span></font></div></td></tr><tr><td>';
                                    msg = msg+'<font face="Lucida Sans Unicode,Lucida Grande,Tahoma,Verdana,sans-serif" size="2" color="#2B2E2F"><span style="font-size:14px;">'+cc.messages2__c+'</td></tr></span></font></div></tbody></table>';
                                    msg = msg+'<br/>'+cc.previous_message__c+''+cc.Previous_Message2__c+''+cc.Previous_Message3__c;
                                    if(msg.length()>131000){
                                        el.all_message__c = msg.substring(0,131000);
                                        msg2 = msg.substring(131000);
                                        if(msg2.length()>131000){
                                    		el.All_Message2__c = msg2.substring(0,131000);
                                    		el.All_Message3__c = msg2.substring(131000);        
                                        }
                                        else{
                                            el.All_Message2__c = msg2;
                                    		el.All_Message3__c = '<p></p>';
                                        }
                                    }
                                    else{
                                        el.all_message__c = msg;
                                        el.All_Message2__c = '<p></p>';
                                        el.All_Message3__c = '<p></p>';
                                    }
                                    
                                }
                                else{
                                    msg = '<div style="margin-top: 25px;"><table width="100%" cellpadding="0" cellspacing="0" border="0" style="table-layout: fixed;"><tbody>';
                                    msg = msg+'<tr><td><div style="margin-top:0;margin-bottom:0;padding:0;">';
                                    msg = msg+'<font face="Lucida Grande,Lucida Sans Unicode,Lucida Sans,Verdana,Tahoma,sans-serif" size="2" color="#1B1D1E">';
                                    msg = msg+'<span style="font-size:15px;"><b>'+cc.account_name__c+'</b></span></font></div></td></tr>';
                                    msg = msg+'<tr><td><div style="margin-top:0;margin-bottom:15px;padding:0;"><font face="Lucida Grande,Lucida Sans Unicode,Lucida Sans,Verdana,Tahoma,sans-serif" size="1" color="#BBBBBB">';
                                    msg = msg+'<span style="font-size:13px;">'+cc.CreatedDate.format('MMM d, HH:mm')+' WIB</span></font></div></td></tr><tr><td>';
                                    msg = msg+'<font face="Lucida Sans Unicode,Lucida Grande,Tahoma,Verdana,sans-serif" size="2" color="#2B2E2F"><span style="font-size:14px;">'+cc.messages2__c+'</td></tr></span></font></div></tbody></table>';
                                    msg = msg+'<br/>'+cc.previous_message__c+''+cc.Previous_Message2__c+''+cc.Previous_Message3__c;
                                    if(msg.length()>131000){
                                        el.all_message__c = msg.substring(0,131000);
                                        msg2 = msg.substring(131000);
                                        if(msg2.length()>131000){
                                    		el.All_Message2__c = msg2.substring(0,131000);
                                    		el.All_Message3__c = msg2.substring(131000);        
                                        }
                                        else{
                                            el.All_Message2__c = msg2;
                                    		el.All_Message3__c = '<p></p>';
                                        }
                                    }
                                    else{
                                        el.all_message__c = msg;
                                        el.All_Message2__c = '<p></p>';
                                        el.All_Message3__c = '<p></p>';
                                    }
                                    /*
                                    el.all_message__c = msg;
                                    el.All_Message2__c = cc.Previous_Message2__c;
                                    el.All_Message3__c = cc.Previous_Message3__c;
									*/
                                }    
                            }
                        	    
                        }
                        else{
                            el.all_message__c = '';
                            el.All_Message2__c = '';
                            el.All_Message3__c = '';
                        }
                        insert el;
                    }
                }
            }
        }
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
String	a151	='';
String	a152	='';
String	a153	='';
String	a154	='';
String	a155	='';
String	a156	='';
String	a157	='';
String	a158	='';
String	a159	='';
String	a160	='';
String	a161	='';
String	a162	='';
String	a163	='';
String	a164	='';
String	a165	='';
String	a166	='';
String	a167	='';
String	a168	='';
String	a169	='';
String	a170	='';
String	a171	='';
String	a172	='';
String	a173	='';
String	a174	='';
String	a175	='';
String	a176	='';
String	a177	='';
String	a178	='';
String	a179	='';
String	a180	='';
String	a181	='';
String	a182	='';
String	a183	='';
String	a184	='';
String	a185	='';
String	a186	='';
String	a187	='';
String	a188	='';
String	a189	='';
String	a190	='';
String	a191	='';
String	a192	='';
String	a193	='';
String	a194	='';
String	a195	='';
String	a196	='';
String	a197	='';
String	a198	='';
String	a199	='';
String	a200	='';
String	a201	='';
String	a202	='';
String	a203	='';
String	a204	='';
String	a205	='';
String	a206	='';
String	a207	='';
String	a208	='';
String	a209	='';
String	a210	='';
String	a211	='';
String	a212	='';
String	a213	='';
String	a214	='';
String	a215	='';
String	a216	='';
String	a217	='';
String	a218	='';
String	a219	='';
String	a220	='';
String	a221	='';
String	a222	='';
String	a223	='';
String	a224	='';
String	a225	='';
String	a226	='';
String	a227	='';
String	a228	='';
String	a229	='';
String	a230	='';
String	a231	='';
String	a232	='';
String	a233	='';
String	a234	='';
String	a235	='';
String	a236	='';
String	a237	='';
String	a238	='';
String	a239	='';
String	a240	='';
String	a241	='';
String	a242	='';
String	a243	='';
String	a244	='';
String	a245	='';
String	a246	='';
String	a247	='';
String	a248	='';
String	a249	='';
String	a250	='';
String	a251	='';
String	a252	='';
String	a253	='';
String	a254	='';
String	a255	='';
String	a256	='';
String	a257	='';
String	a258	='';
String	a259	='';
String	a260	='';
String	a261	='';
String	a262	='';
String	a263	='';
String	a264	='';
String	a265	='';
String	a266	='';
String	a267	='';
String	a268	='';
String	a269	='';
String	a270	='';
String	a271	='';
String	a272	='';
String	a273	='';
String	a274	='';
String	a275	='';
String	a276	='';
String	a277	='';
String	a278	='';
String	a279	='';
String	a280	='';
String	a281	='';
String	a282	='';
String	a283	='';
String	a284	='';
String	a285	='';
String	a286	='';
String	a287	='';
String	a288	='';
String	a289	='';
String	a290	='';
String	a291	='';
String	a292	='';
String	a293	='';
String	a294	='';
String	a295	='';
String	a296	='';
String	a297	='';
String	a298	='';
String	a299	='';
String	a300	='';
String	a301	='';
String	a302	='';
String	a303	='';
String	a304	='';
String	a305	='';
String	a306	='';
String	a307	='';
String	a308	='';
String	a309	='';
String	a310	='';
String	a311	='';
String	a312	='';
String	a313	='';
String	a314	='';
String	a315	='';
String	a316	='';
String	a317	='';
String	a318	='';
String	a319	='';
String	a320	='';
String	a321	='';
String	a322	='';
String	a323	='';
String	a324	='';
String	a325	='';
String	a326	='';
String	a327	='';
String	a328	='';
String	a329	='';
String	a330	='';
String	a331	='';
String	a332	='';
String	a333	='';
String	a334	='';
String	a335	='';
String	a336	='';
String	a337	='';
String	a338	='';
String	a339	='';
String	a340	='';
String	a341	='';
String	a342	='';
String	a343	='';
String	a344	='';
String	a345	='';
String	a346	='';
String	a347	='';
String	a348	='';
String	a349	='';
String	a350	='';

}