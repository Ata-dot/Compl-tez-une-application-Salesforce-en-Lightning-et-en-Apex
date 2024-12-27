public with sharing class AccountCasesController {
    @AuraEnabled(cacheable=true)
    public static List<Case> findCasesBySubject(String subject) {
        
        // Log de l'entrée de la méthode
        System.debug('Entrée dans findCasesBySubject, sujet fourni : ' + subject);
        
        // Vérification que le sujet n'est pas vide ou null
        if (String.isBlank(subject)) {
            System.debug(' Le paramètre "subject" est vide ou null. Retour d\'une liste vide.');
            return new List<Case>(); // Retourner une liste vide si le sujet est invalide
        }

        try {
            // Log avant l'exécution de la requête
            System.debug(' Recherche des cas avec le sujet : ' + subject);

            // Recherche des cas correspondant au sujet
            List<Case> cases = [SELECT Id, Subject FROM Case WHERE Subject = :subject LIMIT 1000];

            // Log après la récupération des cas
            System.debug('Nombre de cas trouvés : ' + cases.size());
            return cases;

        } catch (Exception ex) {
            // Log en cas d'erreur
            System.debug('Erreur dans findCasesBySubject : ' + ex.getMessage());
            throw new AuraHandledException('Une erreur s\'est produite lors de la récupération des cas.');
        }
    }
}
