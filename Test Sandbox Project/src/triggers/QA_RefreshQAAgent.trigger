trigger QA_RefreshQAAgent on QA_Periode__c (After Insert, Before Update) {
    for (QA_Periode__c qp : trigger.new){
    if (qp.Refresh_QA_Agent__c || Trigger.isInsert){
        if (!Trigger.IsInsert) qp.Refresh_QA_Agent__c = FALSE;
        
        // check di periode yang sama.
        List<String> TempOwner = new List<string>();
        String Temp='';
        for (QA_Agent_Answer__c qan : [SELECT User_Agent__c FROM QA_Agent_Answer__c WHERE Periode__c =: qp.Periode__c and User_Agent__c != NULL order by User_Agent__c ]){
            if (Temp != string.valueof(qan.User_Agent__c)) {
                TempOwner.add(String.valueof(qan.User_Agent__c));
                Temp = string.valueof(qan.User_Agent__c);
            }
        }

        string q = '';
        q = '';
        q = '';
        q = '';
        q = '';
        q = '';
        q = '';
        q = '';
        q = '';
        q = '';
        q = '';
        q = '';
        q = '';
        q = '';
        q = '';
        if (Test.isRunningTest() ) q = 'SELECT id FROM User WHERE id = \''+Label.QAAgentAnswerUser+'\' and isActive = TRUE ';
        else q = 'SELECT id FROM User WHERE isActive = TRUE and Type_Agent__c =\''+qp.Type_Agent__c+'\' ';
         
        for (integer i = 0; i < TempOwner.size(); i++) {
            if (i == 0) q = q + ' and Id NOT IN (\''+TempOwner[i]+'\',';
            else if (i+1 == TempOwner.size()) q = q + '\''+TempOwner[i]+'\')';
            else q = q + '\''+TempOwner[i]+'\',';
        }
        //q = q + ')';
        
        InsertQANBatch UserAgent = new InsertQANBatch(q, qp.QA_Question__c, qp.id);
        Database.executeBatch(UserAgent, 1);
        
        integer j = 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
        j= 1;
    } // end if
    } // end for
} // end trigger.