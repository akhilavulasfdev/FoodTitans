public class scheduleApexForSchedulingBatchApexClass implements Schedulable{
    public void execute(SchedulableContext sc){
        Database.executeBatch(new batchApexClassOnAccountObject());
    }
}