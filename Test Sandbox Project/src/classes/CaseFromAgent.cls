public class CaseFromAgent {
	private final Case cases;
	//String sId = ApexPages.currentPage().getParameters().get('id');
	//public CaseFromAgent() {
	//	Case cases = [select Id, casenumber, createddate, account.name from case where Id =:sId];
	//}
    public void cfg(id sId){
    	Case cases = [select Id, casenumber, createddate, account.name from case where Id =:sId];
        getCase();
    }
	public Case getCase() {
		return cases;
	}
}