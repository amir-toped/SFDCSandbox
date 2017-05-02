trigger assignmentCase on Case (before insert, after insert) {
   /* if (Trigger.isBefore) {
        for(Case c : trigger.new) {
            c.ownerId = '00G28000002Up0h';
        }
    }
    else {
    */
  
List<Id> caseIds = new List<Id>{};

        for (Case theCase:trigger.new) 
            caseIds.add(theCase.Id);
        
        List<Case> cases = new List<Case>{}; 
        for(Case c : [Select Id from Case where Id in :caseIds])
        {
            Database.DMLOptions dmo = new Database.DMLOptions();
 
            dmo.assignmentRuleHeader.useDefaultRule = true;
            c.setOptions(dmo);
            
            cases.add(c);
        }

        Database.upsert(cases);
}