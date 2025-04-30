trigger FoodDonation on Food_Donation__c (after insert, after update) {
    for(Food_Donation__c food : Trigger.new){
        fetchGeolocation.geocodeAndUpdate(food.id,food.Pickup_location__c, 'Food_Donation__c');
        GeolocationDistanceHelper2.calculateDistances(food.id);
    }
}