trigger ContactTrigger on Contact (after insert , after update , after delete) {
  
    
    
    
    /*
        //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------Assignment Starts Here----------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    
    //Assignment : When contact is created Number of contact records associated to an account record
    //to which the new contat is associated to
    
    // After insert trigger logic goes here
    if(trigger.isinsert && trigger.isafter){
        //Set will collect all the unique Account IDs when bulk contacts are uploaded and are associated to different accounts.
        Set<Id> contactsAccountIDs= new Set<Id>();
        //Looping through each Contact Record to get its Account ID , only unique Account IDs are stored in the above Set.
        for(Contact eachContactRecord:Trigger.new){
            contactsAccountIDs.add(eachContactRecord.AccountId);
        }
        
        //All unique Account IDs are stored in the above Set
        //Now we are fetching account records and its associated contact records of that Id's present in the set
        // Decimal TotalSumOfAmountFiledValueOfAssociatedRecords=0;
        List<Account> AccountRecords=[SELECT Id,Name,Number_of_contacts_associated_to_the_acc__c,Total_sum_of_the_associated_con_rec__c,(SELECT Id,Name,Amount__c from Contacts)FROM Account WHERE Id IN: contactsAccountIDs];
        //And looping through each Account Record & updating the value of "Number_of_contacts_associated_to_the_acc__c"
        //with its associated contact records size
        for(Account eachAccountRecord:AccountRecords){
            eachAccountRecord.Number_of_contacts_associated_to_the_acc__c=eachAccountRecord.Contacts.size();
            Decimal TotalSumOfAmountFiledValueOfAssociatedRecords=0;
            //In the second for loop we are looping through all the associated contact records of an account and 
            //finding the sum of amount value field & updating it on account fied Total_sum_of_the_associated_con_rec__c
            
            for(Contact eachContact:eachAccountRecord.Contacts){
                TotalSumOfAmountFiledValueOfAssociatedRecords += eachContact.Amount__c;
            }
            eachAccountRecord.Total_sum_of_the_associated_con_rec__c=TotalSumOfAmountFiledValueOfAssociatedRecords;
    }
        //Finally updating the list
        UPDATE AccountRecords;
        
    }
    
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------Assignment Ends Here----------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    //
    //
            //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------Assignment Starts Here----------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    
    //Assignment : When contact is updated(Re-parented from one account to another account) 
    //Number of contact records associated to an account record
    //to which the new contat is associated to
    
    // After update trigger logic goes here
    if(trigger.isupdate && trigger.isafter){
        //Set will collect all the unique Account IDs when bulk contacts are uploaded and are associated to different accounts.
        Set<Id> contactsReparentedandPreviousAccountIDs= new Set<Id>();
        //Looping through each Contact Record to get its Reparented Account ID , only unique Account IDs are stored in the above Set.
        for(Contact eachContactRecord:Trigger.new){
            contactsReparentedandPreviousAccountIDs.add(eachContactRecord.AccountId); //Here we are getting & storing Contacts new Account ID to a set
            Contact contactsPreviousAccountIDs=Trigger.oldMap.get(eachContactRecord.Id); //Here we are getting same Contacts old details 
                            //by using oldMap & passing the Contact Id as it is update operation contact Id will not change
            contactsReparentedandPreviousAccountIDs.add(contactsPreviousAccountIDs.AccountId); //Storing Contacts old Account ID to a set
        }
        
        //All unique Account IDs are stored in the above Set , as set will not have duplicate values
        //Now we are fetching account records and its associated contact records of those account Id's present in the above set
        List<Account> AccountRecords=[SELECT Id,Name,Number_of_contacts_associated_to_the_acc__c,Total_sum_of_the_associated_con_rec__c,(SELECT Id,Name,Amount__c from Contacts) FROM Account WHERE Id IN: contactsReparentedandPreviousAccountIDs];
        //And looping through each Account Record & updating the value of "Number_of_contacts_associated_to_the_acc__c"
        //with its associated contact records size
        for(Account eachAccountRecord:AccountRecords){
            eachAccountRecord.Number_of_contacts_associated_to_the_acc__c=eachAccountRecord.Contacts.size();
            
            Decimal TotalSumOfAmountFiledValueOfAssociatedRecords=0;
            //In the second for loop we are looping through all the associated contact records of an account and 
            //finding the sum of amount value field & updating it on account fied Total_sum_of_the_associated_con_rec__c
            
            for(Contact eachContact:eachAccountRecord.Contacts){
                TotalSumOfAmountFiledValueOfAssociatedRecords += eachContact.Amount__c;
            }
            eachAccountRecord.Total_sum_of_the_associated_con_rec__c=TotalSumOfAmountFiledValueOfAssociatedRecords;
            
    }
        
        UPDATE AccountRecords;
        
    }
    
    
    //I took seprate Set to store Previous AccountIDs of contact records , but this is optimized above in line numbers : 61 & 63
    //  Contact contactsPreviousAccountIDs=Trigger.oldMap.get(eachContactRecord.Id); //optimized code line
    //  contactsReparentedandPreviousAccountIDs.add(contactsPreviousAccountIDs.AccountId); //optimized code line
        
     /*  //Set will collect all the unique Account IDs when bulk contacts are uploaded and are associated to different accounts.
        Set<Id> contactsPreviousAccountIDs= new Set<Id>();
        //Looping through each Contact Record to get its Previous Account ID , only unique Account IDs are stored in the above Set.
        for(Contact eachContactRecord:Trigger.old){
            contactsPreviousAccountIDs.add(eachContactRecord.AccountId);
        }
        
        //All unique Account IDs are stored in the above Set
        //Now we are fetching account records and its associated contact records of that Id's present in the set
        List<Account> PreviousAccountRecords=[SELECT Id,Name,Number_of_contacts_associated_to_the_acc__c,(SELECT Id,Name,Amount__c from Contacts)FROM Account WHERE Id IN: contactsPreviousAccountIDs];
        //And looping through each Account Record & updating the value of "Number_of_contacts_associated_to_the_acc__c"
        //with its associated contact records size
        for(Account eachAccountRecord:PreviousAccountRecords){
            eachAccountRecord.Number_of_contacts_associated_to_the_acc__c=eachAccountRecord.Contacts.size();
    }
        
        //Finally updating the list
        UPDATE PreviousAccountRecords;
     } ------------------------------------------*----------------------------/
    
    
     //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------Assignment Ends Here----------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    //
    //
     //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------Assignment Starts Here----------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    
    
    
    //Assignment  : When contact is deleted Number of contact records associated to an account record
    //to which the contat is associated to
    
    // After delete trigger logic goes here
    if(trigger.isdelete && trigger.isafter){
        //Set will collect all the unique Account IDs when bulk contacts are uploaded and are associated to different accounts.
        Set<Id> contactsAccountIDs= new Set<Id>();
        //Looping through each Contact Record to get its Account ID , only unique Account IDs are stored in the above Set.
        for(Contact eachContactRecord:Trigger.old){
            contactsAccountIDs.add(eachContactRecord.AccountId);
        }
        
        //All unique Account IDs are stored in the above Set
        //Now we are fetching account records and its associated contact records of that Id's present in the set
        List<Account> AccountRecords=[SELECT Id,Name,Number_of_contacts_associated_to_the_acc__c,Total_sum_of_the_associated_con_rec__c,(SELECT Id,Name,Amount__c from Contacts)FROM Account WHERE Id IN: contactsAccountIDs];
        //And looping through each Account Record & updating the value of "Number_of_contacts_associated_to_the_acc__c"
        //with its associated contact records size
        for(Account eachAccountRecord:AccountRecords){
            eachAccountRecord.Number_of_contacts_associated_to_the_acc__c=eachAccountRecord.Contacts.size();
            
            Decimal TotalSumOfAmountFiledValueOfAssociatedRecords=0;
            //In the second for loop we are looping through all the associated contact records of an account and 
            //finding the sum of amount value field & updating it on account fied Total_sum_of_the_associated_con_rec__c
            
            for(Contact eachContact:eachAccountRecord.Contacts){
                TotalSumOfAmountFiledValueOfAssociatedRecords += eachContact.Amount__c;
            }
            eachAccountRecord.Total_sum_of_the_associated_con_rec__c=TotalSumOfAmountFiledValueOfAssociatedRecords;
    }
        //Finally updating the list
        UPDATE AccountRecords;
        
    }
    
    
     //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------Assignment Ends Here----------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    //
    //
         //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------Assignment Starts Here----------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    

    //Assignment  : When contact is undeleted Number of contact records associated to an account record
    //to which the contat is associated to
    
    // After undelete trigger logic goes here
    if(trigger.isundelete && trigger.isafter){
        //Set will collect all the unique Account IDs when bulk contacts are uploaded and are associated to different accounts.
        Set<Id> contactsAccountIDs= new Set<Id>();
        //Looping through each Contact Record to get its Account ID , only unique Account IDs are stored in the above Set.
        for(Contact eachContactRecord:Trigger.new){
            contactsAccountIDs.add(eachContactRecord.AccountId);
        }
        
        //All unique Account IDs are stored in the above Set
        //Now we are fetching account records and its associated contact records of that Id's present in the set
        List<Account> AccountRecords=[SELECT Id,Name,Number_of_contacts_associated_to_the_acc__c,Total_sum_of_the_associated_con_rec__c,(SELECT Id,Name,Amount__c from Contacts)FROM Account WHERE Id IN: contactsAccountIDs];
        //And looping through each Account Record & updating the value of "Number_of_contacts_associated_to_the_acc__c"
        //with its associated contact records size
        for(Account eachAccountRecord:AccountRecords){
            eachAccountRecord.Number_of_contacts_associated_to_the_acc__c=eachAccountRecord.Contacts.size();
            
            Decimal TotalSumOfAmountFiledValueOfAssociatedRecords=0;
            //In the second for loop we are looping through all the associated contact records of an account and 
            //finding the sum of amount value field & updating it on account fied Total_sum_of_the_associated_con_rec__c
            
            for(Contact eachContact:eachAccountRecord.Contacts){
                TotalSumOfAmountFiledValueOfAssociatedRecords += eachContact.Amount__c;
            }
            eachAccountRecord.Total_sum_of_the_associated_con_rec__c=TotalSumOfAmountFiledValueOfAssociatedRecords;
            
    }
        //Finally updating the list
        UPDATE AccountRecords;
        
    }
    
   
   
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------Assignment Ends Here----------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    
}

*/


// As we have same code logic for After insert , After update , After delete , After undelete , 
// the best to enhance & optimize the performance in this situation is to write the code logic that is repeating
// in handler by defining a method & passing all the required parameters values useful in the logic.

if(trigger.isinsert && trigger.isafter){
    ContactTriggerHandler.updateAccountFields(Trigger.new);
}

if(trigger.isupdate && trigger.isafter){
    ContactTriggerHandler.updateAccountFieldsOnUpdate(Trigger.new,Trigger.oldMap);
}

if(trigger.isdelete && trigger.isafter){
    ContactTriggerHandler.updateAccountFields(Trigger.old);
}

if(trigger.isundelete && trigger.isafter){
    ContactTriggerHandler.updateAccountFields(Trigger.new);
}
}