global class CallWS {    
   @Future(callout=true) public static void getData(String url, String caseid, String accountid) {
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http h = new Http();
        
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setBody('{"notifications":[{ "account_id": "'+accountid+'","case_id" : ["'+caseid+'"]}]}');

        //req.setCompressed(TRUE);
        req.setTimeout(120000);
        
        if(!Test.isRunningTest()) res = h.send(req);
    }
  }