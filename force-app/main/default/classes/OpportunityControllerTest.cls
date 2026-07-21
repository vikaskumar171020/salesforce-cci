@IsTest
public with sharing class OpportunityControllerTest {
  @IsTest
  static void checkDAO() {
    Test.startTest();
    OpportunityController.opportunityMethods = new OpportunityTestUtilityClass();
    OpportunityController.checkDAO();
    Test.stopTest();
  }

  public with sharing class OpportunityTestUtilityClass implements OpportunityDAO {
    public List<Opportunity> queryOpportunity(String query) {
      Id fakeOpportunityId = Id.valueOf(
        Opportunity.getSObjectType().getDescribe().getKeyPrefix() +
        '000000000000'
      );
      return new List<Opportunity>{ new Opportunity(Id = fakeOpportunityId) };
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
}
