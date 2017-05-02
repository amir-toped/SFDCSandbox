global class AutoClosedBatchCase implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
	global String query;
    global AutoClosedBatchCase(String q) {
        this.query = q;
    }
	global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug(LoggingLevel.DEBUG, '***QUERY BATCH: ' + query);
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Case> scope){
        for(Case cs:scope){
            cs.status= 'Closed';
        }
        update scope;
    }
    global void finish(Database.BatchableContext BC){

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