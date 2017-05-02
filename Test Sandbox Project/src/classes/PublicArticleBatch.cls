global class PublicArticleBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {
	global String query;
    global Integer recordsProcessed = 0;
    global Date todayDate = Date.today();
	global Datetime todayDatetime = Datetime.newInstanceGmt(todayDate.year(), todayDate.month(), todayDate.day(), 0, 0, 0);
    global HttpCalloutMock mock = null;
    private static final String ONLINE = 'Online';
    private static final String EN_US = 'en_US';
    private static final String PUBLISH = 'publish';
    private static final String DRAFT = 'draft';
    private static final String CLOSED = 'closed';
    private static final String POST = 'post';
    private static final String CREATED = 'created';
    private static final String UPDATED = 'updated';
    private static final String ERROR = 'error';
    private static final String HC_ONLINE = 'Online';
    private static final String HC_DRAFT = 'Draft';
    private static final String HC_ARCHIVED = 'Archived';
    private static final String GET = 'GET';
    //static labels
    private static final String CLIENT_ID = Label.WP_HC_Client_Id;
    private static final String CLIENT_SECRET = Label.WP_HC_Client_Secret;
    private static final String ENDPOINT = Label.WP_HC_Endpoint;
    private static final String GRANT_TYPE = Label.WP_HC_Grant_Type;
    private static final String TOKEN_URL = Label.WP_HC_Token_URL;
    private static final String USERNAME = Label.WP_HC_Username;
    private static final String PASSWORD = Label.WP_HC_Password;
    private static final String ENDPOINT_SFID = Label.WP_HC_Get_By_SF_Id;
    
    global PublicArticleBatch(String q) {
        this.query = q;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug(LoggingLevel.DEBUG, '***QUERY BATCH: ' + query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Help_Center__kav> scope) {
        System.debug(LoggingLevel.DEBUG, '***SCOPE: ' + scope);
        for (Help_Center__kav hc : scope) {
            Help_Center__DataCategorySelection sectionName = null;
            if (hc.DataCategorySelections != null) {
                if (hc.DataCategorySelections.size() > 0) {
                    sectionName = hc.DataCategorySelections.get(0);
                }
            }
            
            String articleId = hc.KnowledgeArticleId;
            String idWPArticle = '';
            Id hcaId = null;
            List<Help_Center_Article__c> hcaListEx = [SELECT Id, Id_SF__c, Id_WP__c FROM Help_Center_Article__c WHERE Id_SF__c = :articleId];
            System.debug(LoggingLevel.DEBUG, '***TOTAL hcaListEx: ' + hcaListEx.size());
            if (hcaListEx.size() > 0) {
                idWPArticle = hcaListEx[0].Id_WP__c;
                hcaId = hcaListEx[0].Id;
            }
            
            Boolean isExistInWordpress = false;
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            HttpResponse response = new HttpResponse();
            
            if (String.isNotBlank(idWPArticle)) {
                Article2 a2 = initArticle(hc, sectionName, idWPArticle);
                String jsonBody = JSON.serialize(a2);
                String accessToken = getAccessToken(TOKEN_URL, CLIENT_ID, CLIENT_SECRET, GRANT_TYPE, USERNAME, PASSWORD, articleId, a2, hc);
                request.setEndpoint(ENDPOINT + '/' + idWPArticle);
                request.setMethod(POST.toUpperCase());
                request.setHeader('Content-Type', 'application/json;charset=UTF-8');
                request.setHeader('Authorization', 'Bearer ' + accessToken);
                request.setBody(jsonBody);
                System.debug(LoggingLevel.DEBUG, '***REQUEST BODY: ' + request.getBody());
                
                try {
                    if (!Test.isRunningTest()) {
                        response = http.send(request);
                    }
                    else {
                        response = mock.respond(request);
                    }
                }
                catch (System.CalloutException e) {
                    System.debug(LoggingLevel.ERROR, 'Callout error: '+ e);
                    System.debug(LoggingLevel.ERROR, '***ERROR: ' + response.toString());
                    String errorDesc = e.getMessage();
                    upsertHcaError(articleId, a2, errorDesc, hc);
                }
                catch (Exception e) {
                    System.debug(LoggingLevel.ERROR, 'General Exception: '+ e);
                    System.debug(LoggingLevel.ERROR, '***ERROR: ' + response.toString());
                    String errorDesc = e.getMessage();
                    upsertHcaError(articleId, a2, errorDesc, hc);
                }
                
                if (response.getStatusCode() != 201 && response.getStatusCode() != 200) {
                    System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
                    String errorDesc = response.getStatusCode() + ' ' + response.getStatus();
                    upsertHcaError(articleId, a2, errorDesc, hc);
                }
                else {
                    System.debug(LoggingLevel.DEBUG, '***RESPONSE JSON ORIGINAL: ' + response.getBody());
                    if (response.getBody() != null) {
                        String responseBody = response.getBody();
                        try {
                            String idWP = '';
                            JSONParser jparser = JSON.createParser(responseBody);
                            while (jparser.nextToken() != null) {
                                if ((jparser.getCurrentToken() == JSONToken.FIELD_NAME) && (jparser.getText() == 'id')) {
                                    jparser.nextValue();
                                    idWP = jparser.getText();
                                    break;
                                }
                            }
                            
                            System.debug(LoggingLevel.DEBUG, '***ID WP: ' + idWP);
                            upsertHca(articleId, a2, idWP, hc);
                            recordsProcessed = recordsProcessed + 1;
                        }
                        catch (Exception e) {
                            String errorDesc = e.getMessage();
                            upsertHcaError(articleId, a2, errorDesc, hc);
                        }
                    }
                }
            }
            else {
                System.debug(LoggingLevel.DEBUG, '***HELP CENTER MAPPER: There is no article found with SF_ID: ' + articleId
                                 + ' & Title: ' + hc.Title + ' in Help Center Article Mapper');
                
                //check in wordpress first, if exist then do update else create new article ===============================
                String idWpEx = '';
                Article2 a2GetBySfId = initArticle(hc, sectionName);
                request.setEndpoint(ENDPOINT_SFID + articleId);
                request.setMethod(GET);
                request.setHeader('Content-Type', 'application/json;charset=UTF-8');
                
                try {
                    if (!Test.isRunningTest()) {
                        response = http.send(request);
                    }
                    else {
                        response = mock.respond(request);
                    }
                }
                catch (Exception e) {
                    System.debug(LoggingLevel.ERROR, 'General Exception: '+ e);
                    System.debug(LoggingLevel.ERROR, '***ERROR GET BY SF_ID: ' + response.toString());
                    String errorDesc = e.getMessage();
                    upsertHcaError(articleId, a2GetBySfId, errorDesc, hc);
                }
                
                if (response.getStatusCode() != 201 && response.getStatusCode() != 200) {
                    System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
                    String errorDesc = response.getStatusCode() + ' ' + response.getStatus();
                    upsertHcaError(articleId, a2GetBySfId, errorDesc, hc);
                }
                else {
                    System.debug(LoggingLevel.DEBUG, '***RESPONSE JSON GET BY SF_ID: ' + response.getBody());
                    if (String.isNotBlank(response.getBody())) {
                        String responseBody = response.getBody();
                        try {
                            String idWP = '';
                            JSONParser jparser = JSON.createParser(responseBody);
                            while (jparser.nextToken() != null) {
                                if ((jparser.getCurrentToken() == JSONToken.FIELD_NAME) && (jparser.getText() == 'id')) {
                                    jparser.nextValue();
                                    idWP = jparser.getText();
                                    break;
                                }
                            }
                            idWpEx = idWP;
                            System.debug(LoggingLevel.DEBUG, '***ID WP EX: ' + idWP);
                        }
                        catch (Exception e) {
                            String errorDesc = e.getMessage();
            				upsertHcaError(articleId, a2GetBySfId, errorDesc, hc);
                        }
                        
                        if (String.isNotBlank(idWpEx)) {
                            isExistInWordpress = true;
                        }
                    }
                }
                // done checking===========================================================================================
                
                if (isExistInWordpress) {
                    System.debug(LoggingLevel.DEBUG, '***Found id_sf matching with this article in wordpress');
                    Article2 a2 = initArticle(hc, sectionName, idWpEx);
                    String jsonBody = JSON.serialize(a2);
                    String accessToken = getAccessToken(TOKEN_URL, CLIENT_ID, CLIENT_SECRET, GRANT_TYPE, USERNAME, PASSWORD, articleId, a2, hc);
                    request.setEndpoint(ENDPOINT + '/' + idWpEx);
                    request.setMethod(POST.toUpperCase());
                    request.setHeader('Content-Type', 'application/json;charset=UTF-8');
                    request.setHeader('Authorization', 'Bearer ' + accessToken);
                    request.setBody(jsonBody);
                    System.debug(LoggingLevel.DEBUG, '***REQUEST BODY EX: ' + request.getBody());
                
                    try {
                        if (!Test.isRunningTest()) {
                            response = http.send(request);
                        }
                        else {
                            response = mock.respond(request);
                        }
                    }
                    catch (Exception e) {
                        System.debug(LoggingLevel.ERROR, 'General exception: '+ e);
                        System.debug(LoggingLevel.ERROR, '***ERROR: ' + response.toString());
                        String errorDesc = e.getMessage();
                        upsertHcaError(articleId, a2, errorDesc, hc);
                    }
                    
                    if (response.getStatusCode() != 201 && response.getStatusCode() != 200) {
                        System.debug('The status code returned was not expected: ' +
                        response.getStatusCode() + ' ' + response.getStatus());
                        String errorDesc = response.getStatusCode() + ' ' + response.getStatus();
                        upsertHcaError(articleId, a2, errorDesc, hc);
                    }
                    else {
                        System.debug(LoggingLevel.DEBUG, '***RESPONSE JSON ORIGINAL: ' + response.getBody());
                        if (response.getBody() != null) {
                            String responseBody = response.getBody();
                            try {
                                String idWP = '';
                                JSONParser jparser = JSON.createParser(responseBody);
                                while (jparser.nextToken() != null) {
                                    if ((jparser.getCurrentToken() == JSONToken.FIELD_NAME) && (jparser.getText() == 'id')) {
                                        jparser.nextValue();
                                        idWP = jparser.getText();
                                        break;
                                    }
                                }
                                
                                System.debug(LoggingLevel.DEBUG, '***ID WP: ' + idWP);
                                upsertHca(articleId, a2, idWP, hc);
                                recordsProcessed = recordsProcessed + 1;
                            }
                            catch (Exception e) {
                                String errorDesc = e.getMessage();
                                upsertHcaError(articleId, a2, errorDesc, hc);
                            }
                        }
                    }
                }
                else {
                    System.debug(LoggingLevel.DEBUG, '***No id_sf matching with this article in wordpress');
                    Article2 a2 = initArticle(hc, sectionName);
                    String jsonBody = JSON.serialize(a2);
                    String accessToken = getAccessToken(TOKEN_URL, CLIENT_ID, CLIENT_SECRET, GRANT_TYPE, USERNAME, PASSWORD, articleId, a2, hc);
                    request.setEndpoint(ENDPOINT);
                    request.setMethod(POST.toUpperCase());
                    request.setHeader('Content-Type', 'application/json;charset=UTF-8');
                    request.setHeader('Authorization', 'Bearer ' + accessToken);
                    request.setBody(jsonBody);
                    System.debug(LoggingLevel.DEBUG, '***REQUEST BODY: ' + request.getBody());
                
                    try {
                        if (!Test.isRunningTest()) {
                            response = http.send(request);
                        }
                        else {
                            response = mock.respond(request);
                        }
                    }
                    catch (System.CalloutException e) {
                        System.debug(LoggingLevel.ERROR, 'Callout error: '+ e);
                        System.debug(LoggingLevel.ERROR, '***ERROR: ' + response.toString());
                        String errorDesc = e.getMessage();
                    	upsertHcaError(articleId, a2, errorDesc, hc);
                    }
                    catch (Exception e) {
                        System.debug(LoggingLevel.ERROR, 'General Exception: '+ e);
                        System.debug(LoggingLevel.ERROR, '***ERROR: ' + response.toString());
                        String errorDesc = e.getMessage();
                    	upsertHcaError(articleId, a2, errorDesc, hc);
                    }
                    
                    if (response.getStatusCode() != 201 && response.getStatusCode() != 200) {
                        System.debug('The status code returned was not expected: ' +
                        response.getStatusCode() + ' ' + response.getStatus());
                        String errorDesc = response.getStatusCode() + ' ' + response.getStatus();
                        upsertHcaError(articleId, a2, errorDesc, hc);
                    }
                    else {
                        System.debug(LoggingLevel.DEBUG, '***RESPONSE JSON ORIGINAL: ' + response.getBody());
                        if (response.getBody() != null) {
                            String responseBody = response.getBody();
                            try {
                                String idWP = '';
                                JSONParser jparser = JSON.createParser(responseBody);
                                while (jparser.nextToken() != null) {
                                    if ((jparser.getCurrentToken() == JSONToken.FIELD_NAME) && (jparser.getText() == 'id')) {
                                        jparser.nextValue();
                                        idWP = jparser.getText();
                                        break;
                                    }
                                }
                                System.debug(LoggingLevel.DEBUG, '***ID WP: ' + idWP);
                                upsertHca(articleId, a2, idWP, hc);
                            	recordsProcessed = recordsProcessed + 1;
                            }
                            catch (Exception e) {
                                String errorDesc = e.getMessage();
                                upsertHcaError(articleId, a2, errorDesc, hc);
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    global void finish(Database.BatchableContext bc) {
        System.debug(LoggingLevel.DEBUG, '***TOTAL: ' + recordsProcessed);
    }
    
    public class Article2 {
        public String id_sf;
        public String title;
        public String content;
        public String author;
        public DateTime post_date;
        public DateTime post_date_gmt;
        public String status;
        public String comment_status;
        public String ping_status;
        public String slug;
        public DateTime modified;
        public DateTime modified_gmt;
        public String type;
        public String language;
        public String section_id;
        public String id;
    }
    
    public Article2 initArticle(Help_Center__kav hc, Help_Center__DataCategorySelection sectionName, String idWPArticle) {
        Article2 articlePost = new Article2();
        articlePost.id = idWPArticle;
        articlePost.id_sf = hc.KnowledgeArticleId;
        articlePost.title = hc.Title;
        articlePost.content = hc.Body__c;
        articlePost.author = '1';
        articlePost.post_date = hc.CreatedDate;
        articlePost.post_date_gmt = hc.CreatedDate;
        articlePost.status = hc.PublishStatus == ONLINE ? PUBLISH : DRAFT;
        articlePost.comment_status = CLOSED;
        articlePost.ping_status = CLOSED;
        articlePost.slug = hc.UrlName;
        articlePost.modified = hc.LastModifiedDate;
        articlePost.modified_gmt = hc.LastModifiedDate;
        articlePost.type = POST;
        articlePost.language = hc.Language;
        articlePost.section_id = sectionName != null ? sectionName.DataCategoryName : '';
        return articlePost;
    }
    
    public Article2 initArticle(Help_Center__kav hc, Help_Center__DataCategorySelection sectionName) {
        Article2 articlePost = new Article2();
        articlePost.id_sf = hc.KnowledgeArticleId;
        articlePost.title = hc.Title;
        articlePost.content = hc.Body__c;
        articlePost.author = '1';
        articlePost.post_date = hc.CreatedDate;
        articlePost.post_date_gmt = hc.CreatedDate;
        articlePost.status = hc.PublishStatus == ONLINE ? PUBLISH : DRAFT;
        articlePost.comment_status = CLOSED;
        articlePost.ping_status = CLOSED;
        articlePost.slug = hc.UrlName;
        articlePost.modified = hc.LastModifiedDate;
        articlePost.modified_gmt = hc.LastModifiedDate;
        articlePost.type = POST;
        articlePost.language = hc.Language;
        articlePost.section_id = sectionName != null ? sectionName.DataCategoryName : '';
        return articlePost;
    }
    
    public String getAccessToken(String tokenUrl, String clientId, String clientSecret, String grantType, String usernameParam, String passwordParam, String articleId, Article2 articlePost, Help_Center__kav hc) {
        String accessToken = '';
        String basicAuth = EncodingUtil.base64Encode(Blob.valueOf(clientId + ':' + clientSecret));
        
        String reqBody = 'grant_type=' + grantType +
            '&username=' + usernameParam +
            '&password=' + passwordParam;
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        
        request.setEndpoint(tokenUrl);
        request.setMethod(POST.toUpperCase());
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization', 'Basic ' + basicAuth);
        request.setBody(reqBody);
        System.debug(LoggingLevel.DEBUG, '***REQUEST BODY AUTH: ' + request.getBody());
        
        try {
            if (!Test.isRunningTest()) {
                response = http.send(request);
            }
            else {
                response = mock.respond(request);
            }
        }
        catch (System.CalloutException e) {
            System.debug(LoggingLevel.ERROR, 'Callout error: '+ e);
            System.debug(LoggingLevel.ERROR, '***ERROR: ' + response.toString());
            String errorDesc = 'Error getting token. ' + e.getMessage();
            upsertHcaError(articleId, articlePost, errorDesc, hc);
        }
        catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'General Exception: '+ e);
            System.debug(LoggingLevel.ERROR, '***ERROR: ' + response.toString());
            String errorDesc = 'Error getting token. ' + e.getMessage();
            upsertHcaError(articleId, articlePost, errorDesc, hc);
        }
        
        if (response.getStatusCode() != 201 && response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
        	response.getStatusCode() + ' ' + response.getStatus());
            String errorDesc = 'Error getting token. ' + response.getStatusCode() + ' ' + response.getStatus();
            upsertHcaError(articleId, articlePost, errorDesc, hc);
        }
        else {
            System.debug(LoggingLevel.DEBUG, '***RESPONSE JSON AUTH ORIGINAL: ' + response.getBody());
            if (response.getBody() != null) {
                try {
                    JSONParser jparser = JSON.createParser(response.getBody());
                    while (jparser.nextToken() != null) {
                        if ((jparser.getCurrentToken() == JSONToken.FIELD_NAME) && (jparser.getText() == 'access_token')) {
                            jparser.nextValue();
                            accessToken = jparser.getText();
                            break;
                        }
                    }
                }
                catch(Exception e) {
                    String errorDesc = 'Error getting token. ' + e.getMessage();
                    upsertHcaError(articleId, articlePost, errorDesc, hc);
                }
            }
        }
        System.debug(LoggingLevel.DEBUG, '***ACCESS TOKEN: ' + accessToken);
        return accessToken;
    }
    
    public static void upsertHca(String articleId, Article2 articlePost, String idWP, Help_Center__kav hc) {
        List<Help_Center_Article__c> hcaList = [SELECT Id FROM Help_Center_Article__c WHERE Id_SF__c = :articleId];
        String todayDateStr = String.valueOf(System.now());
        if (hcaList.size() == 0) {
            Help_Center_Article__c hca = new Help_Center_Article__c();
            hca.Name = articlePost.title;
            hca.Title__c = articlePost.title;
            hca.Id_SF__c = articlePost.id_sf;
            hca.Id_WP__c = idWP;
            hca.Slug__c = articlePost.slug;
            hca.Status__c = articlePost.status;
            hca.Sync_Status__c = CREATED;
            hca.Knowledge_Status__c = hc.PublishStatus;
            hca.Type__c = articlePost.type;
            hca.Description__c = 'Created to wordpress at: ' + todayDateStr;
            insert hca;
        }
        else {
            Help_Center_Article__c hca = new Help_Center_Article__c();
            hca.Id = hcaList[0].Id;
            hca.Name = articlePost.title;
            hca.Title__c = articlePost.title;
            hca.Id_SF__c = articlePost.id_sf;
            hca.Id_WP__c = idWP;
            hca.Slug__c = articlePost.slug;
            hca.Status__c = articlePost.status;
            hca.Sync_Status__c = UPDATED;
            hca.Knowledge_Status__c = hc.PublishStatus;
            hca.Type__c = articlePost.type;
            hca.Description__c = 'Updated to wordpress at: ' + todayDateStr;
            update hca;
        }
    }
    
    public static void upsertHcaError(String articleId, Article2 articlePost, String errorDesc, Help_Center__kav hc) {
        List<Help_Center_Article__c> hcaList = [SELECT Id FROM Help_Center_Article__c WHERE Id_SF__c = :articleId];
        if (hcaList.size() == 0) {
            Help_Center_Article__c hca = new Help_Center_Article__c();
            hca.Name = articlePost.title;
            hca.Title__c = articlePost.title;
            hca.Id_SF__c = articlePost.id_sf;
            hca.Slug__c = articlePost.slug;
            hca.Status__c = articlePost.status;
            hca.Sync_Status__c = ERROR;
            hca.Knowledge_Status__c = hc.PublishStatus;
            hca.Type__c = articlePost.type;
            hca.Description__c = errorDesc;
            insert hca;
        }
        else {
            Help_Center_Article__c hca = new Help_Center_Article__c();
            hca.Id = hcaList[0].Id;
            hca.Name = articlePost.title;
            hca.Title__c = articlePost.title;
            hca.Id_SF__c = articlePost.id_sf;
            hca.Slug__c = articlePost.slug;
            hca.Status__c = articlePost.status;
            hca.Sync_Status__c = ERROR;
            hca.Knowledge_Status__c = hc.PublishStatus;
            hca.Type__c = articlePost.type;
            hca.Description__c = errorDesc;
            update hca;
        }
    }
    
    String a1 = '';
    String a2 = '';
    String a3 = '';
    String a4 = '';
    String a5 = '';
    String a6 = '';
    String a7 = '';
    String a8 = '';
    String a9 = '';
    String a10 = '';
    String a11 = '';
    String a12 = '';
    String a13 = '';
    String a14 = '';
    String a15 = '';
    String a16 = '';
    String a17 = '';
    String a18 = '';
    String a19 = '';
    String a20 = '';
    String a21 = '';
    String a22 = '';
    String a23 = '';
    String a24 = '';
    String a25 = '';
    String a26 = '';
    String a27 = '';
    String a28 = '';
    String a29 = '';
    String a30 = '';
    String a31 = '';
    String a32 = '';
    String a33 = '';
    String a34 = '';
    String a35 = '';
    String a36 = '';
    String a37 = '';
    String a38 = '';
    String a39 = '';
    String a40 = '';
    String a41 = '';
    String a42 = '';
    String a43 = '';
    String a44 = '';
    String a45 = '';
    String a46 = '';
    String a47 = '';
    String a48 = '';
    String a49 = '';
    String a50 = '';
    String a51 = '';
    String a52 = '';
    String a53 = '';
    String a54 = '';
    String a55 = '';
    String a56 = '';
    String a57 = '';
    String a58 = '';
    String a59 = '';
    String a60 = '';
    String a61 = '';
    String a62 = '';
    String a63 = '';
    String a64 = '';
    String a65 = '';
    String a66 = '';
    String a67 = '';
    String a68 = '';
    String a69 = '';
    String a70 = '';
    String a71 = '';
    String a72 = '';
    String a73 = '';
    String a74 = '';
    String a75 = '';
    String a76 = '';
    String a77 = '';
    String a78 = '';
    String a79 = '';
    String a80 = '';
    String a81 = '';
    String a82 = '';
    String a83 = '';
    String a84 = '';
    String a85 = '';
    String a86 = '';
    String a87 = '';
    String a88 = '';
    String a89 = '';
    String a90 = '';
    String a91 = '';
    String a92 = '';
    String a93 = '';
    String a94 = '';
    String a95 = '';
    String a96 = '';
    String a97 = '';
    String a98 = '';
    String a99 = '';
    String a100 = '';
    String a101 = '';
    String a102 = '';
    String a103 = '';
    String a104 = '';
    String a105 = '';
    String a106 = '';
    String a107 = '';
    String a108 = '';
    String a109 = '';
    String a110 = '';
    String a111 = '';
    String a112 = '';
    String a113 = '';
    String a114 = '';
    String a115 = '';
    String a116 = '';
    String a117 = '';
    String a118 = '';
    String a119 = '';
    String a120 = '';
    String a121 = '';
    String a122 = '';
    String a123 = '';
    String a124 = '';
    String a125 = '';
    String a126 = '';
    String a127 = '';
    String a128 = '';
    String a129 = '';
    String a130 = '';
    String a131 = '';
    String a132 = '';
    String a133 = '';
    String a134 = '';
    String a135 = '';
    String a136 = '';
    String a137 = '';
    String a138 = '';
    String a139 = '';
    String a140 = '';
    String a141 = '';
    String a142 = '';
    String a143 = '';
    String a144 = '';
    String a145 = '';
    String a146 = '';
    String a147 = '';
    String a148 = '';
    String a149 = '';
    String a150 = '';
    String a151 = '';
    String a152 = '';
    String a153 = '';
    String a154 = '';
    String a155 = '';
    String a156 = '';
    String a157 = '';
    String a158 = '';
    String a159 = '';
    String a160 = '';
    String a161 = '';
    String a162 = '';
    String a163 = '';
    String a164 = '';
    String a165 = '';
    String a166 = '';
    String a167 = '';
    String a168 = '';
    String a169 = '';
    String a170 = '';
    String a171 = '';
    String a172 = '';
    String a173 = '';
    String a174 = '';
    String a175 = '';
    String a176 = '';
    String a177 = '';
    String a178 = '';
    String a179 = '';
    String a180 = '';
    String a181 = '';
    String a182 = '';
    String a183 = '';
    String a184 = '';
    String a185 = '';
    String a186 = '';
    String a187 = '';
    String a188 = '';
    String a189 = '';
    String a190 = '';
    String a191 = '';
    String a192 = '';
    String a193 = '';
    String a194 = '';
    String a195 = '';
    String a196 = '';
    String a197 = '';
    String a198 = '';
    String a199 = '';
    String a200 = '';
    String a201 = '';
    String a202 = '';
    String a203 = '';
    String a204 = '';
    String a205 = '';
    String a206 = '';
    String a207 = '';
    String a208 = '';
    String a209 = '';
    String a210 = '';
    String a211 = '';
    String a212 = '';
    String a213 = '';
    String a214 = '';
    String a215 = '';
    String a216 = '';
    String a217 = '';
    String a218 = '';
    String a219 = '';
    String a220 = '';
    String a221 = '';
    String a222 = '';
    String a223 = '';
    String a224 = '';
    String a225 = '';
    String a226 = '';
    String a227 = '';
    String a228 = '';
    String a229 = '';
    String a230 = '';
    String a231 = '';
    String a232 = '';
    String a233 = '';
    String a234 = '';
    String a235 = '';
    String a236 = '';
    String a237 = '';
    String a238 = '';
    String a239 = '';
    String a240 = '';
    String a241 = '';
    String a242 = '';
    String a243 = '';
    String a244 = '';
    String a245 = '';
    String a246 = '';
    String a247 = '';
    String a248 = '';
    String a249 = '';
    String a250 = '';
    String a251 = '';
    String a252 = '';
    String a253 = '';
    String a254 = '';
    String a255 = '';
    String a256 = '';
    String a257 = '';
    String a258 = '';
    String a259 = '';
    String a260 = '';
    String a261 = '';
    String a262 = '';
    String a263 = '';
    String a264 = '';
    String a265 = '';
    String a266 = '';
    String a267 = '';
    String a268 = '';
    String a269 = '';
    String a270 = '';
    String a271 = '';
    String a272 = '';
    String a273 = '';
    String a274 = '';
    String a275 = '';
    String a276 = '';
    String a277 = '';
    String a278 = '';
    String a279 = '';
    String a280 = '';
    String a281 = '';
    String a282 = '';
    String a283 = '';
    String a284 = '';
    String a285 = '';
    String a286 = '';
    String a287 = '';
    String a288 = '';
    String a289 = '';
    String a290 = '';
    String a291 = '';
    String a292 = '';
    String a293 = '';
    String a294 = '';
    String a295 = '';
    String a296 = '';
    String a297 = '';
    String a298 = '';
    String a299 = '';
    String a300 = '';
    String a301 = '';
    String a302 = '';
    String a303 = '';
    String a304 = '';
    String a305 = '';
    String a306 = '';
    String a307 = '';
    String a308 = '';
    String a309 = '';
    String a310 = '';
    String a311 = '';
    String a312 = '';
    String a313 = '';
    String a314 = '';
    String a315 = '';
    String a316 = '';
    String a317 = '';
    String a318 = '';
    String a319 = '';
    String a320 = '';
    String a321 = '';
    String a322 = '';
    String a323 = '';
    String a324 = '';
    String a325 = '';
    String a326 = '';
    String a327 = '';
    String a328 = '';
    String a329 = '';
    String a330 = '';
    String a331 = '';
    String a332 = '';
    String a333 = '';
    String a334 = '';
    String a335 = '';
    String a336 = '';
    String a337 = '';
    String a338 = '';
    String a339 = '';
    String a340 = '';
    String a341 = '';
    String a342 = '';
    String a343 = '';
    String a344 = '';
    String a345 = '';
    String a346 = '';
    String a347 = '';
    String a348 = '';
    String a349 = '';
    String a350 = '';
    String a351 = '';
    String a352 = '';
    String a353 = '';
    String a354 = '';
    String a355 = '';
    String a356 = '';
    String a357 = '';
    String a358 = '';
    String a359 = '';
    String a360 = '';
    String a361 = '';
    String a362 = '';
    String a363 = '';
    String a364 = '';
    String a365 = '';
    String a366 = '';
    String a367 = '';
    String a368 = '';
    String a369 = '';
    String a370 = '';
    String a371 = '';
    String a372 = '';
    String a373 = '';
    String a374 = '';
    String a375 = '';
    String a376 = '';
    String a377 = '';
    String a378 = '';
    String a379 = '';
    String a380 = '';
    String a381 = '';
    String a382 = '';
    String a383 = '';
    String a384 = '';
    String a385 = '';
    String a386 = '';
    String a387 = '';
    String a388 = '';
    String a389 = '';
    String a390 = '';
    String a391 = '';
    String a392 = '';
    String a393 = '';
    String a394 = '';
    String a395 = '';
    String a396 = '';
    String a397 = '';
    String a398 = '';
    String a399 = '';
    String a400 = '';
    String a401 = '';
    String a402 = '';
    String a403 = '';
    String a404 = '';
    String a405 = '';
    String a406 = '';
    String a407 = '';
    String a408 = '';
    String a409 = '';
    String a410 = '';
    String a411 = '';
    String a412 = '';
    String a413 = '';
    String a414 = '';
    String a415 = '';
    String a416 = '';
    String a417 = '';
    String a418 = '';
    String a419 = '';
    String a420 = '';
    String a421 = '';
    String a422 = '';
    String a423 = '';
    String a424 = '';
    String a425 = '';
    String a426 = '';
    String a427 = '';
    String a428 = '';
    String a429 = '';
    String a430 = '';
    String a431 = '';
    String a432 = '';
    String a433 = '';
    String a434 = '';
    String a435 = '';
    String a436 = '';
    String a437 = '';
    String a438 = '';
    String a439 = '';
    String a440 = '';
    String a441 = '';
    String a442 = '';
    String a443 = '';
    String a444 = '';
    String a445 = '';
    String a446 = '';
    String a447 = '';
    String a448 = '';
    String a449 = '';
    String a450 = '';
    String a451 = '';
    String a452 = '';
    String a453 = '';
    String a454 = '';
    String a455 = '';
    String a456 = '';
    String a457 = '';
    String a458 = '';
    String a459 = '';
    String a460 = '';
    String a461 = '';
    String a462 = '';
    String a463 = '';
    String a464 = '';
    String a465 = '';
    String a466 = '';
    String a467 = '';
    String a468 = '';
    String a469 = '';
    String a470 = '';
    String a471 = '';
    String a472 = '';
    String a473 = '';
    String a474 = '';
    String a475 = '';
    String a476 = '';
    String a477 = '';
    String a478 = '';
    String a479 = '';
    String a480 = '';
    String a481 = '';
    String a482 = '';
    String a483 = '';
    String a484 = '';
    String a485 = '';
    String a486 = '';
    String a487 = '';
    String a488 = '';
    String a489 = '';
    String a490 = '';
    String a491 = '';
    String a492 = '';
    String a493 = '';
    String a494 = '';
    String a495 = '';
    String a496 = '';
    String a497 = '';
    String a498 = '';
    String a499 = '';
    String a500 = '';
    String a501 = '';
    String a502 = '';
    String a503 = '';
    String a504 = '';
    String a505 = '';
    String a506 = '';
    String a507 = '';
    String a508 = '';
    String a509 = '';
    String a510 = '';
    String a511 = '';
    String a512 = '';
    String a513 = '';
    String a514 = '';
    String a515 = '';
    String a516 = '';
    String a517 = '';
    String a518 = '';
    String a519 = '';
    String a520 = '';
    String a521 = '';
    String a522 = '';
    String a523 = '';
    String a524 = '';
    String a525 = '';
    String a526 = '';
    String a527 = '';
    String a528 = '';
    String a529 = '';
    String a530 = '';
    String a531 = '';
    String a532 = '';
    String a533 = '';
    String a534 = '';
    String a535 = '';
    String a536 = '';
    String a537 = '';
    String a538 = '';
    String a539 = '';
    String a540 = '';
    String a541 = '';
    String a542 = '';
    String a543 = '';
    String a544 = '';
    String a545 = '';
    String a546 = '';
    String a547 = '';
    String a548 = '';
    String a549 = '';
    String a550 = '';
    String a551 = '';
    String a552 = '';
    String a553 = '';
    String a554 = '';
    String a555 = '';
    String a556 = '';
    String a557 = '';
    String a558 = '';
    String a559 = '';
    String a560 = '';
    String a561 = '';
    String a562 = '';
    String a563 = '';
    String a564 = '';
    String a565 = '';
    String a566 = '';
    String a567 = '';
    String a568 = '';
    String a569 = '';
    String a570 = '';
    String a571 = '';
    String a572 = '';
    String a573 = '';
    String a574 = '';
    String a575 = '';
    String a576 = '';
    String a577 = '';
    String a578 = '';
    String a579 = '';
    String a580 = '';
    String a581 = '';
    String a582 = '';
    String a583 = '';
    String a584 = '';
    String a585 = '';
    String a586 = '';
    String a587 = '';
    String a588 = '';
    String a589 = '';
    String a590 = '';
    String a591 = '';
    String a592 = '';
    String a593 = '';
    String a594 = '';
    String a595 = '';
    String a596 = '';
    String a597 = '';
    String a598 = '';
    String a599 = '';
    String a600 = '';
}