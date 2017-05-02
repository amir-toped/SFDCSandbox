trigger SpikeTicketCounterTrigger on Spike_Ticket_Counter__c (before update) {
    SpikeTicketCounterManager.checkForThresholdCrossed(trigger.new);
}