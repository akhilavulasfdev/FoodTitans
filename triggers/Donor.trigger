trigger Donor on Donor__c (after insert, after update) {
    for(Donor__c donor : Trigger.new){
        fetchGeolocation.geocodeAndUpdate(donor.id,donor.Address__c, 'Donor__c');
    }
}