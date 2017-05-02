trigger Acc_CreateContact on Account (After Insert, After Update) {
    for (Account ac : trigger.new) {
    if (ac.IsPersonAccount) {
        boolean check = FALSE;
        if (trigger.IsUpdate) {
            if (ac.PersonMobilePhone != Trigger.oldMap.get(ac.Id).PersonMobilePhone || ac.Phone != Trigger.oldMap.get(ac.Id).Phone) {
                if (ac.Contact__c == NULL) check = TRUE;
                else {
                    Contact ct2 = [SELECT id, Phone, MobilePhone FROM Contact WHERE id =: ac.Contact__c];
                    ct2.Phone = '9'+ac.Phone;
                    ct2.MobilePhone = '9'+ac.PersonMobilePhone;
                    update ct2;
                }
            }
        }
        if (trigger.IsInsert || check) {
            contact ct = new contact ();
                ct.Salutation = ac.Salutation;
                ct.FirstName = ac.FirstName;
                ct.LastName = ac.LastName;
                ct.Phone = '9'+ac.Phone;
                ct.MobilePhone = '9'+ac.PersonMobilePhone;
                ct.Person_Account__c = ac.id;
            insert ct;
            
            Account ac2 = [SELECT id, Contact__c FROM Account WHERE id =:ac.id];
            ac2.Contact__c = ct.id;
            update ac2;
        } // end insert
    } // end if IsPersonAccount
    } // end for
} // end trigger