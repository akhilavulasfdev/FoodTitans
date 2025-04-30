public class exampleQueueableApexSecondJob implements Queueable{
	
    /* Private List<Account> AccountRecords;
    public exampleQueueableApexSecondJob(List<Account> AccountRecordsFromaccountTrigger){
        this.AccountRecords=AccountRecordsFromaccountTrigger;
       
    } */
    
    public void execute(QueueableContext qc){
        System.debug('I had my Breakfast');
        
       System.enqueueJob(new exampleQueueableApexThirdJob());
    }
}