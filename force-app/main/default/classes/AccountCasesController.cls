public with sharing class AccountCasesController {

    @AuraEnabled
    public static List<Case> findCasesBySubject(String subject) {
        if (String.isEmpty(subject)) {
            // Return an empty list if no subject is provided
            return new List<Case>();
        }

        // Perform the SOQL query to find cases with the given subject
        List<Case> cases = [
            SELECT Id, CaseNumber, Subject, Status, Priority, AccountId
            FROM Case
            WHERE Subject LIKE :subject
            ORDER BY CreatedDate DESC
        ];

        // Return the found cases
        return cases;
    }
}
