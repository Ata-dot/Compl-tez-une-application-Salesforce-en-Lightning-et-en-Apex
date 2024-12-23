@IsTest
private class AccountCasesControllerTest {
    @TestSetup
    static void setup() {
        Account testAccount = TestDataFactory.createTestAccount();
        TestDataFactory.createTestOpportunity(testAccount.Id);
    }

    @IsTest
    static void testFindCasesBySubject() {
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        Test.startTest();
        List<Case> results = AccountCasesController.FindCasesBySubject(testAccount.Id);
        Test.stopTest();
        Assert.areEqual(1, results.size(), 'Should return one case');
    }
}
