/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-25-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountOpportunitiesController {
    /**
     * @description : Récupère la liste des opportunités associées à un compte spécifique.
     * @param accountId : L'identifiant du compte pour lequel récupérer les opportunités.
     * @return : Liste des opportunités (Id, Name, Amount, CloseDate, StageName).
     * @throws : Custom exception si l'accountId est null ou si une erreur se produit.
     */
    @AuraEnabled(Cacheable=true)
    public static List<Opportunity> getOpportunities(Id accountId) {
        // Debug: début de la méthode
        System.debug('Début de la méthode getOpportunities');
        System.debug('Paramètre reçu - accountId: ' + accountId);
    
        // Vérification de la validité de l'identifiant du compte
        if (accountId == null) {
            System.debug('L\'identifiant du compte est null. Lancement d\'une exception.');
            throw new NullPointerException('accountID ne peut pas etre null.');
        }
     // Proceed with logic to retrieve opportunities for the accountId
    return [SELECT Id, Name, Amount, StageName FROM Opportunity WHERE AccountId = :accountId];
}
}

