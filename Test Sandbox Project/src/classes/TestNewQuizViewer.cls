@isTest
public class TestNewQuizViewer {

    static testmethod void testQuizViewerWeb(){
        //Create admin users
        List<User> adminUsers = TestUtilClass.createUsers(2,'System Administrator');
        List<User> lmsUsers = TestUtilClass.createUsers(5,'Standard User');

        System.runAs(adminUsers.get(0)){
            //Assign corresponding perm sets
            TestUtilClass.addPermissionSet(adminUsers,'LMS_Admin');
            TestUtilClass.addPermissionSet(lmsUsers,'LMS_User');
        }

        TestTrainingPlanData.createSampleData();
        List<Training_Plan__c> tplan = [select id from Training_Plan__c];
        System.assertEquals(1,tplan.size());

        List<Achievement_Category__c> lAchieveCat = TestAchievementData.createAchievementCategories(1);
        List<Achievement__c> lAchievement = TestAchievementData.createAchievements(1, lAchieveCat.get(0).Id, 'Achievements');
        List<Training_Plan_Achievement__c> lTPlanAchievement = TestTrainingPlanData.createTrainingPlanAchievements(tplan, lAchievement);

        Id tplanId = tplan.get(0).Id;
        Set<Id> selectedUserIds = new Set<Id>();

        for(User u : lmsUsers){
            selectedUserIds.add(u.Id);
        }

        //Test Insert
        Test.startTest();
            System.runAs(adminUsers.get(0)){
                LMSService.upsertAssignments(selectedUserIds,tplanId,null);
            }
        Test.stopTest();

        List<Training_Plan_Section__c> ltpsec = [select id from Training_Plan_Section__c where Training_Plan__c =: tplanId order by Order__c asc];
        System.assert(ltpsec.size() == 3);

        List<Training_Plan_Section_Item__c> ltpsitem = [select id from Training_Plan_Section_Item__c where Training_Plan_Section__c =: ltpsec.get(0).Id order by Order__c asc];
        //System.assert(ltpsitem.size() == 1, 'Training Plan Section Item issues, size = ' + ltpsitem.size());

        List<Learning_Assignment__c> lassignment = [select Id,
                                                        Learning__c, Learning_Version__r.Quiz__c from Learning_Assignment__c
                                                        where Training_Plan__c =: tplanId
                                                        and Training_Plan_Section__c =:ltpsec.get(0).Id
                                                        and User__c =: lmsUsers.get(0).Id];

        System.assert(lassignment.size() == 1, 'Learning Assignment issues, size = ' + lassignment.size());
        System.assert(lassignment.get(0).Learning_Version__r.Quiz__c != null, 'Learning Assignment is not for Quiz');

        Set<Id> qlineIds = new Set<Id>();
        for(Question_Line__c oql : [select Id from Question_Line__c where Quiz__c =: lassignment.get(0).Learning_Version__r.Quiz__c]){
            qlineIds.add(oql.Id);
        }

        Map<String, Response__c> mResponses = TestLearningData.createTestQuestionResponses(qlineIds, lmsUsers.get(0).Id, lassignment.get(0).Id);


        System.runAs(lmsUsers.get(0)){
            PageReference pageRef = Page.NewQuizViewer;
            Test.setCurrentPage(pageRef);
            pageRef.getHeaders().put('User-Agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:25.0) Gecko/20100101 Firefox/25.0');
            pageRef.getParameters().put('aid', lassignment.get(0).Id);
            NewQuizViewerController controller = new NewQuizViewerController();
            controller.initializeQuestions();

            //first section
            List<QuizItem> lqi = controller.quizItemList;

            for(QuizItem qi : lqi){
                qi.response  = mResponses.get(qi.question.Id);
            }

            controller.next();

            //second section
            List<QuizItem> lqi2 = controller.quizItemList;

            for(QuizItem qi : lqi2){
                qi.response  = mResponses.get(qi.question.Id);
            }
            //controller.previous();
            controller.next();

            //third & final section
            List<QuizItem> lqi3 = controller.quizItemList;

            for(QuizItem qi : lqi3){
                qi.response  = mResponses.get(qi.question.Id);
            }
            controller.done();
        }
    }

