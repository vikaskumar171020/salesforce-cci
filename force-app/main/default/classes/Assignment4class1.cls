public class Assignment4class1 {
  //For Insert
  public static void forinsert(List<Account> acc) {
    List<Opportunity> opplis1 = new List<Opportunity>();
    //Starting of Function for Insert Operation
    for (Account accvar : acc) {
      //getting Account Name
      Opportunity oppvar = new Opportunity(
        Name = 'First Opportunity ' + accvar.Name,
        StageName = 'Prospecting',
        CloseDate = Date.today() + 15,
        AccountId = accvar.Id
      );
      opplis1.add(oppvar);
    }
    System.debug(opplis1);
    Database.insert(opplis1, false);
  }

  //For Update
  public static void forUpdate(List<Account> acc1) {
    Set<Id> idlis = new Set<Id>();
    List<Opportunity> opplis = [SELECT accountid FROM Opportunity];
    for (Opportunity oppvar : opplis) {
      idlis.add(oppvar.AccountId);
    }
    hello();
    for (Account accvar : acc1) {
      if (idlis.contains(accvar.Id)) {
        System.debug('Opportunity Exist');
      } else {
        Opportunity newopp = new Opportunity(
          Name = 'First Opportunity ' + accvar.Name,
          StageName = 'Prospecting',
          CloseDate = date.today() + 15,
          AccountId = accvar.Id
        );
        Database.insert(newopp, false);
      }
    }
  }

  //for Merge
  public static void mergeAccount(List<Account> acc) {
    //for merge record
    list<Account_Backup__c> accbacklis = new List<Account_Backup__c>();
    for (Account accvar : acc) {
      if (String.isNotBlank(accvar.MasterRecordId)) {
        accbacklis.add(
          new Account_Backup__c(
            Name = accvar.name,
            account_holder_email__c = accvar.account_holder_email__c
          )
        );
      }
    }
    if (accbacklis.size() > 0) {
      Database.insert(accbacklis, false);
    }
  }

  //for Delete
  public static void preventAccount(List<Account> a) {
    List<Opportunity> ac = [
      SELECT Name, accountID, StageName, isClosed
      FROM Opportunity
      WHERE accountID IN :a
    ];
    for (Account acc : a) {
      for (Opportunity afl : ac) {
        if (afl.IsClosed == false) {
          system.debug('ef');
        }
      }
    }
  }
}
