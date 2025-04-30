public with sharing class OpenCageFlowGeocoder {
    
    public class GeocodeInput {
        @InvocableVariable(required=true)
        public String address;
    }

    public class GeocodeOutput {
        @InvocableVariable
        public Decimal latitude;
        
        @InvocableVariable
        public Decimal longitude;
    }

    @InvocableMethod(label='Geocode Address via OpenCage')
    public static List<GeocodeOutput> geocode(List<GeocodeInput> inputList) {
        system.debug('inputList ------------___>'+inputList);
        List<GeocodeOutput> outputList = new List<GeocodeOutput>();
        GeocodeInput input = inputList[0]; 

        GeocodeOutput output = new GeocodeOutput();

        try {
            String apiKey = '9aa9cab9654242d5b0e35b07a05f0248'; 
            String encodedAddress = EncodingUtil.urlEncode(input.address, 'UTF-8');
            system.debug('encodedAddress'+encodedAddress);
            String path = '/geocode/v1/json?q=' + encodedAddress + '&key=' + apiKey;

            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api.opencagedata.com' + path);
            req.setMethod('GET');

            Http http = new Http();
            
            HttpResponse res = http.send(req);
            system.debug('res'+ res);
			
            if (res.getStatusCode() == 200) {
                Map<String, Object> resMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                List<Object> results = (List<Object>) resMap.get('results');

                if (!results.isEmpty()) {
                    Map<String, Object> first = (Map<String, Object>) results[0];
                    Map<String, Object> geometry = (Map<String, Object>) first.get('geometry');

                    output.latitude = (Decimal) geometry.get('lat');
                    output.longitude = (Decimal) geometry.get('lng');
                }
            } else {
                System.debug('OpenCage API error: ' + res.getBody());
            }
        } catch (Exception e) {
            System.debug('Geocoding error: ' + e.getMessage());
        }

        outputList.add(output);
        return outputList;
    }
}