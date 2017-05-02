public with sharing class AgentScheduling{
//public without sharing class AgentScheduling{
    private String soql_AgentScheduling {get;set;}
    public List<Agent_Scheduling__c> datalist_dataplan {get;set;}
    public string valueperiod {get;set;}
    public string valueEntity {get;set;}
    Public String sStatus{get;set;}

    Public String Day01{get;set;}
    Public String Day02{get;set;}
    Public String Day03{get;set;}
    Public String Day04{get;set;}
    Public String Day05{get;set;}
    Public String Day06{get;set;}
    Public String Day07{get;set;}
    Public String Day08{get;set;}
    Public String Day09{get;set;}
    Public String Day10{get;set;}
    Public String Day11{get;set;}
    Public String Day12{get;set;}
    Public String Day13{get;set;}
    Public String Day14{get;set;}
    Public String Day15{get;set;}
    Public String Day16{get;set;}
    Public String Day17{get;set;}
    Public String Day18{get;set;}
    Public String Day19{get;set;}
    Public String Day20{get;set;}
    Public String Day21{get;set;}
    Public String Day22{get;set;}
    Public String Day23{get;set;}
    Public String Day24{get;set;}
    Public String Day25{get;set;}
    Public String Day26{get;set;}
    Public String Day27{get;set;}
    Public String Day28{get;set;}
    Public String Day29{get;set;}
    Public String Day30{get;set;}
    Public String Day31{get;set;}

    public List<SelectOption> dperiod{
        get{
             list<selectOption> objectsList = new list<selectOption>();
                 
             objectsList.add(new SelectOption('Today','Today' ));
             objectsList.add(new SelectOption('Today & H+1','H_1' ));
             objectsList.add(new SelectOption('Today & H+3','H+3' ));
             objectsList.add(new SelectOption('This_Week','This Week' ));
             objectsList.add(new SelectOption('This_Month','This_Month' ));
             return objectsList;
        }
        set;
    }
    
    public String sPeriode {
        get { return System.now().formatGMT('MMMM') + ' ' + String.valueOf(System.today().year()); }
        set;
    } 
    
    public Date dateFrom {
        get { return Date.newInstance(Date.today().year(), Date.today().month(), 1); }
        set;
    }
    
    public Date dateTo {
        get { return Date.newInstance(Date.today().year(), Date.today().month(), date.daysInMonth(Date.today().year(),Date.today().month()));}
        set;
    }
    
    public String sortDir {
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
        set;
    }

    public String sortField {
        get  { if (sortField == null) {sortField = 'Agent__c DESC, name '; } return sortField;  }
        set;
    }
      
    public id username {
        get { return UserInfo.getUserId(); }
        set;
    }

/*    
    Public String sPosisi{
        get{
            User u = [SELECT Agent_Department__c FROM User WHERE id =:UserInfo.getUserId()];
            return u.Agent_Department__c;
        }
        set;
    }
*/

    public List<SelectOption> sPosisi{
        get{
             list<selectOption> objectsList = new list<selectOption>();
            
             objectsList.add(new SelectOption('Ops. Control','Ops. Control' ));
             objectsList.add(new SelectOption('Call Center','Call Center' ));
             objectsList.add(new SelectOption('Social Media','Social Media' ));
             objectsList.add(new SelectOption('Resolution','Resolution' ));
             objectsList.add(new SelectOption('Capt','Capt' ));
             objectsList.add(new SelectOption('PIC','PIC' ));
             objectsList.add(new SelectOption('Back Office','Back Office' ));

             return objectsList;
        }
        set;
    }

    Public Boolean onOff{
        get{
            //if(list_sales.size()>0 && list_sales[0].Status__c == 'Approved') return FALSE;
            //else return TRUE;
            return FALSE;
        }
        set;
    }
    
    public AgentScheduling(){
        //query('');

        date hariini = date.today();
        
        string txtmonth = '';
        string txtday = '';
        
        if (hariini.day() < 10 ) txtday = '0'+hariini.day();
        else txtday = ''+hariini.day();

        if (hariini.month() < 10 ) txtmonth = '0'+hariini.month();
        else txtmonth = ''+hariini.month();
        
        //string hariini2 = hariini.year()+'-'+hariini.month()+'-'+hariini.day() ;
        string hariini2 = hariini.year()+'-'+txtmonth+'-'+txtday ;

        //query(' and Start_Date__c = \'' + namaperiod + '\'');
        query(' and Document_Date__c = '+ hariini2 +' ');
        
    }

    public void runQueryAgentScheduling() {
        try {
            datalist_dataplan = Database.query(soql_AgentScheduling + ' order by ' + sortField + ' ' + sortDir);
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
    }
    
    public PageReference runSearch() {
        String FieldDocument = Apexpages.currentPage().getParameters().get('FieldDocument');
        String FieldBrandId = Apexpages.currentPage().getParameters().get('FieldBrandId');
        String FieldMatGroupId = Apexpages.currentPage().getParameters().get('FieldMatGroupId');
        String FieldModelId = Apexpages.currentPage().getParameters().get('FieldModelId');
        String FieldMaterialId = Apexpages.currentPage().getParameters().get('FieldMaterialId');
        String FieldBCId = Apexpages.currentPage().getParameters().get('FieldBCId');
        String FieldAreaId = Apexpages.currentPage().getParameters().get('FieldAreaId');
        String FieldCabangId = Apexpages.currentPage().getParameters().get('FieldCabangId');

        String sParameter = '';
        
        FieldBrandId = FieldBrandId.removeEnd(',');
        FieldMatGroupId = FieldMatGroupId.removeEnd(',');
        FieldModelId = FieldModelId.removeEnd(',');
        FieldMaterialId = FieldMaterialId.removeEnd(',');
        FieldBCId  = FieldBCId.removeEnd(',');
        FieldAreaId = FieldAreaId.removeEnd(',');
        FieldCabangId = FieldCabangId.removeEnd(',');
        
        if (!FieldDocument.equals('')){ sParameter += ' and Document__c LIKE \''+String.escapeSingleQuotes(FieldDocument)+'\'';}
        if (!FieldBrandId.equals('')){ sParameter += ' and Brand__c in ('+ FieldBrandId +')';}
        if (!FieldMatGroupId.equals('')){ sParameter += ' and Material_Group__c in ('+ FieldMatGroupId +')';}
        if (!FieldModelId.equals('')){sParameter += ' and Model__c in ('+ FieldModelId +')';}
        if (!FieldMaterialId.equals('')){sParameter += ' and Material__c in ('+ FieldMaterialId +')';}
        if (!FieldBCId.equals('')){sParameter += ' and Sales_Plan__r.Owner.Name in ('+ FieldBCId +')';}
        if (!FieldAreaId.equals('')){sParameter += ' and Sales_Plan__r.Area__c in ('+ FieldAreaId +')';}
        if (!FieldCabangId.equals('')){sParameter += ' and Sales_Plan__r.Cabang__c in ('+ FieldCabangId +')';}
        
        query(sParameter);
           
        return null;
    }
    
    private void query(String sParameter){
        String sToday = String.valueOf(System.today().month()) + String.valueOf(System.today().year());
        User u = [SELECT Agent_Department__c FROM User WHERE id =:UserInfo.getUserId()];
        string sNewPosisi = u.Agent_Department__c;
        string sQueryParam = '';
        
        string sEntity = ' and Agent_Department__c = \''+valueEntity+'\' ';

        //total_size_AgentScheduling = Database.countQuery('select count() from Agent_Scheduling__c WHERE id != null AND Sales_Plan__r.Periode__c = \'' + sToday + '\'' + sParameter + sQueryParam);
        //filter by request date
        soql_AgentScheduling = 'SELECT id, OwnerID, Name, '+
                            ' Agent__c, Agent_Name__c,  '+
                            ' Agent_Shift__c,  '+
                            ' Day_01__c, Day_02__c, Day_03__c, Day_04__c, Day_05__c, Day_06__c, Day_07__c,  '+
                            ' Day_08__c, Day_09__c, Day_10__c, Day_11__c, Day_12__c, Day_13__c, Day_14__c,  '+
                            ' Day_15__c, Day_16__c, Day_17__c, Day_18__c, Day_19__c, Day_20__c, Day_21__c,  '+
                            ' Day_22__c, Day_23__c, Day_24__c, Day_25__c, Day_26__c, Day_27__c, Day_28__c,  '+
                            ' Day_29__c, Day_30__c, Day_31__c, Day_Name__c,  '+
                            ' Agent_Department__c, Description__c, Document_Date__c, Ext_ID__c, Gender__c,  '+
                            ' Last_Day__c, Periode__c, Reason_Type__c, Schedule_Shift__c, '+
                            ' SS_01__c, SS_02__c, SS_03__c, SS_04__c, SS_05__c, SS_06__c, SS_07__c,  '+
                            ' SS_08__c, SS_09__c, SS_10__c, SS_11__c, SS_12__c, SS_13__c, SS_14__c,  '+
                            ' SS_15__c, SS_16__c, SS_17__c, SS_18__c, SS_19__c, SS_20__c, SS_21__c,  '+
                            ' SS_22__c, SS_23__c, SS_24__c, SS_25__c, SS_26__c, SS_27__c, SS_28__c,  '+
                            ' SS_29__c, SS_30__c, SS_31__c, Title__c '+
                            ' FROM Agent_Scheduling__c WHERE id != null '+sEntity+' '+sParameter ;

        datetime dt2 = datetime.now();
        sStatus = string.valueof(dt2);

        runQueryAgentScheduling();

    }

    public PageReference GetData() {
        date paramday = date.today();
        date thisday = date.today();
        
        string sParameter = '';
             if (valueperiod == 'Today' || valueperiod == 'Today')
                 paramday = date.today();
             if (valueperiod == 'Today & H+1' || valueperiod == 'H_1' )
                paramday = thisday+1;
             if (valueperiod == 'Today & H+3' || valueperiod == 'H+3' )
                paramday = thisday+3;


        string txtmonth = '';
        string txtday = '';
        
        if (paramday.day() < 10 ) txtday = '0'+paramday.day();
        else txtday = ''+paramday.day();
        if (paramday.month() < 10 ) txtmonth = '0'+paramday.month();
        else txtmonth = ''+paramday.month();

        //string paramday2 = paramday.year()+'-'+paramday.month()+'-'+paramday.day() ;
        string paramday2 = paramday.year()+'-'+txtmonth+'-'+txtday ;

        if (thisday.day() < 10 ) txtday = '0'+thisday.day();
        else txtday = ''+thisday.day();
        if (thisday.month() < 10 ) txtmonth = '0'+thisday.month();
        else txtmonth = ''+thisday.month();

        //string thisday2 = thisday.year()+'-'+thisday.month()+'-'+thisday.day() ;
        string thisday2 = thisday.year()+'-'+txtmonth+'-'+txtday ;

        sParameter = ' and Document_Date__c >= '+thisday2+' and Document_Date__c <= '+paramday2+' ';

             if (valueperiod == 'This_Week' || valueperiod == 'This Week' )
                sParameter = ' and Document_Date__c = this_week ';
             if (valueperiod == 'This_Month' || valueperiod == 'This_Month')
                sParameter = ' and Document_Date__c = this_month ';


        query(sParameter);

        //query(' and Plan_Period__c = \'' + dperiod + '\'');

        //runQueryAgentScheduling(); //getDataList();
        return null;
    }
            
    public Pagereference Save(){
        Savepoint spoint = Database.setSavepoint();
        try{
            Integer check = 0;
            List<Agent_Scheduling__c> newsales = new List<Agent_Scheduling__c>();
            User u = [SELECT Agent_Department__c FROM User WHERE id =:UserInfo.getUserId()];
            string sNewPosisi = u.Agent_Department__c;
            
            for(Agent_Scheduling__c pp : datalist_dataplan){                    
                check +=1;
                newsales.add(pp);  
            }
            if(newsales.size()>0) update newsales;
            
            if(check == 0)
            { 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Check ' + sPosisi + ' harus dichecklist'));
                Database.rollback(spoint);
                return null;
            }else{
                //PageReference pageRef = Page.AgentScheduling;
                //pageRef.setRedirect(true);
                //return pageRef;
                return null;
            }
        }catch(System.DmlException e){ 
            Database.rollback(spoint);
            return null; 
        }
        
    }
    
}