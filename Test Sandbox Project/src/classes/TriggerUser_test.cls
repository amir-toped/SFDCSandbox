@isTest(seeAllData=true)
private class TriggerUser_test {
    static testmethod void user(){
        DescribeSObjectResult describeResultUsr = User.getSObjectType().getDescribe();
        List<String> usrFieldList = new List<String>(describeResultUsr.fields.getMap().keySet());
        String usrFields = String.join(usrFieldList, ',');
        String usrQuery = ' SELECT ' + usrFields + ' FROM User limit 1 ';
        User currentUsr = Database.query(usrQuery);
		User usr = currentUsr.clone(false);
        usr.LastName = 'Dewa';
        usr.CommunityNickname = 'Awed';
        usr.Alias = 'Parade';
        usr.Username = 'sodasusu@gmail.com';
        usr.Signature__c = '';
        Test.startTest();
        insert usr;
        usr.Signature__c = 'Thanks';
        update usr;
        Test.stopTest();
    }
}