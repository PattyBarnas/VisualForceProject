public with sharing class CustomController {
    public List<Contact> del {get; set;}
    public string recId {get; set;}
    public String accid {get; set;}
    public Contact contact {get; set;}
    public List<Contact> contList {get; set;}
    public Account account {get; set;}
    public List<Account> accList {get; set;}

    public Technician__c technician {get; set;}
    public List<Technician__c> techList {get; set;}

    public String userInput {get; set;}

    public String pageName { get; set; }

    // Constructor
    public CustomController() {
        contact = new Contact();
        contList = new List<Contact>();
        account = new Account();
        accList = new List<Account>();
        technician = new Technician__c();
        userInput = '';
    }


    // NAVIGATION
    public PageReference navigateToPage() {
        if (String.isNotBlank(pageName)) {
            PageReference pr = new PageReference('/apex/' + pageName);
            return pr;
            }
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid page name.'));
        return null;
    }

    // Fetch all Contacts

    public void getContacts() {
        
        contList = [SELECT Id, LastName FROM Contact];
        
    }
    public void getTechs() {
        techList = [SELECT Id, Name FROM Technician__c];
    }

    // Create a new Contact
    public void createContact() {
        if (!String.isEmpty(userInput)) {
            contact.LastName = userInput;
        }
        try {
            insert contact;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'New user has been created!'));
            contact = new Contact(); 
            userInput = ''; 

            getContacts();
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage()));
        }
    }

    // Create technician
    public void createTechnician() {
        if (String.isEmpty(userInput)) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Name is required to create a technician.'));
            return; 
        }
        try {
            technician.Name = userInput;
            insert technician;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'New user has been created!'));
            userInput = ''; 
            technician = new Technician__c(); 

            getTechs(); 
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage()));
        }
    }

    
    public void deleteContact() {
        try {
            delete [SELECT Id FROM Contact WHERE Id = :recId];
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Contact deleted successfully.'));
            getContacts(); 
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage()));
        }
    }
    
    public void deleteTech() {
        try {
            delete [SELECT Id FROM Technician__c WHERE Id = :recId];
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Technician deleted successfully.'));
            getTechs();
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage()));
        }
    }
}
