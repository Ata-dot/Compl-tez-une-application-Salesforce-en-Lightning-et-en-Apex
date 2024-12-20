public with sharing class AccountCasesController {

    @AuraEnabled(Cacheable=true)
    public static List<Case> getCases(Id accountId) {
        return CaseSelector.getCasesbyAccountId(accountId);
    }
}
