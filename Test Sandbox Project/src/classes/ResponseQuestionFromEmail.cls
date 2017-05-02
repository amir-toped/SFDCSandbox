public class ResponseQuestionFromEmail {
    public List<SurveyTaker__c> surtak{get;set;}
    public List<SurveyQuestionResponse__c> res{get;set;}
    public string Idx{get;set;}
    public string Idy{get;set;}
    public string url{get;set;}
    
    /*
    public ResponseQuestionFromEmail(ApexPages.StandardController controller){
        
    }
    */
    public void response(){
        String surveyId = ApexPages.currentPage().getParameters().get('srvid');
        String survquesId = ApexPages.currentPage().getParameters().get('srvqid');
        //String contactId = ApexPages.currentPage().getParameters().get('conid');
        String accountId = ApexPages.currentPage().getParameters().get('accid');
        String caseId = ApexPages.currentPage().getParameters().get('caseid');
        //String QuestionId = ApexPages.currentPage().getParameters().get('queid');
        String answ = ApexPages.currentPage().getParameters().get('answer');
        //String IdUser = Label.ID_User_Guest;
        //try{
            //if(surveyId != null && survquesId != null && contactId != null && caseId != null && answ != null){
            if(surveyId != null && survquesId != null && accountId != null && caseId != null && answ != null){
                Integer count = [select count() from SurveyTaker__c where Case__c = : caseId];
                if(count > 0){
                    SurveyTaker__c st = [select id from SurveyTaker__c where case__c =:caseId limit 1];
                    //SurveyQuestionResponse__c resp = [select id from SurveyQuestionResponse__c where SurveyTaker__c =: st.id];
                    //Idx = st.id;
                    //Idy = resp.id;
                    url = label.url_sorry;
                    //getSuveyTaker();
                    //getRespondse();
                }
                else{
                    SurveyTaker__c st= new SurveyTaker__c();
                    st.ownerId = Label.ID_User_Guest;
                    st.Case__c = caseId;
                    //st.Contact__c = contactId;
                    st.Account__c = accountId;
                    st.Survey__c = surveyId;
                    st.Survey_Question__c = survquesId;
                    st.Response__c = answ;
                    st.of_Time_Question_was_Responded_to__c = 1;
                    insert st;
                    
                    List<Agent_Response_Case__c> listarc = [select id, Response__c, Survey_Taken__c, Date_Survey_Taken__c from Agent_Response_Case__c where case__c =: caseId];
                    List<Agent_Response_Case__c> listarc2 = new List<Agent_Response_Case__c>();
                    for(Agent_Response_Case__c arc:listarc){
                        arc.response__c = integer.valueof(answ);
                        arc.survey_taken__c = st.Id;
                        arc.date_survey_taken__c = date.today();
                        //update arc;
                        listarc2.add(arc);
                    }
                    if(listarc2.size()>0) update listarc2;
                    //SurveyQuestionResponse__c resp = new SurveyQuestionResponse__c();
                    //resp.Contact__c = contactId;
                    //resp.ownerId = Label.ID_User_Guest;
                    //resp.of_Time_Question_was_Responded_to__c = 1;
                    //resp.Response__c = answ;
                    //resp.Survey_Question__c = survquesId;
                    //resp.SurveyTaker__c = st.id;
                    //insert resp;
                    //Idx = st.id;
                    //Idy = resp.id;
                    url=label.url_thanks;
                    //getSuveyTaker();
                    //getRespondse();    
                }
            }
            
            
        //}
       // catch(exception e){
            
        //}
        //PageReference secondPage = new PageReference('/apex/ResponseQuestionFromEmail');
        //secondPage.setRedirect(true);
        //return secondPage;
    }
    
    String  a1  ='' ;
String  a2  ='' ;
String  a3  ='' ;
String  a4  ='' ;
String  a5  ='' ;
String  a6  ='' ;
String  a7  ='' ;
String  a8  ='' ;
String  a9  ='' ;
String  a10 ='' ;
String  a11 ='' ;
String  a12 ='' ;
String  a13 ='' ;
String  a14 ='' ;
String  a15 ='' ;
String  a16 ='' ;
String  a17 ='' ;
String  a18 ='' ;
String  a19 ='' ;
String  a20 ='' ;
String  a21 ='' ;
String  a22 ='' ;
String  a23 ='' ;
String  a24 ='' ;
String  a25 ='' ;
String  a26 ='' ;
String  a27 ='' ;
String  a28 ='' ;
String  a29 ='' ;
String  a30 ='' ;
String  a31 ='' ;
String  a32 ='' ;
String  a33 ='' ;
String  a34 ='' ;
String  a35 ='' ;
String  a36 ='' ;
String  a37 ='' ;
String  a38 ='' ;
String  a39 ='' ;
String  a40 ='' ;
String  a41 ='' ;
String  a42 ='' ;
String  a43 ='' ;
String  a44 ='' ;
String  a45 ='' ;
String  a46 ='' ;
String  a47 ='' ;
String  a48 ='' ;
String  a49 ='' ;
String  a50 ='' ;
String  a51 ='' ;
String  a52 ='' ;
String  a53 ='' ;
String  a54 ='' ;
String  a55 ='' ;
String  a56 ='' ;
String  a57 ='' ;
String  a58 ='' ;
String  a59 ='' ;
String  a60 ='' ;
String  a61 ='' ;
String  a62 ='' ;
String  a63 ='' ;
String  a64 ='' ;
String  a65 ='' ;
String  a66 ='' ;
String  a67 ='' ;
String  a68 ='' ;
String  a69 ='' ;
String  a70 ='' ;
String  a71 ='' ;
String  a72 ='' ;
String  a73 ='' ;
String  a74 ='' ;
String  a75 ='' ;
String  a76 ='' ;
String  a77 ='' ;
String  a78 ='' ;
String  a79 ='' ;
String  a80 ='' ;
String  a81 ='' ;
String  a82 ='' ;
String  a83 ='' ;
String  a84 ='' ;
String  a85 ='' ;
String  a86 ='' ;
String  a87 ='' ;
String  a88 ='' ;
String  a89 ='' ;
String  a90 ='' ;
String  a91 ='' ;
String  a92 ='' ;
String  a93 ='' ;
String  a94 ='' ;
String  a95 ='' ;
String  a96 ='' ;
String  a97 ='' ;
String  a98 ='' ;
String  a99 ='' ;
String  a100    ='' ;
String  a101    ='' ;
String  a102    ='' ;
String  a103    ='' ;
String  a104    ='' ;
String  a105    ='' ;
String  a106    ='' ;
String  a107    ='' ;
String  a108    ='' ;
String  a109    ='' ;
String  a110    ='' ;
String  a111    ='' ;
String  a112    ='' ;
String  a113    ='' ;
String  a114    ='' ;
String  a115    ='' ;
String  a116    ='' ;
String  a117    ='' ;
String  a118    ='' ;
String  a119    ='' ;
String  a120    ='' ;
String  a121    ='' ;
String  a122    ='' ;
String  a123    ='' ;
String  a124    ='' ;
String  a125    ='' ;
String  a126    ='' ;
String  a127    ='' ;
String  a128    ='' ;
String  a129    ='' ;
String  a130    ='' ;
String  a131    ='' ;
String  a132    ='' ;
String  a133    ='' ;
String  a134    ='' ;
String  a135    ='' ;
String  a136    ='' ;
String  a137    ='' ;
String  a138    ='' ;
String  a139    ='' ;
String  a140    ='' ;
String  a141    ='' ;
String  a142    ='' ;
String  a143    ='' ;
String  a144    ='' ;
String  a145    ='' ;
String  a146    ='' ;
String  a147    ='' ;
String  a148    ='' ;
String  a149    ='' ;
String  a150    ='' ;
    /*
     public List<SurveyTaker__c> getSuveyTaker() {
        DescribeSObjectResult describeResultst = SurveyTaker__c.getSObjectType().getDescribe();
        List<String> stFieldList = new List<String>(describeResultst.fields.getMap().keySet());
        String stFields = String.join(stFieldList, ',');
        String stQuery = ' SELECT ' + stFields + ', case__r.casenumber, owner.name, contact__r.name, account__r.name,  survey__r.name FROM SurveyTaker__c WHERE Id = '+'\''+''+Idx+''+'\''+' ' ;

        return surtak = Database.query(stQuery);
    }
    
    public List<SurveyQuestionResponse__c> getRespondse() {
        DescribeSObjectResult describeResultsv = SurveyQuestionResponse__c.getSObjectType().getDescribe();
        List<String> svFieldList = new List<String>(describeResultsv.fields.getMap().keySet());
        String svFields = String.join(svFieldList, ',');
        String svQuery = ' SELECT ' + svFields + ',  survey_question__r.name, surveytaker__r.name FROM SurveyQuestionResponse__c WHERE Id = '+'\''+Idy+'\''+' ';

        return res = Database.query(svQuery);
    }
    */
    /*
    public String getUrl(){
    return url;
    }
    */
}