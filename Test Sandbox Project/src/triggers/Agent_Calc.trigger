trigger Agent_Calc on Agent_Achievement__c (Before Update) {
    for (Agent_Achievement__c agv : trigger.new) {
        if (agv.Attendance_Refresh__c) {
            agv.Attendance_Refresh__c = FALSE;
            
            agv.Attendance_Late__c = 0;
            agv.Attendance_UL__c = 0;
            // Agent Scheduling
            for (Agent_Scheduling__c ags : [SELECT id, Late__c, Shift_UL__c FROM Agent_Scheduling__c 
            WHERE Agent__c =: agv.OwnerId and Periode_Quarter__c =: agv.Periode_Quarter__c]){
                agv.Attendance_Late__c += ags.Late__c;
                agv.Attendance_UL__c += ags.Shift_UL__c;
            }
        }

        if (agv.Productivity_Refresh__c) {
            agv.Productivity_Refresh__c = FALSE;
            
            agv.Productivity_W1__c = 0;
            agv.Productivity_W2__c = 0;
            agv.Productivity_W3__c = 0;
            agv.Productivity_W4__c = 0;
            // Agent Scheduling
            
            for (Case_chat__c cc : [SELECT id, Week__c
                FROM Case_chat__c
                WHERE User__c =: agv.OwnerId and Periode__c =: agv.Periode__c]) {
                if (cc.Week__c == 1) agv.Productivity_W1__c += 1;
                else if (cc.Week__c == 2) agv.Productivity_W2__c += 1;
                else if (cc.Week__c == 3) agv.Productivity_W3__c += 1;
                else agv.Productivity_W4__c += 1;

            }
        }
        
        if (agv.CSAT_Refresh__c){
            agv.CSAT_Refresh__c = FALSE;

            agv.CSAT_W1__c = 0;
            agv.CSAT_W2__c = 0;
            agv.CSAT_W3__c = 0;
            agv.CSAT_W4__c = 0;

            agv.CSAT_Count_W1__c = 0;
            agv.CSAT_Count_W2__c = 0;
            agv.CSAT_Count_W3__c = 0;
            agv.CSAT_Count_W4__c = 0;
            
            for (Agent_Response_Case__c qa : [SELECT id, Week__c, Response__c
                FROM Agent_Response_Case__c
                WHERE User_Agent__c =: agv.OwnerId and Periode__c =: agv.Periode__c]) {
                if (qa.Week__c == 1) agv.CSAT_W1__c += qa.Response__c;
                else if (qa.Week__c == 2) agv.CSAT_W2__c += qa.Response__c;
                else if (qa.Week__c == 3) agv.CSAT_W3__c += qa.Response__c;
                else agv.CSAT_W4__c += qa.Response__c;

                if (qa.Week__c == 1) agv.CSAT_Count_W1__c += 1;
                else if (qa.Week__c == 2) agv.CSAT_Count_W2__c += 1;
                else if (qa.Week__c == 3) agv.CSAT_Count_W3__c += 1;
                else agv.CSAT_Count_W4__c += 1;

            }            
        }

        if (agv.QA_Refresh__c){
            agv.QA_Refresh__c = FALSE;

            agv.QA_W1__c = 0;
            agv.QA_W2__c = 0;
            agv.QA_W3__c = 0;
            agv.QA_W4__c = 0;

            agv.QA_Count_W1__c = 0;
            agv.QA_Count_W2__c = 0;
            agv.QA_Count_W3__c = 0;
            agv.QA_Count_W4__c = 0;
            
            for (QA_Agent_Answer__c qa : [SELECT id, Week__c, Score__c
                FROM QA_Agent_Answer__c
                WHERE Active__c = TRUE and Status__c = 'Approved' and User_Agent__c =: agv.OwnerId and Periode__c =: agv.Periode__c]) {
                if (qa.Week__c == '1') agv.QA_W1__c += qa.Score__c;
                else if (qa.Week__c == '2') agv.QA_W2__c += qa.Score__c;
                else if (qa.Week__c == '3') agv.QA_W3__c += qa.Score__c;
                else agv.QA_W4__c += qa.Score__c;

                if (qa.Week__c == '1') agv.QA_Count_W1__c += 1;
                else if (qa.Week__c == '2') agv.QA_Count_W2__c += 1;
                else if (qa.Week__c == '3') agv.QA_Count_W3__c += 1;
                else agv.QA_Count_W4__c += 1;

            }            
            
        }
        
        if (agv.Hold_Time_Refresh__c){
            agv.Hold_Time_Refresh__c = FALSE;

            agv.Hold_Time_W1__c = 0;
            agv.Hold_Time_W2__c = 0;
            agv.Hold_Time_W3__c = 0;
            agv.Hold_Time_W4__c = 0;

//            agv.CSAT_Count_W1__c = 0;
//            agv.CSAT_Count_W2__c = 0;
//            agv.CSAT_Count_W3__c = 0;
//            agv.CSAT_Count_W4__c = 0;
            
            for (Task qa : [SELECT id, Week__c, Duration__c
                FROM Task
                WHERE Start_Call__c != NULL AND OwnerId =: agv.OwnerId and Periode__c =: agv.Periode__c]) {
                if (qa.Week__c == 1) agv.Hold_Time_W1__c += qa.Duration__c;
                else if (qa.Week__c == 2) agv.Hold_Time_W2__c += qa.Duration__c;
                else if (qa.Week__c == 3) agv.Hold_Time_W3__c += qa.Duration__c;
                else agv.Hold_Time_W4__c += qa.Duration__c;

                //if (qa.Week__c == 1) agv.CSAT_Count_W1__c += 1;
                //else if (qa.Week__c == 2) agv.CSAT_Count_W2__c += 1;
                //else if (qa.Week__c == 3) agv.CSAT_Count_W3__c += 1;
                //else agv.CSAT_Count_W4__c += 1;

            }            
        }

/*
        if (agv.Response_Refresh__c){
            agv.Response_Refresh__c = FALSE;

            agv.Response_W1__c = 0;
            agv.Response_W2__c = 0;
            agv.Response_W3__c = 0;
            agv.Response_W4__c = 0;

            list<String> ListCase = new list<String>();
            for (Agent_Response_Case__c qa : [SELECT id, Week__c, Response__c, User_Agent__c, Case__c
                FROM Agent_Response_Case__c
                WHERE User_Agent__c =: agv.OwnerId and Periode__c =: agv.Periode__c
                order by Case__c
                ]) {
                ListCase.add(string.valueof(qa.Case__c));
            }

            string likestring = '\'%Response%\'';
            Date LastDay = date.today();
            NextMonth = NextMonth.addMonths(1)-1;
            Date EndDate = date.newInstance(, 11, 21);
            Date StartDate = date.newInstance(1990, 11, 21);
            for (CaseMilestone qa : [SELECT id, Case.Week__c, Duration__c, ActualElapsedTimeInMins

SELECT Id, CaseId, Case.CaseNUmber, StartDate, TargetDate, CompletionDate, CreatedDate, TargetResponseInMins, ElapsedTimeInMins, StoppedTimeInMins, ActualElapsedTimeInMins, MilestoneTypeId, MilestoneType.Name, LastModifiedDate, LastModifiedById, CreatedById 
FROM CaseMilestone
                WHERE MilestoneType.Name like :likestring and 
                FROM Task
                WHERE Start_Call__c != NULL AND OwnerId =: agv.OwnerId and Periode__c =: agv.Periode__c]) {
                if (qa.Week__c == 1) agv.Hold_Time_W1__c += qa.Duration__c;
                else if (qa.Week__c == 2) agv.Hold_Time_W2__c += qa.Duration__c;
                else if (qa.Week__c == 3) agv.Hold_Time_W3__c += qa.Duration__c;
                else agv.Hold_Time_W4__c += qa.Duration__c;

                //if (qa.Week__c == 1) agv.CSAT_Count_W1__c += 1;
                //else if (qa.Week__c == 2) agv.CSAT_Count_W2__c += 1;
                //else if (qa.Week__c == 3) agv.CSAT_Count_W3__c += 1;
                //else agv.CSAT_Count_W4__c += 1;

            }            
        }
        
        if (agv.Resolved_Refresh__c){
            agv.Resolved_Refresh__c = FALSE;

            agv.Resolved_W1__c = 0;
            agv.Resolved_W2__c = 0;
            agv.Resolved_W3__c = 0;
            agv.Resolved_W4__c = 0;
            
            for (
            
            for (Task qa : [SELECT id, Week__c, Duration__c
                FROM Task
                WHERE Start_Call__c != NULL AND OwnerId =: agv.OwnerId and Periode__c =: agv.Periode__c]) {
                if (qa.Week__c == 1) agv.Hold_Time_W1__c += qa.Duration__c;
                else if (qa.Week__c == 2) agv.Hold_Time_W2__c += qa.Duration__c;
                else if (qa.Week__c == 3) agv.Hold_Time_W3__c += qa.Duration__c;
                else agv.Hold_Time_W4__c += qa.Duration__c;

                //if (qa.Week__c == 1) agv.CSAT_Count_W1__c += 1;
                //else if (qa.Week__c == 2) agv.CSAT_Count_W2__c += 1;
                //else if (qa.Week__c == 3) agv.CSAT_Count_W3__c += 1;
                //else agv.CSAT_Count_W4__c += 1;

            }            
        }
*/
    } // end for
} // end trigger