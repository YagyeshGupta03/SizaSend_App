import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/all_urls.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Models/Models.dart';
import 'package:savo/screen/profile/BankAccount_screens/bankAc_listing.dart';
import '../Helper/http_helper.dart';

class BankController extends GetxController {
  //
  //
  //
  void addBankAc(context, fullName, bankName, ifsc, account) async {
    final NetworkHelper networkHelper = NetworkHelper(url: addBankAcUrl);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
      "full_name": fullName,
      "bank_name": bankName,
      "ifsc_code": ifsc,
      "account_no": account,
    });

    if (reply['status'] == 1) {
      showBankAc();
      Fluttertoast.showToast(
        msg: "${reply['message']}",
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
      );
      Get.to(()=> const BankListingScreen());
    } else {
      Fluttertoast.showToast(
        msg: "${reply['message']}",
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
    }
  }

  //
  //
  //
  RxList<BankModel> bankList = <BankModel>[].obs;
  void showBankAc() async {
    final NetworkHelper networkHelper = NetworkHelper(url: getBankAcUrl);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
    });

    if (reply['status'] == 1) {
      bankList.clear();
      for (int i = 0; i < reply['data'].length; i++) {
        bankList.add(BankModel(
          bankId: reply['data'][i]['id'].toString(),
          fullName: reply['data'][i]['full_name'].toString(),
          bankName: reply['data'][i]['bank_name'].toString(),
          account: reply['data'][i]['account_no'].toString(),
          ifsc: reply['data'][i]['ifsc_code'].toString(),
        ));
        update();
      }
    } else {
      print('Error in getting bank details');
    }
  }
  //
  //
  //
  void deleteBankAc(context, bankId) async {
    final NetworkHelper networkHelper = NetworkHelper(url: deleteBankAcUrl);
    var reply = await networkHelper.postData({
      "bank_id": bankId,
    });

    if (reply['status'] == 1) {
      showBankAc();
      Fluttertoast.showToast(
        msg: "${reply['message']}",
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
      );
    } else {
      Fluttertoast.showToast(
        msg: "${reply['message']}",
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
    }
  }
}
//
//
//
//
//
class Profile extends GetxController{






}