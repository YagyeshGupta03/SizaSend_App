import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/all_urls.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Models/Models.dart';
import 'package:savo/screen/profile/BankAccount_screens/bankAc_listing.dart';
import 'package:savo/screen/profile/UserAccountScreens/account_info_screen.dart';
import '../Helper/http_helper.dart';
import '../generated/l10n.dart';

class BankController extends GetxController {
  //
  //
  //  Add bank account
  void addBankAc(context, fullName, bankName, ifsc, account) async {
    final NetworkHelper networkHelper = NetworkHelper(url: addBankAcUrl);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id.toString(),
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
      Get.to(() => const BankListingScreen());
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
  //  Get bank account list
  RxList<BankModel> bankList = <BankModel>[].obs;
  void showBankAc() async {
    final NetworkHelper networkHelper = NetworkHelper(url: getBankAcUrl);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id.toString(),
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
  //  Delete bank account
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
class ProfileController extends GetxController {
  //  Image updates
  Future profileImageUpdate(context, image) async {
    final NetworkHelper networkHelper = NetworkHelper(url: profileImageUrl);
    var reply = await networkHelper.postMultiPartData(
        {"user_id": credentialController.id.toString()},
        [image],
        "profile_image");

    if (reply['status'] == 1) {
      userInfoController
          .getUserInfo();
      Fluttertoast.showToast(
        msg: S.of(context).imageUpdatedSuccessfully,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
      );
    } else {
      print('Error in uploading image');
    }
  }

  //
  //
  //
  //  Occupation list
  RxList<OccupationModel> occupationList = <OccupationModel>[].obs;
  void getOccupationData() async {
    final NetworkHelper networkHelper = NetworkHelper(url: occupationUrl);
    var reply = await networkHelper.postData({});

    if (reply['status'] == 1) {
      occupationList.clear();
      for (int i = 0; i < reply['data'].length; i++) {
        occupationList.add(
          OccupationModel(
            id: reply['data'][i]['id'],
            title: reply['data'][i]['title'],
          ),
        );
        update();
      }
    } else {
      print('Error in getting occupation list');
    }
  }

  //
  //
  //
  //  Update Profile
  void updateProfile(
      context, fullName, employer, occupation, phone, email) async {
    final NetworkHelper networkHelper = NetworkHelper(url: updateProfileUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id.toString(),
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'occupation_id': occupation,
      'employer': employer,
    });

    if (reply['status'] == 1) {
      userInfoController.getUserInfo().then((value) {
        Get.to(() => const AccountInfoScreen());
        Fluttertoast.showToast(
          msg: S.of(context).profileUpdatedSuccessfully,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.green,
        );
      });
    } else {
      print('Profile update failed');
    }
  }
}
