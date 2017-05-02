trigger AS_UpSertEvent on Agent_Scheduling__c (Before Insert, After Insert, After Update) {
    for (Agent_Scheduling__c tsk : trigger.new){
        if (trigger.isBefore){
            try {
                if (tsk.Document_Date__c == NULL) tsk.Document_Date__c = date.today();
            }
            catch (exception e) {
                tsk.Document_Date__c = date.today();
            }        
        }
        else{
        // hapus old event
        List<Event> delevent = [SELECT id FROM Event WHERE WhatId =:tsk.id];
        delete delevent;
    
        List<Event> listEV = new List<Event>();

        Map<String,Agent_Shift__c> maptoshift = new Map<String,Agent_Shift__c>();
        for (Agent_Shift__c shift : [SELECT id, name, Start_Time__c, End_Time__c, Start_Hour__c, End_Hour__c, Start_Minute__c, End_Minute__c FROM Agent_Shift__c]) {
            maptoshift.put(shift.name, shift);
        }

        // check event yang ada.
        string col= '';
        string temp = '';
        /*
        try {
            if (tsk.Document_Date__c == NULL) tsk.Document_Date__c = date.today();
        }
        catch (exception e) {
            tsk.Document_Date__c = date.today();
        }
        */
        Date NextMonth = tsk.Document_Date__c.AddMonths(1);
        
        For (Integer i = 1; i <= integer.valueof(tsk.Last_Day__c); i++) 
        {
            if (i < 10) col = '0'+string.valueof(i);
            else col = string.valueof(i);

            if (tsk.get('SS_'+col+'__c') != 'S' && 
                tsk.get('SS_'+col+'__c') != 'X' && 
                tsk.get('SS_'+col+'__c') != 'C' && 
                tsk.get('SS_'+col+'__c') != 'UL' && 
                tsk.get('SS_'+col+'__c') != '' && tsk.get('SS_'+col+'__c') != NULL)
            {
                temp = String.valueof(tsk.get('SS_'+col+'__c'));
                Event ev = new Event();
                ev.OwnerId = tsk.Agent__c;
                ev.WhatId = tsk.id;
                ev.Description = 'TESTING';
                ev.Break_Shift__c = string.valueof(tsk.get('Break_Shift_'+col+'__c'));
                    
                    ev.Subject = tsk.Agent_Name__c+'- '+i+' - Shift '+tsk.get('SS_'+col+'__c')+'-Break '+tsk.get('Break_Shift_'+col+'__c');

                    //ev.StartDateTime = DateTime.newInstance(tsk.Document_Date__c.Year(), tsk.Document_Date__c.Month(), i, 6, 30, 0); //Shift1Start;
                    ev.StartDateTime = DateTime.newInstance(tsk.Document_Date__c.Year(), tsk.Document_Date__c.Month(), i, integer.valueof(maptoshift.get(temp).Start_Hour__c), integer.valueof(maptoshift.get(temp).Start_minute__c), 0); //Shift1Start;
                    
                    if (temp == '4' && i != integer.valueof(tsk.Last_Day__c))
                        ev.EndDateTime = DateTime.newInstance(tsk.Document_Date__c.Year(), tsk.Document_Date__c.Month(), i+1, integer.valueof(maptoshift.get(temp).End_Hour__c), integer.valueof(maptoshift.get(temp).End_Minute__c), 0); //Shift1End;
                    else if (temp == '4' && i == integer.valueof(tsk.Last_Day__c)) 
                        ev.EndDateTime = DateTime.newInstance(NextMonth.Year(), NextMonth.Month(), 1, integer.valueof(maptoshift.get(temp).End_Hour__c), integer.valueof(maptoshift.get(temp).End_Minute__c), 0); //Shift1End;
                    else
                        ev.EndDateTime = DateTime.newInstance(tsk.Document_Date__c.Year(), tsk.Document_Date__c.Month(), i, integer.valueof(maptoshift.get(temp).End_Hour__c), integer.valueof(maptoshift.get(temp).End_Minute__c), 0); //Shift1End;
                
                listEV.add (ev);
            }
        } // end for
        
        if (listEV.size() > 0) insert listEV;
        } // end after
    } // end for
} // end trigger


/*
Shift 1
2016-12-31T23:30:00.000+0000
2017-01-01T08:30:00.000+0000

Shift 2
2017-01-01T01:30:00.000+0000
2017-01-01T10:30:00.000+0000

Shift 3
2017-01-01T05:30:00.000+0000
2017-01-01T14:30:00.000+0000

Shift 4
2017-01-01T14:30:00.000+0000
2017-01-01T23:30:00.000+0000

Shift OH
2017-01-01T02:00:00.000+0000
2017-01-01T11:00:00.000+0000

*/