public with sharing class AccountCasesController {

    @AuraEnabled(Cacheable=true)
    public static List<Case> getCases(Id accountId) {
        return AccountCaseController.getCasesbyAccountId(accountId);
    }
}
