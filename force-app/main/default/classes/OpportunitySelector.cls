public with sharing class OpportunitySelector {
@AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunitiesByAccountId(Id accountId) {
        return [SELECT Id, Name, Amount, CloseDate, StageName FROM Opportunity WHERE AccountId = :accountId];
    }
}
