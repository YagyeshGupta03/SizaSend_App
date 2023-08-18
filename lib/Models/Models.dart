


class UserModel {
  UserModel({
    required this.fullName,
    required this.phone,
    required this.countryCode,
  });

  final String fullName;
  final String phone;
  final String countryCode;
}



class BankModel {
  BankModel({
    required this.bankId,
    required this.fullName,
    required this.bankName,
    required this.account,
    required this.ifsc,
  });

  final String bankId;
  final String fullName;
  final String bankName;
  final String ifsc;
  final String account;
}