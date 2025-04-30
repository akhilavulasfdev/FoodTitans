public class scheduleApexForSchedulingQueueableApex implements Schedulable{
	public void execute(SchedulableContext sc){
        System.enqueueJob(new exampleQueueableApexSecondJob());
    }
}