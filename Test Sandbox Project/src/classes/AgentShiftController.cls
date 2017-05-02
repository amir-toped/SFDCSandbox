public class AgentShiftController {
    
    private ApexPages.StandardController controller;
    public Agent_Shift__c agentShift{get; set;}
    public Time startTime{get; set;}
    public Time endTime{get; set;}
    
    public AgentShiftController(ApexPages.StandardController controller) {
        this.controller = controller;
        agentShift = (Agent_Shift__c) this.controller.getRecord();
    }
    
    public PageReference save() {
        Datetime dtimeStart = Datetime.newInstance(1970, 1, 1);
        Datetime dtimeEnd = Datetime.newInstance(1970, 1, 1);
        
        
        return this.controller.save();
    }
    
    public PageReference cancel() {
        return this.controller.cancel();
    }
}