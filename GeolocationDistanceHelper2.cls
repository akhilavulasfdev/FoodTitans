public with sharing class GeolocationDistanceHelper2 {
    
    public static void calculateDistances(Id recordId) {
        try {
            Food_Donation__c fd = [Select Id,Estimated_Cost__c FROM  Food_Donation__c WHERE Id =: recordId ];

            List<ReceiverDistanceResult> resultList = new List<ReceiverDistanceResult>();
            
            Location donorLocation = Location.newInstance(fd.Pickup_Geolocation__Latitude__s, fd.Pickup_Geolocation__Longitude__s);
            
            List<Receiver__c> receivers = [
                SELECT Id, Receiver_Name__c, Geolocation__Latitude__s, Geolocation__Longitude__s 
                FROM Receiver__c
            ];
            list<Matches__c> listOfMatches = new list<Matches__c>();
            //Food_Donation__c fd = [Select Id,Estimated_Cost__c FROM  Food_Donation__c WHERE Id =: recordId ];
            for (Receiver__c receiver : receivers) {
                if (receiver.Geolocation__Latitude__s != null && receiver.Geolocation__Longitude__s != null && 
                    String.isNotBlank(receiver.Receiver_Name__c)) {
                        Location receiverLocation = Location.newInstance(receiver.Geolocation__Latitude__s, receiver.Geolocation__Longitude__s);
                        Double distanceKm = donorLocation.getDistance(receiverLocation, 'km');
                        
                        Matches__c match = new Matches__c();
                        match.Food_Donation__c = recordId;
                        match.Match_Name__c = receiver.Receiver_Name__c;
                        match.Distance__c = distanceKm;
                        match.Is_Sent__c = true;
                        listOfMatches.add(match);   				
                    }
            }
            Receipt__c recp = new Receipt__c();
            recp.Email_Sent__c = true;
            recp.Food_Donation__c=recordId;
            recp.Name='Receipt_'+recordId;
            recp.Estimated_Cost__c=fd.Estimated_Cost__c;
            recp.Date_Generated__c=System.now();
            insert recp;
            insert listOfMatches;
            
        } catch (Exception e) {
            System.debug('Exception in calculateDistances: ' + e.getMessage() + ' -- ' + e.getStackTraceString());
        }
    }
    
    public class ReceiverDistanceResult {
        public String nameAndDistance;
    }
}