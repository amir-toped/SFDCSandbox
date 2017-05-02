public class CaseChat{
    public List<Case_Chat__c> objChat {get;set;}
    public Case_Chat__c Chater {get;set;}
    public String msg {get;set;}
    public String img1 {get;set;}
    public String img2 {get;set;}
    public String img3 {get;set;}
    public String img4 {get;set;}
    public String img5 {get;set;}
    public String img6 {get;set;}
    private integer index = 0;
    private integer blockSize = 10;
    private String soql {get;set;}
    public integer totalRecs {get;set;}
     public Boolean fetchCalled;
    //Public String ids {get;set;}
    
    public CaseChat(ApexPages.StandardController controller) {
		String ids = ApexPages.currentPage().getParameters().get('id');
        Integer ccs = [select count() from case_chat__c where case__c =: ids];
        totalrecs = ccs;
    }
    /*
    Public List<Case_Chat__c> getChating(){
        String ids = ApexPages.currentPage().getParameters().get('id');
        DescribeSObjectResult describeResultchat = Case_Chat__c.getSObjectType().getDescribe();
        List<String> chatFieldList = new List<String>(describeResultchat.fields.getMap().keySet());
        String chatFields = String.join(chatFieldList, ',');
        String chatQuery = ' SELECT ' + chatFields + ' FROM Case_Chat__c WHERE case__c = '+'\''+ids+'\''+' order by createddate desc';
        return objChat = Database.query(chatQuery);
    }
*/
    
    Public List<Case_Chat__c> getChating(){
        String ids = ApexPages.currentPage().getParameters().get('id');
        //DescribeSObjectResult describeResultchat = Case_Chat__c.getSObjectType().getDescribe();
        //List<String> chatFieldList = new List<String>(describeResultchat.fields.getMap().keySet());
        //String chatFields = String.join(chatFieldList, ',');
        String chatQuery = ' SELECT id,name, account__c, case__C, user__c, contact__C, CreateddateTZ__c, Image_1__c, Image_2__c,Image_3__c, Image_4__c, Image_5__c, Image_6__c, messages2__c, agent_name__c, Account_Name__c, Contact_Name__c  FROM Case_Chat__c WHERE case__c = '+'\''+ids+'\''+' order by createddate desc LIMIT ' + blockSize + ' OFFSET ' + index;
        return objChat = Database.query(chatQuery);
    }
    
    public void beginning()
    {
        index = 0;
    }
    
    public void previous()
    {
        index = index - blockSize;
    }
    
    public void next()
    {
        index = index + blockSize;
    }
    
    public void end()
    {
        index = totalrecs - math.mod(totalRecs,blockSize);
    }
    
    public boolean getprev()
    {
        if(index == 0)
        return true;
        else
        return false;
    }
    
     public boolean getnxt()
    {
        if((index + blockSize) >= totalRecs)
        return true;
        else
        return false;
    }
    
    Public void Post(){
        try{
            String ids = ApexPages.currentPage().getParameters().get('id');
            Case_Chat__c cc = new Case_Chat__c();
            cc.name = 'new';
            cc.case__c = ids;
            cc.Messages2__c = msg;
            cc.Image_1__c = img1 ;
            cc.Image_2__c = img2 ;
            cc.Image_3__c = img3 ;
            cc.Image_4__c = img4 ;
            cc.Image_5__c = img5 ;
            cc.Image_6__c = img6 ;
            //System.debug(loggingLevel.ERROR, '***error*** :'+msg);
            insert cc;
            msg = '';
            img1 = '';
            img2 = '';
            img3 = '';
            img4 = '';
            img5 = '';
            img6 = '';
        }
        catch(exception e){
            system.debug(logginglevel.error, 'this error : '+e);
            
        }
        getChating(); 
    }
    
    String	a1	='';
String	a2	='';
String	a3	='';
String	a4	='';
String	a5	='';
String	a6	='';
String	a7	='';
String	a8	='';
String	a9	='';
String	a10	='';
String	a11	='';
String	a12	='';
String	a13	='';
String	a14	='';
String	a15	='';
String	a16	='';
String	a17	='';
String	a18	='';
String	a19	='';
String	a20	='';
String	a21	='';
String	a22	='';
String	a23	='';
String	a24	='';
String	a25	='';
String	a26	='';
String	a27	='';
String	a28	='';
String	a29	='';
String	a30	='';
String	a31	='';
String	a32	='';
String	a33	='';
String	a34	='';
String	a35	='';
String	a36	='';
String	a37	='';
String	a38	='';
String	a39	='';
String	a40	='';
String	a41	='';
String	a42	='';
String	a43	='';
String	a44	='';
String	a45	='';
String	a46	='';
String	a47	='';
String	a48	='';
String	a49	='';
String	a50	='';
String	a51	='';
String	a52	='';
String	a53	='';
String	a54	='';
String	a55	='';
String	a56	='';
String	a57	='';
String	a58	='';
String	a59	='';
String	a60	='';
String	a61	='';
String	a62	='';
String	a63	='';
String	a64	='';
String	a65	='';
String	a66	='';
String	a67	='';
String	a68	='';
String	a69	='';
String	a70	='';
String	a71	='';
String	a72	='';
String	a73	='';
String	a74	='';
String	a75	='';
String	a76	='';
String	a77	='';
String	a78	='';
String	a79	='';
String	a80	='';
String	a81	='';
String	a82	='';
String	a83	='';
String	a84	='';
String	a85	='';
String	a86	='';
String	a87	='';
String	a88	='';
String	a89	='';
String	a90	='';
String	a91	='';
String	a92	='';
String	a93	='';
String	a94	='';
String	a95	='';
String	a96	='';
String	a97	='';
String	a98	='';
String	a99	='';
String	a100	='';

}