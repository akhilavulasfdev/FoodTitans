public class fetchGeolocation {

    @future(callout=true)
    public static void geocodeAndUpdate(Id recordId, String address, String objectName) {
        try {
            String encodedAddress = EncodingUtil.urlEncode(address, 'UTF-8');
            String path = '/geocode/v1/json?q=' + encodedAddress + '&key=9aa9cab9654242d5b0e35b07a05f0248';

            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api.opencagedata.com' + path); 
            req.setMethod('GET');

            Http http = new Http();
            HttpResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                Map<String, Object> resMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                List<Object> results = (List<Object>) resMap.get('results');

                if (!results.isEmpty()) {
                    Map<String, Object> first = (Map<String, Object>) results[0];
                    Map<String, Object> geometry = (Map<String, Object>) first.get('geometry');

                    Decimal lat = (Decimal) geometry.get('lat');
                    Decimal lng = (Decimal) geometry.get('lng');
                    if(objectName == 'Food_Donation__c'){
                        Food_Donation__c obj = new Food_Donation__c(Id = recordId);
                        obj.Pickup_Geolocation__Latitude__s = lat;
                        obj.Pickup_Geolocation__Longitude__s = lng;
                        update obj;  
                    } else if(objectName == 'Receiver__c'){
                        Receiver__c obj = new Receiver__c(Id = recordId);
                        obj.Geolocation__Latitude__s = lat;
                        obj.Geolocation__Longitude__s = lng;
                        update obj;  
                    } else if(objectName == 'Donor__c'){
                        Donor__c obj = new Donor__c(Id = recordId);
                        obj.Geolocation__Latitude__s = lat;
                        obj.Geolocation__Longitude__s = lng;
                        update obj; 
                    }
                }
            } else {
                System.debug('OpenCage API error: ' + res.getBody());
            }

        } catch (Exception e) {
            System.debug('Geocoding error: ' + e.getMessage());
        }
    }
}