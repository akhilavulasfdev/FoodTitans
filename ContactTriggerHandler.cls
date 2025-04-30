public class ContactTriggerHandler { 
    
    public static void updateAccountFieldsOnUpdate(List<Contact> ContactList , Map<Id,Contact> ContactOldMap){
        
         //Set will collect all the unique Account IDs when bulk contacts are uploaded and are associated to different accounts.
        Set<Id> contactsReparentedandPreviousAccountIDs= new Set<Id>();
        //Looping through each Contact Record to get its Reparented Account ID , only unique Account IDs are stored in the above Set.
        for(Contact eachContactRecord:ContactList){
            contactsReparentedandPreviousAccountIDs.add(eachContactRecord.AccountId); //Here we are getting & storing Contacts new Account ID to a set
            Contact contactsPreviousAccountIDs=ContactOldMap.get(eachContactRecord.Id); //Here we are getting same Contacts old details 
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
    
    
    public static void updateAccountFields(List<Contact> ContactList){
        //Set will collect all the unique Account IDs when bulk contacts are uploaded and are associated to different accounts.
        Set<Id> contactsAccountIDs= new Set<Id>();
        //Looping through each Contact Record to get its Account ID , only unique Account IDs are stored in the above Set.
        for(Contact eachContactRecord:ContactList){
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
    
}