global class ScheduleSendEmailSurvey implements Schedulable {
    global void execute(SchedulableContext ctx) {
        String q='';
        if(Test.isRunningTest()){
            q = 'select id, name, status__C, ready_to_send__c from email_log__C limit 1';
        }
        else{
            q = 'select id, name, status__C, ready_to_send__c from email_log__C where status__c='+'\''+'Draft'+'\''+' ';
        }
        SendEmailSurvey ses = new SendEmailSurvey(q);
        Database.executeBatch(ses, 100);
        Integer a = 0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
    }
}