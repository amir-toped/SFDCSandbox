@isTest(seeAllData=true)
private class Test_UserPresence{

    static testMethod void myTest() {
        Test.startTest();

        UserServicePresence tsk = new UserServicePresence();
        tsk.UserId = UserInfo.getUserId();
        tsk.ServicePresenceStatusId = id.valueof(label.Available);
        //tsk.StatusStartDate = Date.newInstance(2017, 1, 1);
        insert tsk;
        
        tsk = new UserServicePresence();
        tsk.UserId = UserInfo.getUserId();
        tsk.ServicePresenceStatusId = id.valueof(label.Away);
        //tsk.StatusEndDate = Datetime.now();
        insert tsk;

                
        Test.stopTest();
    }
}