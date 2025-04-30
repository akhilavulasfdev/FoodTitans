trigger opprtunityTrigger on Opportunity (after insert ) {
    
    if(Trigger.isinsert && Trigger.isafter){
        List<Opportunity> oppList=new  List<Opportunity>();
        for(Opportunity eachOppRec:Trigger.New){
            eachOppRec.Description='Web';
            oppList.add(eachOppRec);
        }
        update oppList;
    }
    

}