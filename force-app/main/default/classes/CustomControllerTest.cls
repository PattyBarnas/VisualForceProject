@isTest
private class CustomControllerTest {

    @isTest
    static void myUnitTest() {
        // TO DO: implement unit test
    }
    @isTest
    static void testGetContacts(){
        List<Contact> conList = new List<Contact>();
      
        Contact con = new Contact(LastName = 'Patryk');
        conList.add(con);

        insert conList;

        CustomController cc = new CustomController();

        Test.startTest();
        cc.getContacts();
        Test.stopTest();


        System.assertNotEquals(null, cc.contList,'List size should match');
        System.assertEquals(1, cc.contList.size(), 'should have 1 contact in the list');
    }

    @isTest
    static void testGetTechs(){
        List<Technician__c> techList = new List<Technician__c>();

        for(Integer i = 0; i < 5; i++){
            Technician__c newTech = new Technician__c(Name = 'Barnas ' + i);
            techList.add(newTech);
        }

        insert techList;

        CustomController cc = new CustomController();

        Test.startTest();
        cc.getTechs();
        Test.stopTest();

        System.assertNotEquals(null, cc.techList, 'Lead list should not be null');
        System.assertEquals(5, cc.techList.size(), 'Lead list size should be 5');
        System.assertNotEquals(4, cc.techList.size(), 'Lead list size should be 5');

    }


    @isTest
    static void testCreateContact(){
    
    String user = 'user 1';

    CustomController cc = new CustomController();

        cc.userInput = user;

        Test.startTest();
        cc.createContact();
        Test.stopTest();

        Contact createdAcc = [SELECT LastName FROM Contact WHERE LastName = 'user 1'];

        System.assertEquals('user 1', createdAcc.LastName, 'name should be the same');
        System.assertNotEquals('user 2', createdAcc.LastName, 'names should not equal');
        // System.assertEquals(False, String.isEmpty(createdAcc.Name), 'String is not Empty');

    }
    @isTest
    static void testCreateTechs(){
        String user = 'user 1';
      

        CustomController cc = new CustomController();


        cc.userInput = user;

        Test.startTest();
        cc.createTechnician();
        Test.stopTest();

        Technician__c createdTech = [SELECT Name FROM Technician__c WHERE Name = 'user 1'];

        System.assertNotEquals('user 2', createdTech.Name, 'names should not equal');
        System.assertEquals(False, String.isEmpty(createdTech.Name), 'String is not Empty');
        // Failing Test
        // System.assertEquals(True, String.isEmpty(createdTech.Company), 'Should fail');

    }
    @isTest
    static void testDeleteContact() {
      
        Contact con = new Contact(LastName = 'Patryk');

        insert con;
    
        CustomController cc = new CustomController();
    
        cc.recId = con.Id;
    
        Test.startTest();
        cc.deleteContact();
        Test.stopTest();

        List<Contact> delAccList = [SELECT Id FROM Contact WHERE Id = :con.Id];
        System.assertEquals(0, delAccList.size(), 'The account should be deleted');
    }
}