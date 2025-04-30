public class exampleFutureMethod {
    
    public exampleFutureMethod() {  // Constructor will have same name as class name & will not have any return type
        takeShower();  // takeShower() & takeBreakfast() will run in one transaction ----- 1
   		takeBreakfast();  // takeShower() & takeBreakfast() will run in one transaction----- 1
        carServicing(); // carServicing() will run in one seprate transaction as it is a FUTURE method ----- 1
        wentToFunction();  // wentToFunction() will also run in one seprate transaction as it is a FUTURE method ----- 1
        bikeServicing();
        
    }
    
    // takeShower() & takeBreakfast() will run in one transaction
    
    public static void takeShower(){
        System.debug('I took my shower bath');
    }
    
     public static void takeBreakfast(){
        System.debug('I had my Breakfast');
    }
     
    
    // carServicing() will run in one seprate transaction
    
      @Future
     public static void carServicing(){
        System.debug('I gave my car for servicing');
    }
    
      @Future
      public static void bikeServicing(){
        System.debug('I gave my bike for servicing');
    }
    // wentToFunction() will also run in one seprate transaction
    
    // carServicing() & wentToFunction() are FUTURE methods here , so they will run in two seprate threads asyncronously
    
    // The methods which we want to define as FUTURE methods should be annotated with  '@Future' annotation they will run in the background Asynchronously in a seprate thread/transaction
    // and they should be 'STATIC' , 'VOID'
    
 
     public static void wentToFunction(){
        System.debug('And then I went to function taking Rapido ride!!! function and car servicing center are just 1 KM far');
    }
}

// The methods which we want to define as FUTURE methods should be annotated with  '@Future' annotation they will run in the background Asynchronously in a seprate thread/transaction sometime in future when resources are available 
// and the methods should be 'STATIC' , 'VOID' as they run 
// 
// 
// 
// 
// 
////////////////////////         LIMITATIONS             /////////////////////////////////
// 1) FUTURE METHODS ONLY SUPPORTS PRIMITIVE DATA TYPES AS PARAMETERS
// 2) WE CANNOT CALL ONE FUTURE METHOD FROM ANOTHER FUTURE METHOD
//////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
//
//////////////////////////////////////         USE CASES             ////////////////////////////////////////////////
// 1) USED TO RUN THINGS in the background Asynchronously , EXAMPLE : BULK DELETION OF 1 MILLION RECORDS
// 2) AVIOD MIXED DML EXCEPTION BY PLACING SETUP OBJECTS IN ONE METHOD & NON-SETUP OBJECTS IN A FUTURE METHOD
// 3) AS TRIGGERS CANNOT MAKE CALL-OUTS DIRECTLY WE USE FUTURE METHOD TO MAKE CALL-OUTS TO EXTERNAL SYSTEM
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////