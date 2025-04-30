trigger Receiver on Receiver__c (after insert, after update) {
    for(Receiver__c food : Trigger.new){
        fetchGeolocation.geocodeAndUpdate(food.id,food.Address__c, 'Receiver__c');
    }
}