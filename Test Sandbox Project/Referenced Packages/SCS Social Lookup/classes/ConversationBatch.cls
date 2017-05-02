/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class ConversationBatch implements Database.Batchable<SObject>, Database.Stateful {
    global String executionLog;
    global Map<String,List<SocialPost>> externalIdsToPost;
    global Map<String,Id> externalToIntenralId;
    global Map<Id,Id> internalToRootPostId;
    global Integer localExecutions;
    global String qString;
    global Integer totalProcessed;
    global Integer totalUpdated;
    global Map<Id,String> unThreadedPosts;
    global ConversationBatch(String q) {

    }
    global void execute(Database.BatchableContext BC, List<SObject> scope) {

    }
    global void finish(Database.BatchableContext BC) {

    }
    global void resolveExecute(Database.BatchableContext BC, List<SObject> scope) {

    }
    global SocialPost resolveThreadByResponseContextId(SocialPost sp) {
        return null;
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return null;
    }
}
