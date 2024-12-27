/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-25-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/

@IsTest
private class OpportunitySelectorTest {

    // Méthode @TestSetup pour préparer les données de test
    @TestSetup
    static void setup() {
        // Créer un test Account
        Account testAccount = TestDataFactory.createTestAccount();
        // Créer plusieurs Opportunités liées à ce compte
        List<Opportunity> opportunities = new List<Opportunity>();
        
        for (Integer i = 0; i < 5; i++) {
            Opportunity opp = new Opportunity(
                Name = 'Test Opportunity ' + i,
                AccountId = testAccount.Id,
                StageName = 'Prospecting',
                Amount = 10000 * (i + 1),
                CloseDate = Date.today().addDays(30)
            );
            opportunities.add(opp);
        }
        
        insert opportunities; // Insérer les opportunités dans la base de données

        // Débogage pour vérifier si l'Account et les Opportunités sont bien créés
        System.debug('Test Account created with Id: ' + testAccount.Id);
        System.debug('Created ' + opportunities.size() + ' Opportunities for Test Account');
    }

    // Test unitaire pour la méthode getOpportunitiesByAccountId
    @IsTest
    static void testGetOpportunitiesByAccountId() {
        // Récupérer l'Account spécifique créé dans @TestSetup
        Account testAccount = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];

        // Débogage pour vérifier l'Account récupéré
        System.debug('Retrieved Test Account with Id: ' + testAccount.Id);

        // Démarrer le test pour mesurer les limites de gouvernance
        Test.startTest();

        // Appeler la méthode à tester
        List<Opportunity> results = OpportunitySelector.getOpportunitiesByAccountId(testAccount.Id);

        // Débogage pour vérifier les résultats des opportunités
        System.debug('Retrieved Opportunities: ' + results);

        // Arrêter le test
        Test.stopTest();

        // Validation : Vérifier que l'on obtient bien des opportunités associées au compte
        System.assertNotEquals(0, results.size(), 'Should return at least one opportunity');
        
        // Validation : Vérifier le nom de la première opportunité
        System.assertEquals('Test Opportunity 0', results[0].Name, 'The Opportunity Name should be correct');
        System.assertEquals('Prospecting', results[0].StageName, 'The Opportunity Stage should be correct');
        System.assertEquals(10000, results[0].Amount, 'The Opportunity Amount should be correct');
        
        // Vérifier qu'on a bien récupéré toutes les opportunités (5 dans ce cas)
        System.assertEquals(5, results.size(), 'Should return 5 opportunities');
    }
}
