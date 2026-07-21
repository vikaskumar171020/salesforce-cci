public with sharing class OpportunityUtilityClass implements OpportunityDAO {
  public List<Opportunity> queryOpportunity(String query) {
    return Database.query(query);
  }

  public List<Opportunity> queryOpportunitySystem(String query) {
    return null;
  }

  public void insertRecord(Opportunity opportunityRecord) {
  }

  public void updateRecord(Opportunity opportunityRecord) {
  }

  public void deleteRecord(Opportunity opportunityRecord) {
  }
}
