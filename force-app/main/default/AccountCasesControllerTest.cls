/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-25-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@IsTest
private class AccountCasesControllerTest {
    @TestSetup
    static void setup() {
        System.debug('Setting up test data for AccountCasesControllerTest');
        
        // Create test Account
        Account testAccount = TestDataFactory.createTestAccount();
        System.debug('Created test Account: ' + testAccount);
        
        // Create test Opportunity linked to the Account
        TestDataFactory.createTestOpportunity(testAccount.Id);
        System.debug('Created test Opportunity linked to Account: ' + testAccount.Id);

        // Create test Cases linked to the Account
        List<Case> cases = new List<Case>();
        for (Integer i = 0; i < 5; i++) {
            Case testCase = new Case(
                AccountId = testAccount.Id,
                Subject = 'Test Subject ' + i,
                Status = 'New'
            );
            cases.add(testCase);
        }
        insert cases; // Insert test cases into the database
        System.debug('Created 5 test Cases linked to Account: ' + testAccount.Id);
    }

    @IsTest
    static void testFindCasesBySubject() {
        System.debug('Running testFindCasesBySubject');
        
        // Fetch a test Account
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        System.debug('Fetched test Account: ' + testAccount);
        
        // Test logic: Find cases associated with this Account
        Test.startTest();
        List<Case> results = AccountCasesController.FindCasesBySubject(testAccount.Id);
        System.debug('Results from FindCasesBySubject: ' + results);
        Test.stopTest();

        // Assert that we retrieved the expected number of cases
        Assert.areEqual(5, results.size(), 'Should return 5 cases');
        System.debug('Assertion passed: 5 cases returned as expected');
    }
}
