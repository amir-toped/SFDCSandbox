/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class ZendeskSyncOrgs implements Database.AllowsCallouts, Database.Batchable<Integer>, Database.Stateful {
    global ZendeskSyncOrgs() {

    }
    global void Finish(Database.BatchableContext info) {

    }
    global Account PopulateAccountDetails(Account acc, Zendesk.ZendeskSyncOrgs.OrganizationClass org) {
        return null;
    }
    global static String RemoteRequest(String method, String resource, String body) {
        return null;
    }
    global System.Iterable Start(Database.BatchableContext info) {
        return null;
    }
    global static Id StartBatch() {
        return null;
    }
    global static Boolean TooManyZdOrgs() {
        return null;
    }
    global void execute(Database.BatchableContext info, List<Integer> scope) {

    }
    global void getAllzendeskOrgs(List<Zendesk.ZendeskSyncOrgs.ListOfOrganizationClass> listOfOrgs) {

    }
    global static Integer getExecutesNeeded(Boolean updateSetting) {
        return null;
    }
    global static Integer getOrgsFromZdCount() {
        return null;
    }
global class ListOfOrganizationClass {
}
global class OrganizationClass {
}
}
