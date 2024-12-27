/**
 * @description       : Classe de test pour créer et récupérer des données de test pour Account et Opportunity
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-27-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class TestDataFactory {

    // Méthode pour créer un compte de test
    @testSetup
    public static void createTestData() {
        // Créer un compte de test
        Account acc = new Account(Name='Test Account');
        insert acc;
        System.debug('Compte créé : ' + acc);

        // Créer une opportunité liée au compte
        Opportunity opp = new Opportunity(
            Name='Test Opportunity',
            StageName='Prospecting',
            CloseDate=System.today().addDays(30),
            Amount=10000,
            AccountId=acc.Id
        );
        insert opp;
        System.debug('Opportunité créée : ' + opp);
    }

    // Méthode pour récupérer un compte de test existant
    public static Account getTestAccount() {
        Account TestAccount = [SELECT Id, Name FROM Account WHERE Name = 'Test Account' LIMIT 1];
        System.debug('Compte récupéré : ' + TestAccount);
        return testAccount;
    }

   // Method pour récupérer une opportunité liée à un compte
public static Opportunity getTestOpportunity(Id accountId) {
    System.debug('Recup de l\'opportunité de test pour le compte : ' + accountId);
    Opportunity opp = [SELECT Id, Name, StageName, Amount 
                       FROM Opportunity 
                       WHERE AccountId = :accountId 
                       LIMIT 1];
    system.debug('Opportunité récupérée : ' + opp);                   
        return opp;
    }

    // Méthode pour vérifier et récupérer un compte
    public static Account getOtCreateTestAccount() {
        system.debug('Vérification ou créarion du compte de test');
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name = 'Test Account' LIMIT 1];
        if(!accounts.isEmpty()) {
            system.debug('Compte existant retrouvée : ' + accounts[0]);
            return accounts[0];
        } else {
            Account acc = new Account(Name='Test Account');
            insert acc;
            system.debug('Compte créé : ' + acc);
            return acc;
    }
}
   // Méthode pour vérifier et récupérer une opportunité liée à un compte
    public static Opportunity getOrCreateTestOpportunity(Id accountId) {
        System.debug('Vérification ou création de l\'opportunité de test pour le compte : ' + accountId);
        List<Opportunity> opportunities = [SELECT Id, Name, StageName, Amount 
                                           FROM Opportunity 
                                           WHERE AccountId = :accountId 
                                           LIMIT 1];
        if(!opportunities.isEmpty()) {
            System.debug('Opportunité existante retrouvée : ' + opportunities[0]);
            return opportunities[0];
        } else {
            Opportunity opp = new Opportunity(
                Name='Test Opportunity',
                StageName='Prospecting',
                CloseDate=System.today().addDays(30),
                Amount=10000,
                AccountId=accountId
            );
            insert opp;
            System.debug('Opportunité créée : ' + opp);
            return opp;
        }
    }
