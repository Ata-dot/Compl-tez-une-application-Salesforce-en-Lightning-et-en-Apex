public with sharing class AccountCasesController {

    @AuraEnabled(Cacheable=true)
    public static List<Case> getCases(Id accountId) {
        return AccountCasesController.getCasesbyAccountId(accountId);
        }
List<Case> cases = [
    FROM Case
    WHERE AccountId :accountId
    ORDER BY CreatedDate DESC
    ];
}
