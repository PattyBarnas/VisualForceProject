public with sharing class AccountsLeadsController {
    public List<Contact> del {get; set;}
    public String recId {get; set;}
    // public String accId {get; set;}
    public List<Lead> leadList {get; set;}
    public Lead lead {get; set;}
    public Account account {get; set;}
    public List<Account> accList {get; set;}

    public String userInput {get; set;}
    public String companyInput {get; set;}

    public String pageName { get; set; }

    // Constructor
    public AccountsLeadsController() {
        account = new Account();
        accList = new List<Account>();
        lead = new Lead();
        userInput = '';
        companyInput = '';
    }
    public void getAccs() {   
        accList = [SELECT Id, Name FROM Account];
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
   
 
    public void getLeads() {   
        leadList = [SELECT Id, Name, Company FROM Lead];
    }
 

    // Create a new Contact
    public void createAccount() {
        if (!String.isEmpty(userInput)) {
            account.Name = userInput;
        }
        try {
            insert account;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'New user has been created!'));
            userInput = ''; 
            Account = new Account(); 

            getAccs();
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage()));
        }
    }

    // Create lead
    public void createLeads() {
        if (!String.isEmpty(userInput)) {
            lead.lastName = userInput;
            lead.company = companyInput;
        }
        try {
            insert lead;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'New user has been created!'));
            userInput = ''; 
            companyInput = '';
            lead = new lead(); 

            getLeads(); 
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage()));
        }
    }

    
    public void deleteAccount() {
        try {
            delete [SELECT Id FROM Account WHERE Id = :recId];
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Contact deleted successfully.'));
            getAccs(); 
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage()));
        }
    }
    
    public void deleteLead() {
        try {
            delete [SELECT Id FROM Lead WHERE Id = :recId];
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Technician deleted successfully.'));
            getLeads();
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage()));
        }
    }
}