    static testmethod void testQuizViewerWeb2(){
        //Create admin users
        List<User> adminUsers = TestUtilClass.createUsers(2,'System Administrator');
        List<User> lmsUsers = TestUtilClass.createUsers(5,'Standard User');

        System.runAs(adminUsers.get(0)){
            //Assign corresponding perm sets
            TestUtilClass.addPermissionSet(adminUsers,'LMS_Admin');
            TestUtilClass.addPermissionSet(lmsUsers,'LMS_User');
        }

        TestTrainingPlanData.createSampleData();
        List<Training_Plan__c> tplan = [select id from Training_Plan__c];
        System.assertEquals(1,tplan.size());

        List<Achievement_Category__c> lAchieveCat = TestAchievementData.createAchievementCategories(1);
        List<Achievement__c> lAchievement = TestAchievementData.createAchievements(1, lAchieveCat.get(0).Id, 'Achievements');
        List<Training_Plan_Achievement__c> lTPlanAchievement = TestTrainingPlanData.createTrainingPlanAchievements(tplan, lAchievement);

        Id tplanId = tplan.get(0).Id;
        Set<Id> selectedUserIds = new Set<Id>();

        for(User u : lmsUsers){
            selectedUserIds.add(u.Id);
        }

        //Test Insert
        Test.startTest();
            System.runAs(adminUsers.get(0)){
                LMSService.upsertAssignments(selectedUserIds,tplanId,null);
            }
        Test.stopTest();

        List<Training_Plan_Section__c> ltpsec = [select id from Training_Plan_Section__c where Training_Plan__c =: tplanId order by Order__c asc];
        System.assert(ltpsec.size() == 3);

        List<Training_Plan_Section_Item__c> ltpsitem = [select id from Training_Plan_Section_Item__c where Training_Plan_Section__c =: ltpsec.get(0).Id order by Order__c asc];
        System.assert(ltpsitem.size() == 1, 'Training Plan Section Item issues, size = ' + ltpsitem.size());

        List<Learning_Assignment__c> lassignment = [select Id,
                                                        Learning__c, Learning_Version__r.Quiz__c from Learning_Assignment__c
                                                        where Training_Plan__c =: tplanId
                                                        and Training_Plan_Section__c =:ltpsec.get(0).Id
                                                        and User__c =: lmsUsers.get(0).Id];

        System.assert(lassignment.size() == 1, 'Learning Assignment issues, size = ' + lassignment.size());
        System.assert(lassignment.get(0).Learning_Version__r.Quiz__c != null, 'Learning Assignment is not for Quiz');

        Set<Id> qlineIds = new Set<Id>();
        for(Question_Line__c oql : [select Id from Question_Line__c where Quiz__c =: lassignment.get(0).Learning_Version__r.Quiz__c]){
            qlineIds.add(oql.Id);
        }

        Map<String, Response__c> mResponses = TestLearningData.createTestQuestionResponses(qlineIds, lmsUsers.get(0).Id, lassignment.get(0).Id);


        System.runAs(lmsUsers.get(0)){
            PageReference pageRef = Page.NewQuizViewer;
            Test.setCurrentPage(pageRef);
            pageRef.getHeaders().put('User-Agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:25.0) Gecko/20100101 Firefox/25.0');
            pageRef.getParameters().put('aid', lassignment.get(0).Id);
            NewQuizViewerController controller = new NewQuizViewerController();
            controller.initializeQuestions();

            //first section
            List<QuizItem> lqi = controller.quizItemList;

            for(QuizItem qi : lqi){
                qi.response  = mResponses.get(qi.question.Id);
            }

            controller.next();
            controller.previous();
            PageReference redirect = controller.backToTrainingPlan();
            System.assert(redirect.getParameters().get('id') == tplanId, 'backToTrainingPlan is not adding params properly');

            //go back to quiz & reset it
            PageReference pageRef2 = Page.NewQuizViewer;
            Test.setCurrentPage(pageRef2);
            pageRef.getHeaders().put('User-Agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:25.0) Gecko/20100101 Firefox/25.0');
            pageRef2.getParameters().put('aid', lassignment.get(0).Id);
            NewQuizViewerController controller2 = new NewQuizViewerController();
            controller2.initializeQuestions();
            PageReference redirect2 = controller2.reset();
            System.assert(redirect2.getParameters().get('aid') == lassignment.get(0).Id, 'reset is not adding params properly');


        }
    }

