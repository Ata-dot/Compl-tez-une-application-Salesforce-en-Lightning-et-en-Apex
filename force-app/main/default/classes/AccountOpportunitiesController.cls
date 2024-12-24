public with sharing class AccountOpportunitiesController {
    /**
     * @description : Récupère la liste des opportunités associées à un compte spécifique.
     * @param accountId : L'identifiant du compte pour lequel récupérer les opportunités.
     * @return : Liste des opportunités (Id, Name, Amount, CloseDate, StageName).
     * @throws : Custom exception si l'accountId est null ou si une erreur se produit.
     */
    @AuraEnabled(Cacheable=true)
    public static List<Opportunity> getOpportunities(Id accountId) {
        // Vérification de la validité de l'identifiant du compte
        if (accountId == null) {
            throw new AuraHandledException('L\'identifiant du compte (accountId) est requis.');
        }
        
        try {
            // Requête pour récupérer les opportunités
            return [
                SELECT Id, Name, Amount, CloseDate, StageName
                FROM Opportunity
                WHERE AccountId = :accountId
            ];
        } catch (Exception e) {
            // Gestion des erreurs et renvoi d'un message clair
            throw new AuraHandledException('Une erreur est survenue lors de la récupération des opportunités : ' + e.getMessage());
        }
    }
}
