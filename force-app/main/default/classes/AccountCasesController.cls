public with sharing class AccountCasesController {

    @AuraEnabled(cacheable=true)
    public static List<Case> findCasesBySubject(String subject){
        return [SELECT Id, Subject FROM Case WHERE Subject = :subject];

    }


}
