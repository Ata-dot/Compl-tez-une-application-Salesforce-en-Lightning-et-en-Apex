/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-25-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OpportunitySelector {

   
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunitiesByAccountId(Id accountId) {
        
        System.debug('Début de la méthode getOpportunitiesByAccountId');
        System.debug('Paramètre reçu accountId: ' + accountId);

        // Vérification que l'ID de compte n'est pas null pour éviter des erreurs de requête
        if (accountId == null) {
            System.debug('Erreur: accountId est null');
            throw new AuraHandledException('Account Id cannot be null');
        }

        // Requête SOQL pour obtenir les opportunités associées à ce compte
        // Cette requête récupère les champs nécessaires et filtre par AccountId
        List<Opportunity> opportunities = [
            SELECT Id, Name, Amount, CloseDate, StageName 
            FROM Opportunity 
            WHERE AccountId = :accountId
        ];

        System.debug('Opportunités récupérées: ' + opportunities);
        return opportunities;
    }
}
