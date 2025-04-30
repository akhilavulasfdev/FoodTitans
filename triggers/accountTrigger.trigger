trigger accountTrigger on Account (before insert) {
	
   // After insert trigger logic goes here
     //   if(trigger.isinsert && trigger.isafter){
             // System.enqueueJob(new exampleQueueableApex(Trigger.new));
          //  String JobId = System.enqueueJob(new exampleQueueableApex(Trigger.new));
           // System.debug('@@ JobId ' +JobId);
            // System.enqueueJob(new exampleQueueableApexSecondJob(Trigger.new));
            
      //  }
     
    
    if(trigger.isinsert && trigger.isbefore){
        
        List<Account> accList=new  List<Account>();
        for(Account eachAccRec:Trigger.New){
            eachAccRec.Description='Web';
            accList.add(eachAccRec);
        }
        
    }
    
}