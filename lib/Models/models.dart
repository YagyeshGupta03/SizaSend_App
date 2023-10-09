
//Model classes for project



//User model
class UserModel {
  UserModel({
    required this.fullName,
    required this.phone,
    required this.countryCode,
    required this.image,
    required this.userId,
  });

  final String fullName;
  final String phone;
  final String countryCode;
  final String image;
  final String userId;
}


//Bank account model
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


//Occupation list model
class OccupationModel {
  OccupationModel({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;
}


//Quotation model
class QuotationModel {
  QuotationModel({
    required this.id,
    required this.productName,
    required this.price,
    required this.store,
    required this.quantity,
    required this.weight,
    required this.width,
    required this.height,
    required this.orderId,
    required this.description,
    required this.video,
    required this.paid,
    this.senderId = '',
    this.receiverId = '',
    this.status = '',
  });

  final String id;
  final String productName;
  final String orderId;
  final String price;
  final String store;
  final String quantity;
  final String weight;
  final String width;
  final String height;
  final String description;
  final String video;
  final String senderId;
  final String receiverId;
  final String status;
  final String paid;
}


//Notification model
class NotificationModel {
  NotificationModel({
    required this.orderId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.notificationId,
    required this.status,
    required this.date,
  });

  final String orderId;
  final String senderId;
  final String receiverId;
  final String message;
  final String notificationId;
  final String status;
  final DateTime date;
}


//Contact list model
class ContactModel {
  ContactModel({
    required this.fullName,
    required this.userId,
    required this.image,
  });

  final String userId;
  final String fullName;
  final String image;
}


//Wallet transactions model
class WalletTransactionModel {
  WalletTransactionModel({
    required this.transactionId,
    required this.balance,
    required this.status,
    required this.paidUser,
    required this.date,
    required this.time,
  });

  final String transactionId;
  final String balance;
  final String status;
  final String paidUser;
  final String date;
  final String time;
}




//Withdrawal history model
class WithdrawalRequestModel {
  WithdrawalRequestModel({
    required this.requestId,
    required this.amount,
    required this.status,
    required this.bankName,
    required this.date,
    required this.time,
    required this.acNumber,
    required this.ifsc,
    required this.charges,
  });

  final String requestId;
  final String amount;
  final String status;
  final String bankName;
  final String date;
  final String time;
  final String acNumber;
  final String ifsc;
  final String charges;
}



class BuyerModel {
  BuyerModel({
    required this.receiverId,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.image,
  });

  final String receiverId;
  final String fullName;
  final String phone;
  final String email;
  final String image;
}