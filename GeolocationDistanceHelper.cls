public with sharing class GeolocationDistanceHelper {

@InvocableMethod(label='Calculate Distance to Receivers')
public static List<ReceiverDistanceResult> calculateDistances(List<DonorAndReceiversInput> inputList) {
    try {
        List<ReceiverDistanceResult> resultList = new List<ReceiverDistanceResult>();
        if (inputList == null || inputList.isEmpty()) return resultList;

        DonorAndReceiversInput input = inputList[0];
        if (input == null || input.donorLatitude == null || input.donorLongitude == null) return resultList;
        if (input.receiverIds == null || input.receiverIds.isEmpty()) return resultList;

        Location donorLocation = Location.newInstance(input.donorLatitude, input.donorLongitude);

        List<Receiver__c> receivers = [
            SELECT Id, Receiver_Name__c, Geolocation__Latitude__s, Geolocation__Longitude__s 
            FROM Receiver__c 
            WHERE Id IN :input.receiverIds
        ];

        for (Receiver__c receiver : receivers) {
            if (receiver.Geolocation__Latitude__s != null && receiver.Geolocation__Longitude__s != null && 
                String.isNotBlank(receiver.Receiver_Name__c)) {
                Location receiverLocation = Location.newInstance(receiver.Geolocation__Latitude__s, receiver.Geolocation__Longitude__s);
                Double distanceKm = donorLocation.getDistance(receiverLocation, 'km');

                ReceiverDistanceResult result = new ReceiverDistanceResult();
                result.nameAndDistance = receiver.Receiver_Name__c + ', ' + String.valueOf(distanceKm);
                resultList.add(result);
            }
        }

        return resultList;
    } catch (Exception e) {
        System.debug('Exception in calculateDistances: ' + e.getMessage() + ' -- ' + e.getStackTraceString());
        return new List<ReceiverDistanceResult>();
    }
}

    public class DonorAndReceiversInput {
        @InvocableVariable(label='Donor Latitude')
        public Double donorLatitude;

        @InvocableVariable(label='Donor Longitude')
        public Double donorLongitude;

        @InvocableVariable(label='Receiver IDs')
        public List<Id> receiverIds; 
    }

    public class ReceiverDistanceResult {
        @InvocableVariable(label='Name and Distance')
        public String nameAndDistance;
    }
}