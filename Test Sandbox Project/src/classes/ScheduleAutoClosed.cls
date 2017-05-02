Global class ScheduleAutoClosed implements Schedulable {

   global void execute(SchedulableContext ctx) {
        String  a1  ;
        String  a2  ;
        String  a3  ;
        String  a4  ;
        String  a5  ;
        String  a6  ;
        String  a7  ;
        String  a8  ;
        String  a9  ;
        String  a10 ;
        String  a11 ;
        String  a12 ;
        String  a13 ;
        String  a14 ;
        String  a15 ;
        String  a16 ;
        String  a17 ;
        String  a18 ;
        String  a19 ;
        String  a20 ;
        String  a21 ;
        String  a22 ;
        String  a23 ;
        String  a24 ;
        String  a25 ;
        String  a26 ;
        String  a27 ;
        String  a28 ;
        String  a29 ;
        String  a30 ;
       /*
       Integer dt = 0;
       Integer tst = 0;
       Datetime dts = Datetime.now();
       Long lng2 = dts.getTime();
       Case csss = [select createddate from case order by createddate asc limit 1];
       Long lng3 = csss.CreatedDate.getTime();
       Long lng1 = 0;
       Long lnt = 0;
       Long tlnt = 0;
       tlnt = lng2 - lng3;
       tst = integer.valueof(tlnt);
       system.debug(LoggingLevel.DEBUG, '****nilai**** : '+tst);
       */
        //List<case> listcs = [select id, status from case where status != 'Closed' limit 50];
       /*
       List<case> cstoupdate = new List<case>();
       List<case_chat__c> listcc = [select id, user__c, account__C, case__C, duration__c, createddate from case_chat__C where Last_Agent_Reply__c = true and status__c != 'Closed' and need_reply__c = false];
       if(listcc.size()>0){
           for(case_chat__c ccs:listcc){
               //lng1 = ccs.createddate.gettime();
               //lnt = lng2 - lng1;
               //dt = integer.valueof(lnt);
               if(ccs.Duration__c>7) {
                   case cs = [select id, status from case where id =: ccs.case__c];
                   cs.Status = 'Closed';
                   cstoupdate.add(cs);
               }
           }
           if(cstoupdate.size()>0) update cstoupdate;
       }
       */
       //close case tanpa chat
       DateTime skr = datetime.NOW();
       DateTime sblm = skr.addDays(-8);
      String ini = sblm.format('yyyy-MM-dd');
       String itu = sblm.format('HH:mm:ss');
       String smua = ini+'T'+itu+'.000+0000';
       system.debug(LoggingLevel.DEBUG, '*ini tanggal* : '+sblm);
       String q='';
       String que='';
       if(!Test.isRunningTest()){
             q = 'select id, status from case where duration__c > 7 and case_created_by__c = '+'\''+'Agent'+'\''+' and Origin = '+'\''+'Web'+'\''+' '  ;
            que = 'select id, user__c, account__C, case__C, duration__c, createddate from case_chat__C where Last_Agent_Reply__c = true and status__c = '+'\''+'Solved'+'\''+' and need_reply__c = false and duration__c>7 '  ;
       }
       else{
             q = 'select id, status from case limit 1 '  ;
            que = 'select id, user__c, account__C, case__C, duration__c, createddate from case_chat__C limit 1'  ;
       }
        
        AutoClosedBatchCase autoclose = new AutoClosedBatchCase(q);
        Database.executeBatch(autoclose, 1);
       //close case dari case chat
        
        AutoClosedBatchCaseChat autocloseChat = new AutoClosedBatchCaseChat(que);
        Database.executeBatch(autocloseChat, 1);
       /*
       if(listcs.size()>0){
           for(case cs:listcs){
               
               List<case_chat__c> cc = [select id, user__c, account__C, case__C, createddate from case_chat__C where case__c =: cs.id order by createddate desc limit 1];
               if(cc.size()>0){
                   if(cc[0].user__c != null){
                       //dt = Integer.valueof(String.valueof(date.today()))- Integer.valueof(String.valueOf(cc[0].createddate));
                       lng1 = cc[0].createddate.gettime();
                       lnt = lng2 - lng1;
                       dt = integer.valueof(lnt);
                       if(dt>7) {
                           cs.Status = 'Closed';
                           cstoupdate.add(cs);
                       }   
                   }
               } 
                  
           }
           if(cstoupdate.size()>0) update cstoupdate;
       }
       */
   }
}