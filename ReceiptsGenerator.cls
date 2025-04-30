public with sharing class ReceiptsGenerator {
    public class Request {
        @InvocableVariable(required=true)
        public Id ReceiptId; 
    }
    
    public class Response {
        @InvocableVariable
        public String FileDownloadUrl;
    }
    
    @InvocableMethod(label='Generate Receipt PDF')
    public static List<Response> generateReceiptPDF(List<Request> requests) {
        List<Response> responses = new List<Response>();

        for (Request req : requests) {
            try {
         
                PageReference pdfPage = Page.Receipt_Template;
                pdfPage.getParameters().put('id', req.ReceiptId); 
                
                Blob pdfBlob = pdfPage.getContentAsPDF();

                ContentVersion cv = new ContentVersion();
                cv.Title = 'Receipt_' + req.ReceiptId;
                cv.PathOnClient = 'Receipt_' + req.ReceiptId + '.pdf';
                cv.VersionData = pdfBlob;
                cv.IsMajorVersion = true;
                insert cv;

                ContentVersion insertedVersion = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
				
                ContentDocumentLink cdl = new ContentDocumentLink();
                cdl.ContentDocumentId = insertedVersion.ContentDocumentId;
                cdl.LinkedEntityId = req.ReceiptId; 
                cdl.ShareType = 'V'; 
                cdl.Visibility = 'AllUsers'; 
                insert cdl;
                
                ContentDistribution cd = new ContentDistribution();
                cd.Name = 'Receipt Link - ' + req.ReceiptId;
                insert cd;

                Response res = new Response();
                res.FileDownloadUrl = cd.DistributionPublicUrl; 
                responses.add(res);
            } catch (Exception e) {
      
                System.debug('Error while generating receipt PDF: ' + e.getMessage());
            }
        }
        
        return responses;
    }
}