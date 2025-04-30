public class batchApexClassOnAccountObject implements Database.Batchable<SObject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator('SELECT Id,Name FROM Account LIMIT 5 offset 5');
        
    }
    
    public void execute(Database.BatchableContext bc,List<Account> batchOfRecordsFromStartMethod){
        for(Account eachAccountRecord:batchOfRecordsFromStartMethod){
            eachAccountRecord.Name='Updated using batch apex - ' + eachAccountRecord.Name;
    }
        UPDATE batchOfRecordsFromStartMethod;
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Batch job processing completed successfully');
    }
}