public with sharing class StandardController {
    
    public Contact newCon {get;set;}

    public StandardController(ApexPages.StandardController con){
       newCon = (Contact)con.getRecord();
    }
 


}