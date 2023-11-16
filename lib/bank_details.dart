
class BankDetails{
  int? id;
  late String bankName;
  late String branch;
  late String accountType;
  late String accountNumber;
  late String IFSCCode;

  BankDetails(
      this.id,
      this.bankName,
      this.branch,
      this.accountType,
      this.accountNumber,
      this.IFSCCode
      );
}