trigger CommentTiket_Integration on Case_Chat__c (before insert) {
    for(Case_Chat__c x:trigger.new){
        if(x.Migration__c==true){
            if(x.duplicate_key__c != null ){
                list<account> acc = [select id from account where duplicate_key__c =:x.duplicate_key__c];
                if(acc.size()>0){
                    for(account ac:acc){
                        x.account__c = ac.id;
                    }
                }    
                    
            }
            if(x.agent_email__C !=null){
                List<user> us = [select id from user where email=:x.agent_email__c];
                if(us.size()>0){
                    for(User uss:us){
                        x.user__C = uss.id;        
                    }
                }
                
            }
            if(x.tiket_id__c != null){
                List<case> cs = [select id from case where tiket_id__C =: x.tiket_id__c];
                if(cs.size()>0) {
                    for(case css:cs){
                        x.case__c = css.id;    
                    }
                }    
                    
            }
        }
    }
}