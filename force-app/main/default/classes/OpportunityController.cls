public with sharing class OpportunityController {
    public List<Contact> del {get; set;}
    public string recId {get; set;}
    public String accId {get; set;}
 
    public Opportunity opportunity {get; set;}
    public List<Opportunity> oppList {get; set;}

    public String userInput {get; set;}
    public String selectedStage {get; set;}

    public Date closeDate {get; set;}
  
    
    // Integer month;
    // Integer day;
    // Integer year;

    public String pageName { get; set; }


    public OpportunityController() {
        userInput = '';
        selectedStage = '';
        closeDate = null;
        oppList = new List<Opportunity>();
        opportunity = new Opportunity();

    }


    public PageReference navigateToPage() {
        if (String.isNotBlank(pageName)) {
            PageReference pr = new PageReference('/apex/' + pageName);
            return pr;
            }
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid page name.'));
        return null;
    }



    public void getOpportunities() {   
        try {
            oppList = [SELECT Name, StageName, CloseDate FROM Opportunity];
        } catch (Exception e) {
            System.debug('Error retrieving opportunities: ' + e.getMessage());
            // Handle exception
        }
    }
 
    public void createOpportunity() {
        if (!String.isEmpty(opportunity.Name) && !String.isEmpty(opportunity.StageName) && opportunity.CloseDate != null) {
            try {
                // Correct Datetime instantiation
                Datetime newDate = Datetime.newInstance(closeDate.year(), closeDate.month(), closeDate.day());
                String formattedDate = newDate.format('MM/dd/yyyy');
                Date parsedDate = Date.parse(formattedDate);
                opportunity = new Opportunity(Name = userInput, StageName = selectedStage, CloseDate = parsedDate);
    
                insert opportunity;
    
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Opportunity created successfully!'));
    
                // Reset fields
                opportunity = new Opportunity();
                userInput = '';
                selectedStage = '';
                closeDate = null;
    
                getOpportunities();
    
            } catch (Exception e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error creating opportunity: ' + e.getMessage()));
            }
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please fill all required fields (Name, Stage, Close Date).'));
        }
    }
    

    

    
    public void deleteOpportunity() {
        try {
            delete [SELECT Id FROM Lead WHERE Id = :recId];
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Technician deleted successfully.'));
            getOpportunities();
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage()));
        }
    }
}