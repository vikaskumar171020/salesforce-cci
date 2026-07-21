public with sharing class OpportunityController {
  @TestVisible
  private static OpportunityDAO opportunityMethods = new OpportunityUtilityClass();

  public static void checkDAO() {
    List<Opportunity> opportunityList = opportunityMethods.queryOpportunity(
      'SELECT Id FROM Opportunity LIMIT 1'
    );
    System.debug(opportunityList);
  }
}
