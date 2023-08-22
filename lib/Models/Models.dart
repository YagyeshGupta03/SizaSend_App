


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



class OccupationModel {
  OccupationModel({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;
}



class QuotationModel {
  QuotationModel({
   required this.productID,
   required this.productName,
   required this.price,
   required this.store,
   required this.quantity,
   required this.weight,
   required this.width,
   required this.height,
   required this.description,
   required this.video,
  });

  final String productID;
  final String productName;
  final String price;
  final String store;
  final String quantity;
  final String weight;
  final String width;
  final String height;
  final String description;
  final String video;
}