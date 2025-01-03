/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-03-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@IsTest
public class AccountOpportunitiesControllerTest {
    @TestSetup
    static void setupTestData() {
        System.debug('Démarrage de la méthode setupTestData');
        // Créer un compte et des opportunités de test
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        System.debug('Compte créé : ' + acc);

        Opportunity opp1 = new Opportunity(
            Name = 'Opportunity 1',
            Amount = 5000,
            CloseDate = Date.today().addDays(30),
            StageName = 'Prospecting',
            AccountId = acc.Id
        );
        Opportunity opp2 = new Opportunity(
            Name = 'Opportunity 2',
            Amount = 10000,
            CloseDate = Date.today().addDays(60),
            StageName = 'Negotiation',
            AccountId = acc.Id
        );
        insert new List<Opportunity>{ opp1, opp2 };

        System.debug('Opportunités créées : ' + new List<Opportunity>{ opp1, opp2 });
    }

    @IsTest
    static void testGetOpportunitiesWithValidAccount() {
        System.debug('Démarrage de la méthode testGetOpportunitiesWithValidAccount');

        // Récupérer le compte créé
        Account acc = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];
        System.debug('Compte récupéré : ' + acc);

        // Appeler la méthode Apex
        List<Opportunity> opps = AccountOpportunitiesController.getOpportunities(acc.Id);
        System.debug('Opportunités récupérées : ' + opps);

        // Vérifier que les opportunités sont récupérées
        System.assertEquals(2, opps.size(), 'Deux opportunités doivent être récupérées.');
        System.assertEquals('Opportunity 1', opps[0].Name, 'Le nom de la première opportunité doit être "Opportunity 1"');
    }

    @IsTest
    static void testGetOpportunitiesWithNoOpportunities() {
        System.debug('Démarrage de la méthode testGetOpportunitiesWithNoOpportunities');

        // Créer un compte sans opportunités
        Account acc = new Account(Name = 'Empty Account');
        insert acc;
        System.debug('Compte créé (sans opportunités) : ' + acc);

        // Appeler la méthode
        List<Opportunity> opps = AccountOpportunitiesController.getOpportunities(acc.Id);
        System.debug('Opportunités récupérées (aucune attendue) : ' + opps);

        // Vérifier que la liste est vide
        System.assertEquals(0, opps.size(), 'Aucune opportunité ne doit être retournée.');
    }
}
