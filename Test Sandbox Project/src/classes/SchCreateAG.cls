// Create Agent Achivement.
Global class SchCreateAG implements Schedulable {

  public static String CRON_EXP = '0 0 0 3 9 ? 2022';

    Global void execute(SchedulableContext ctx) {

        // check user yang sudah di buat, jgn dibuat 2x.
        list<ID> listuser = new list<ID>();
        for (Agent_Achievement__c checkag : [SELECT id, OwnerId FROM Agent_Achievement__c WHERE Document_Date__c = THIS_MONTH]){
            //listuser.add(string.valueof(checkag.ownerid));
            listuser.add(checkag.ownerid);
        }

        List<Agent_Achievement__c> listag = new list<Agent_Achievement__c>();
        
        list<user> us2;
        if (test.isrunningtest())
            us2 = [SELECT id, FirstName, LastName FROM User WHERE isActive = TRUE and Profile.Name = 'System Administrator' LIMIT 1
                ];
        else
            us2 = [SELECT id, FirstName, LastName FROM User WHERE isActive = TRUE and Profile.Name != 'System Administrator' 
                and Profile.name != 'Chatter Free User'
                and id NOT IN : listuser 
                ];

        for (user us : us2) {
            Agent_Achievement__c ag = new Agent_Achievement__c ();
            ag.OwnerId = us.id;
            ag.Document_Date__c = date.today();
            ag.Name = us.LastName+' '+us.FirstName+' - '+ag.Document_Date__c.Year()+' '+ag.Document_Date__c.Month();
            
            listag.add(ag);
        }
        if (listag.size() > 0) insert listag;
        
    } // end execute
} // end class