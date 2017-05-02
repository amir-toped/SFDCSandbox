trigger QAN_Calc on QA_Agent_Answer__c (Before Insert, Before Update) {
    for (QA_Agent_Answer__c QAN : trigger.new){
        if (QAN.Manager_Id__c != NULL && QAN.Manager_Id__c != '') QAN.Manager__c = QAN.Manager_Id__c;
            
        QAN.A_FE_Total2__c = QAN.A_FE_Total__c;
        QAN.A_NFE_Total2__c = QAN.A_NFE_Total__c;
        
        QAN.Total_Bobot_FE2__c = QAN.Total_Bobot_FE__c;
        QAN.Total_Bobot_NFE2__c = QAN.Total_Bobot_NFE__c;
        
        if (QAN.Status__c == 'Waiting Approval' && Trigger.oldMap.get(QAN.Id).Status__c != QAN.Status__c) {
            
            if ( (QAN.Score_Submit_3__c == 0 || QAN.Score_Submit_3__c == NULL) && QAN.Score_Submit_2__c != 0 && QAN.Score_Submit_2__c != NULL && (QAN.Score_Submit_1__c != 0 && QAN.Score_Submit_1__c != NULL) ) QAN.Score_Submit_3__c = QAN.Score__c;
            if ( (QAN.Score_Submit_2__c == 0 || QAN.Score_Submit_2__c == NULL) && (QAN.Score_Submit_1__c != 0 && QAN.Score_Submit_1__c != NULL) ) QAN.Score_Submit_2__c = QAN.Score__c;
            if ( QAN.Score_Submit_1__c == 0 || QAN.Score_Submit_1__c ==NULL ) QAN.Score_Submit_1__c = QAN.Score__c;

        }
    }
}