    static testmethod void testQuizViewerPreview(){
        //Create admin users
        List<User> adminUsers = TestUtilClass.createUsers(2,'System Administrator');
        List<User> lmsUsers = TestUtilClass.createUsers(5,'Standard User');

        System.runAs(adminUsers.get(0)){
            //Assign corresponding perm sets
            TestUtilClass.addPermissionSet(adminUsers,'LMS_Admin');
            TestUtilClass.addPermissionSet(lmsUsers,'LMS_User');
        }

        TestTrainingPlanData.createSampleData();
        List<Training_Plan__c> tplan = [select id from Training_Plan__c];
        System.assertEquals(1,tplan.size());

        List<Achievement_Category__c> lAchieveCat = TestAchievementData.createAchievementCategories(1);
        List<Achievement__c> lAchievement = TestAchievementData.createAchievements(1, lAchieveCat.get(0).Id, 'Achievements');
        List<Training_Plan_Achievement__c> lTPlanAchievement = TestTrainingPlanData.createTrainingPlanAchievements(tplan, lAchievement);

        Id tplanId = tplan.get(0).Id;
        Set<Id> selectedUserIds = new Set<Id>();

        for(User u : lmsUsers){
            selectedUserIds.add(u.Id);
        }

        //Test Insert
        Test.startTest();
            System.runAs(adminUsers.get(0)){
                LMSService.upsertAssignments(selectedUserIds,tplanId,null);
            }
        Test.stopTest();

        List<Training_Plan_Section__c> ltpsec = [select id from Training_Plan_Section__c where Training_Plan__c =: tplanId order by Order__c asc];
        System.assert(ltpsec.size() == 3);

        List<Training_Plan_Section_Item__c> ltpsitem = [select id from Training_Plan_Section_Item__c where Training_Plan_Section__c =: ltpsec.get(0).Id order by Order__c asc];
        System.assert(ltpsitem.size() == 1, 'Training Plan Section Item issues, size = ' + ltpsitem.size());

        List<Learning_Assignment__c> lassignment = [select Id,
                                                        Learning__c, Learning_Version__r.Quiz__c from Learning_Assignment__c
                                                        where Training_Plan__c =: tplanId
                                                        and Training_Plan_Section__c =:ltpsec.get(0).Id
                                                        and User__c =: lmsUsers.get(0).Id];

        System.assert(lassignment.size() == 1, 'Learning Assignment issues, size = ' + lassignment.size());
        System.assert(lassignment.get(0).Learning_Version__r.Quiz__c != null, 'Learning Assignment is not for Quiz');

        Set<Id> qlineIds = new Set<Id>();
        for(Question_Line__c oql : [select Id from Question_Line__c where Quiz__c =: lassignment.get(0).Learning_Version__r.Quiz__c]){
            qlineIds.add(oql.Id);
        }

        Map<String, Response__c> mResponses = TestLearningData.createTestQuestionResponses(qlineIds, lmsUsers.get(0).Id, lassignment.get(0).Id);


        System.runAs(lmsUsers.get(0)){
            PageReference pageRef = Page.NewQuizViewer;
            Test.setCurrentPage(pageRef);
            pageRef.getHeaders().put('User-Agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:25.0) Gecko/20100101 Firefox/25.0');
            pageRef.getParameters().put('aid', lassignment.get(0).Id);
            pageRef.getParameters().put('pMode', 'true');

            NewQuizViewerController controller = new NewQuizViewerController();
            controller.initializeQuestions();

            //first section
            List<QuizItem> lqi = controller.quizItemList;

            for(QuizItem qi : lqi){
                qi.response  = mResponses.get(qi.question.Id);
            }

            controller.next();

            //second section
            List<QuizItem> lqi2 = controller.quizItemList;

            for(QuizItem qi : lqi2){
                qi.response  = mResponses.get(qi.question.Id);
            }
            //controller.previous();
            controller.next();

            //third & final section
            List<QuizItem> lqi3 = controller.quizItemList;

            for(QuizItem qi : lqi3){
                qi.response  = mResponses.get(qi.question.Id);
            }
            controller.done();
        }
    }
}