@RestResource(urlMapping='/Categories/*')
global class Categories {
	
    @HttpGet
    global static List<CategoriesResult> getCategories() {
        RestRequest request = RestContext.request;
        String articleId = '';
        List<DescribeDataCategoryGroupResult> describeCategoryResult;
    	List<DescribeDataCategoryGroupStructureResult> describeCategoryStructureResult;
        String HELP_CENTER = 'HELP CENTER';
        
        if (request != null) {
            articleId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
            if (articleId == 'Categories' || articleId == 'Categories.json' || articleId == 'Categories.xml') {
                articleId = '';
            }
        }
        List<CategoriesResult> crList = new List<CategoriesResult>();
        
        try {
            //Making the call to the describeDataCategoryGroups to
            //get the list of category groups associated
            List<String> objType = new List<String>();
            objType.add('KnowledgeArticleVersion');
            describeCategoryResult = Schema.describeDataCategoryGroups(objType);
            //System.debug(LoggingLevel.ERROR, '***describeCategoryResult: ' + describeCategoryResult);
            //Creating a list of pair objects to use as a parameter
            //for the describe call
            List<DataCategoryGroupSobjectTypePair> pairs = new List<DataCategoryGroupSobjectTypePair>();
            List<String> strList = new List<String>();
            List<DataCategory> allCategories = null;
            
            //Looping throught the first describe result to create
            //the list of pairs for the second describe call
            for (DescribeDataCategoryGroupResult singleResult : describeCategoryResult) {
            	DataCategoryGroupSobjectTypePair p = new DataCategoryGroupSobjectTypePair();
            	p.setSobject(singleResult.getSobject());
            	p.setDataCategoryGroupName(singleResult.getName());
                
                if (singleResult.getLabel() == HELP_CENTER) {
                    pairs.add(p);
                }
            }
            
            //describeDataCategoryGroupStructures()
        	describeCategoryStructureResult = Schema.describeDataCategoryGroupStructures(pairs, false);
            
            //Getting data from the result
            for (DescribeDataCategoryGroupStructureResult singleResult : describeCategoryStructureResult) {
                //Get the name of the data category group
                singleResult.getName();
                //Get the top level categories
            	DataCategory [] toplevelCategories =  singleResult.getTopCategories();
                //Recursively get all the categories
            	allCategories = getAllCategories(toplevelCategories);
                
                for(DataCategory category : allCategories) {
                    //Get the name of the category
                    if (category.getChildCategories().size() > 0) {
                        if (category.getLabel() != 'ALL') {
                            System.debug(LoggingLevel.ERROR, '***categorydetail: ' + category);
                            CategoriesResult cr = new CategoriesResult();
                            cr.Id = category.getName();
                            cr.Name = category.getLabel();
                            //crList.add(cr);
                        }
                    }
                }
            }
            CategoriesResult cr = new CategoriesResult();
            cr.Id = '000';
            cr.Name = String.valueOf(describeCategoryResult.size());
            //crList.add(cr);
            
            System.debug(LoggingLevel.ERROR, '***crList COUNT : ' + crList.size());
            System.debug(LoggingLevel.ERROR, '***crList DETAIL : ' + crList);
            return crList;
        }
        catch (Exception e) {
            
            return null;
        }
    }
    
    global class CategoriesResult {
        public String Id;
        public String Name;
    }
    
    public static DataCategory[] getAllCategories(DataCategory[] categories) {
    	if (categories.isEmpty()) {
    		return new DataCategory[]{};
    	} 
        else {
    		DataCategory [] categoriesClone = categories.clone();
    		DataCategory category = categoriesClone[0];
     		DataCategory[] allCategories = new DataCategory[]{category};
      		categoriesClone.remove(0);
      		categoriesClone.addAll(category.getChildCategories());
      		allCategories.addAll(getAllCategories(categoriesClone));
      		return allCategories;
     	}
    }
    
    global class JSONCategory{
        public String label{set;get;}
        public String name{set;get;}
        public List<TopLevelCategory> topCategories{set;get;}
    }
    
    global class TopLevelCategory{
        public List<ChildLevelCategory> childCategories{set;get;}
    }
    
    global class ChildLevelCategory{
        public List<ChildLevelCategory> childCategories{set;get;}
        public String label{set;get;}
        public String name{set;get;}
    }
}