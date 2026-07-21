public interface OpportunityDAO {
  List<Opportunity> queryOpportunity(String query);
  List<Opportunity> queryOpportunitySystem(String query);
  void insertRecord(Opportunity opportunityRecord);
  void updateRecord(Opportunity opportunityRecord);
  void deleteRecord(Opportunity opportunityRecord);
}
