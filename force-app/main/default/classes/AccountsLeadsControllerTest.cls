
@isTest
private class AccountsLeadsControllerTest {

    @isTest
    static void myUnitTest() {
        // TO DO: implement unit test
    }
    @isTest
    static void testGetContacts(){
        List<Account> accList = new List<Account>();
      
        Account acc = new Account(Name = 'Patryk');
        accList.add(acc);

        insert accList;

        AccountsLeadsController alc = new AccountsLeadsController();

        Test.startTest();
        alc.getAccs();
        Test.stopTest();


        System.assertNotEquals(null, alc.accList,'List size should match');
        System.assertEquals(1, alc.accList.size());
    }

    @isTest
    static void testGetTechs(){
        List<Lead> leadList = new List<Lead>();

        for(Integer i = 0; i < 5; i++){
            Lead newLead = new Lead(lastName = 'Barnas ' + i, Company = 'test ' + i, Status = 'Open - Not Contacted');
            leadList.add(newLead);
        }

        insert leadList;

        AccountsLeadsController alc = new AccountsLeadsController();

        Test.startTest();
        alc.getLeads();
        Test.stopTest();

        System.assertNotEquals(null, alc.leadList, 'Lead list should not be null');
        System.assertEquals(5, alc.leadList.size(), 'Lead list size should be 5');
        System.assertEquals(4, alc.leadList.size(), 'Lead list size should be 5');

    }

    @isTest
    static void testCreateContact(){
        String user = 'user 1';

        AccountsLeadsController alc = new AccountsLeadsController();

        alc.userInput = user;

        Test.startTest();
        alc.createAccount();
        Test.stopTest();

        Account createdAcc = [SELECT Name FROM Account WHERE Name = 'user 1'];

        System.assertEquals('user 1', createdAcc.Name, 'name should be the same');
        System.assertNotEquals('user 2', createdAcc.Name, 'names should not equal');
        System.assertEquals(False, String.isEmpty(createdAcc.Name), 'String is not Empty');

    }
    @isTest
    static void testCreateTech(){
        String user = 'user 1';
        String company = 'company';

        AccountsLeadsController alc = new AccountsLeadsController();

        alc.userInput = user;
        alc.companyInput = company;

        Test.startTest();
        alc.createLeads();
        Test.stopTest();

        Lead createdLead = [SELECT lastName FROM Lead WHERE lastName = 'user 1'];

        System.assertEquals('company', createdLead.company, 'company name should be the same');
        System.assertNotEquals('user 2', createdLead.lastName, 'names should not equal');
        System.assertEquals(False, String.isEmpty(createdLead.lastName), 'String is not Empty');
        // Failing Test
        System.assertEquals(True, String.isEmpty(createdLead.Company), 'Should fail');

    }
    @isTest
    static void testDeleteContact() {
        // Create a test Account
        Account acc = new Account(Name = 'Patryk');
        insert acc;
    
    
        AccountsLeadsController alc = new AccountsLeadsController();
    
      
        alc.recId = acc.Id;
    
        Test.startTest();
        alc.deleteAccount();
        Test.stopTest();

        List<Account> delAccList = [SELECT Id FROM Account WHERE Id = :acc.Id];
        System.assertEquals(0, delAccList.size(), 'The account should be deleted');
    }
    
}