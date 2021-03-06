public class MultipleAgentScheduling {
  private ApexPages.StandardController controller;
    public List<Agent_Scheduling__c> oliDelList {get;set;}
    public List<OliWrapper> oliWrapperList {get;set;}
    public List<SelectOption> priceBookOptionList {get;set;}
    public Integer rowToRemove {get;set;}
    public Id opportunityId {get;set;}
    public OliWrapper delOli {get;set;}
    public String selectedItem {get;set;}
    public String selectedPriceBook {get;set;}
    public Id selectedPriceBookId {get;set;}
    public Boolean existingRendered {get;set;}
    public Boolean newRendered {get;set;}
    public Boolean priceBookDisabled {get;set;}
    public Boolean productRowRendered {get;set;}
    public Integer countOldProduct {get;set;}
    public string valuePosisi {get;set;}
    public string valueperiod {get;set;}

    public String sPeriode {
        get { return System.now().formatGMT('MMMM') + ' ' + String.valueOf(System.today().year()); }
        set;
    } 

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

    public List<SelectOption> dperiod{
        get{
             list<selectOption> objectsList = new list<selectOption>();
                 
             objectsList.add(new SelectOption('This_Month','This_Month' ));
             objectsList.add(new SelectOption('Next_Month','Next_Month' ));
             objectsList.add(new SelectOption('Last_Month','Last_Month' ));
             return objectsList;
        }
        set;
    }
    
    private static final String NONE = '--- None ---';
    private static final String LBL_OPPORTUNITY = 'Project Package Information';
    private static final String LBL_PRICE_BOOK = 'Price Book Information';
    public String lblOpportunity {get;set;}
    public String lblPriceBook {get;set;}

    public Boolean FlagDay29 {get;set;}
    public Boolean FlagDay30 {get;set;}
    public Boolean FlagDay31 {get;set;}

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
    Public String TempPeriod{get;set;}
    Public String TempDepartment{get;set;}

    
    public class OliWrapper {
        public Integer index {get;set;}
        public Agent_Scheduling__c oli {get;set;}
    }
    
    public MultipleAgentScheduling(ApexPages.StandardController controller) {
        this.controller = controller;
        //String opportunityId = ApexPages.currentPage().getParameters().get('id');
        TempPeriod = ApexPages.currentPage().getParameters().get('period');
        TempDepartment = ApexPages.currentPage().getParameters().get('department');
        
        // insert data awal.
        string sParameter = '';
        if (TempPeriod != '')
            sParameter = sParameter+' and Document_Date__c = '+TempPeriod+' ';

        if (TempDepartment != '')
            sParameter = sParameter+' and Agent_Department__c = \''+TempDepartment+'\' ';
        else
            sParameter = sParameter+' and Agent_Department__c = \'Ops. Control\' ';
                         
        //Agent_Scheduling__c
        DescribeSObjectResult describeResultOli = Agent_Scheduling__c.getSObjectType().getDescribe();
        List<String> oliFieldList = new List<String>(describeResultOli.fields.getMap().keySet());
        String oliFields = String.join(oliFieldList, ',');
        String oliQuery = ' SELECT ' + oliFields + ' FROM Agent_Scheduling__c WHERE id != NULL '+sParameter+' ORDER BY Id ASC ';
        List<SObject> currentOliList = Database.query(oliQuery);
        
        this.oliWrapperList = new List<OliWrapper>();
        this.oliDelList = new List<Agent_Scheduling__c>();
        
        FlagDay29 = FALSE;
        FlagDay30 = FALSE;
        FlagDay31 = FALSE;
        
        for (SObject currentOli : currentOliList) {
            OliWrapper newWrapper = new OliWrapper();
            Agent_Scheduling__c newOli = (Agent_Scheduling__c) currentOli;
            newWrapper.index = this.oliWrapperList.size();
            newWrapper.oli = newOli;
            this.oliWrapperList.add(newWrapper);

            if (currentOliList.size() > 0) {
                
                FlagDay29 = integer.valueof(newOli.Last_Day__c) >= 29;
                FlagDay30 = integer.valueof(newOli.Last_Day__c) >= 30;
                FlagDay31 = integer.valueof(newOli.Last_Day__c) >= 31;
                Day01 = '01 ('+newOli.Day_01__c+')';
                Day02 = '02 ('+newOli.Day_02__c+')';
                Day03 = '03 ('+newOli.Day_03__c+')';
                Day04 = '04 ('+newOli.Day_04__c+')';
                Day05 = '05 ('+newOli.Day_05__c+')';
                Day06 = '06 ('+newOli.Day_06__c+')';
                Day07 = '07 ('+newOli.Day_07__c+')';
                Day08 = '08 ('+newOli.Day_08__c+')';
                Day09 = '09 ('+newOli.Day_09__c+')';
                Day10 = '10 ('+newOli.Day_10__c+')';
                Day11 = '11 ('+newOli.Day_11__c+')';
                Day12 = '12 ('+newOli.Day_12__c+')';
                Day13 = '13 ('+newOli.Day_13__c+')';
                Day14 = '14 ('+newOli.Day_14__c+')';
                Day15 = '15 ('+newOli.Day_15__c+')';
                Day16 = '16 ('+newOli.Day_16__c+')';
                Day17 = '17 ('+newOli.Day_17__c+')';
                Day18 = '18 ('+newOli.Day_18__c+')';
                Day19 = '19 ('+newOli.Day_19__c+')';
                Day20 = '20 ('+newOli.Day_20__c+')';
                Day21 = '21 ('+newOli.Day_21__c+')';
                Day22 = '22 ('+newOli.Day_22__c+')';
                Day23 = '23 ('+newOli.Day_23__c+')';
                Day24 = '24 ('+newOli.Day_24__c+')';
                Day25 = '25 ('+newOli.Day_25__c+')';
                Day26 = '26 ('+newOli.Day_26__c+')';
                Day27 = '27 ('+newOli.Day_27__c+')';
                Day28 = '28 ('+newOli.Day_28__c+')';
                Day29 = '29 ('+newOli.Day_29__c+')';
                Day30 = '30 ('+newOli.Day_30__c+')';
                Day31 = '31 ('+newOli.Day_31__c+')';
            }
    
        }
        
        if (this.oliWrapperList.size() == 0) {
            addOli();
        }
        this.countOldProduct = currentOliList.size();
        
        System.debug(LoggingLevel.ERROR, '***SELECTED in constructor onLoad : ' + selectedItem);
    }
    
    public void addOli() {
        this.oliWrapperList = addToList(this.oliWrapperList);
    }
    
    public List<OliWrapper> addToList(List<OliWrapper> oliWs) {
        OliWrapper newWrapper = new OliWrapper();
        Agent_Scheduling__c newOli = new Agent_Scheduling__c();
        newWrapper.index = oliWs.size();
        newWrapper.oli = newOli;
        oliWs.add(newWrapper);
        return oliWs;
    }
    
    public void delOli() {
        this.oliWrapperList = delFromList(this.rowToRemove, this.oliWrapperList);
    }
    
    public List<OliWrapper> delFromList(Integer index, List<OliWrapper> oliWs) {
        delOli = oliWs.remove(index);
        if (delOli.oli.Id != null) {
            this.oliDelList.add(delOli.oli);
            this.countOldProduct = this.countOldProduct - 1;
        }
        return oliWs;
    }
        
    public PageReference SaveOli() {
        List<Agent_Scheduling__c> oliToUpsert = new List<Agent_Scheduling__c>();
        List<Agent_Scheduling__c> oliToDelete = new List<Agent_Scheduling__c>();
        Boolean isEmptyProductCustom = false;
        Boolean isEmptyPrice = false;
        Boolean isEmptyQuantity = false;
        
        for (OliWrapper oliw : this.oliWrapperList) {
            
            if (oliw.oli.Id == null) {
                
                oliToUpsert.add(oliw.oli);
            }
            else {
                oliToUpsert.add(oliw.oli);
            }
        }
        oliToDelete.addAll(oliDelList);
        
        if (isEmptyProductCustom) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Product: You must enter a value');
            ApexPages.addMessage(errorMessage);
            return null;
        }

        try {
            if (oliToDelete.size() > 0) {
                delete oliToDelete;
            }
            if (oliToUpsert.size() > 0) {
                upsert oliToUpsert;
            }
            //return new PageReference('/' + this.opportunityId);
            PageReference pageRef = Page.MultipleAgentScheduling;
            pageRef.setRedirect(true);
            return pageRef;
        }
        catch (DmlException de) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, de.getMessage());
            ApexPages.addMessage(errorMessage);
            return null;
        }
        catch (Exception e) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(errorMessage);
            return null;
        }
    }
    
    public PageReference Cancel() {
        return this.controller.cancel();
    }

    public PageReference GetData() {
        string sParameter = '';

        sParameter = sParameter+' and Document_Date__c = '+valueperiod+' ';

        if (TempDepartment != '')
            sParameter = sParameter+' and Agent_Department__c = \''+valuePosisi+'\' ';
        
        List<String> agent = new List<String>();
        String DataQuery = ' SELECT id, Agent__c FROM Agent_Scheduling__c WHERE id != NULL '+sParameter+' ORDER by id ASC ';
        for (Agent_Scheduling__c ags : Database.query(DataQuery)){
            agent.add(ags.Agent__c);
        }
        
        Date tanggal = date.today();
        
        if (valueperiod == 'Last_Month') tanggal = tanggal.AddMonths(-1);
        if (valueperiod == 'Next_Month') tanggal = tanggal.AddMonths(1);
        
        list<Agent_Scheduling__c> listAGS = new list<Agent_Scheduling__c>();
        for (User us : [SELECT id FROM User WHERE isActive = TRUE and id not in : Agent and Agent_Department__c =:valuePosisi ]){
            Agent_Scheduling__c newAGS = new Agent_Scheduling__c ();
            newAGS.Agent__c = us.id;
            newAGS.Document_Date__c = tanggal;
            
            listAGS.add(newAGS);
        }
        
        if (listAGS.size() > 0) insert listAGS;
        
        //return new PageReference('/Apex/MultipleAgentScheduling?period=' + valueperiod);
        //return new PageReference('/Apex/MultipleAgentScheduling');
        PageReference pageRef = Page.MultipleAgentScheduling;
        pageRef.setRedirect(true);
        pageRef.getParameters().put('period',valueperiod);
        pageRef.getParameters().put('department',valueposisi);
        return pageRef;
    }


    public PageReference showProductRow() {
        if (this.selectedItem != null) {
            this.productRowRendered = true;
        }
        else {
            this.productRowRendered = false;
        }
        this.selectedPriceBookId = this.selectedItem != null ? Id.valueOf(this.selectedItem) : null;
        this.oliWrapperList = new List<OliWrapper>();
        addOli();
        
        System.debug(LoggingLevel.ERROR, '***SELECTED in showProductRow onChange : ' + this.selectedItem);
        return null;
    }
}