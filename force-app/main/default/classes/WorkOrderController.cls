public with sharing class WorkOrderController {
    public String pageName { get; set; }

    public String selectedTechnician {get; set;}

    public String subject {get; set;}

    public String description  { get; set;}

    public List<WorkOrder> workOrderList {get; set;}
    public WorkOrder workOrder {get; set;}

    public Id recId {get; set;}

    public WorkOrderController() {

        workOrderList = new List<WorkOrder>();
        subject = '';
        description = '';

    }
    public PageReference navigateToPage() {
        if (String.isNotBlank(pageName)) {
            PageReference pr = new PageReference('/apex/' + pageName);
            return pr;
            }
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid page name.'));
        return null;
    }

    public void getWorkOrders() {
        workOrderList = [SELECT subject, description, 
                         technicians__c 
                         FROM WorkOrder];
    }

  
    public void createWorkOrder() { 
        try {
            if(String.isNotBlank(subject) && String.isNotBlank(description) && String.isNotBlank(selectedTechnician)) {
                WorkOrder newWorkOrder = new WorkOrder(
                    technicians__c = selectedTechnician, 
                    subject = subject, 
                    description = description
                );
                insert newWorkOrder;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'New user has been created!'));
    
                subject = '';
                description = '';
                selectedTechnician = 'None';
                getWorkOrders(); 
            } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'All fields are required.'));
            }
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));  
        }
    }
    

    public List<SelectOption> getTechnicianOptions() {
        List<SelectOption> options = new List<SelectOption>();
        try {
            for (Technician__c tech : [SELECT Id, Name FROM Technician__c]) {
                options.add(new SelectOption(tech.Id, tech.Name));
            }
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
           
            options = new List<SelectOption>();
        }
        return options;
    }

    public void deleteWorkOrder(){
        try {
            delete [SELECT Id FROM WorkOrder WHERE Id = :recId];
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Contact deleted successfully.'));
            getWorkOrders(); 
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage()));
        }
    }




}