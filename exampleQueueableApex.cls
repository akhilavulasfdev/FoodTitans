public class exampleQueueableApex implements Queueable{
    
    public exampleQueueableApex(){
        
    }
    
    
    public void execute(QueueableContext qc){
        
     		System.debug('I took my shower bath');
        
        
          System.enqueueJob(new exampleQueueableApexSecondJob());
        
         
    }
    
}
    
// Private List<Account> AccountRecords;
  //  public exampleQueueableApex(List<Account> AccountRecordsFromaccountTrigger){
        
    //    this.AccountRecords=AccountRecordsFromaccountTrigger;
   // }
   // public void execute(QueueableContext qc){
    //    System.debug('I took my shower bath');
      //  List<WorkPlan> newWorkPlanRecordsList= new List<WorkPlan>();
       // for(Account EachAccRecrd:AccountRecords){
       //     WorkPlan WorkPlanRecrd=new WorkPlan();
        //    WorkPlanRecrd.name=EachAccRecrd.name;
         //   WorkPlanRecrd.ParentRecordId='0oWdL0000001T9d';
         //   newWorkPlanRecordsList.add(WorkPlanRecrd);
     //   }       
        
     //   INSERT newWorkPlanRecordsList;
        
      
    //}


//////////////////////////////////////         USE CASES             ////////////////////////////////////////////////
// 1)Queueable logic has to be written in a class.

// 2)Queueable allows chaining of jobs.

// 3)Queueable provides you an ID of the job to track its progress.

// 4)It allows non-primitive types.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
////////////////////////         LIMITATIONS             /////////////////////////////////
// 1) Queueable cannot handle millions of jobs at once.
//////////////////////////////////////////////////////////////////////////////////////////