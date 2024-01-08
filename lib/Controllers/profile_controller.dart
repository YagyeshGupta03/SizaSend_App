import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:savo/Constants/all_urls.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Models/Models.dart';
import 'package:savo/screen/profile/UserAccountScreens/account_info_screen.dart';
import '../Helper/http_helper.dart';
import '../generated/l10n.dart';
import '../screen/profile/BankAccount_screens/bank_account_listing.dart';

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
      Dialogs.materialDialog(
          msg:
          'Account added successfully',
          title: "Success",
          titleAlign: TextAlign.center,
          color: Colors.white,
          context: context,
          actions: [
            IconsButton(
              onPressed: () {
                Get.back();
                Get.to(() => const BankListingScreen());
              },
              text: 'Go back',
              color: primaryColor,
              textStyle:
              const TextStyle(color: Colors.white),
            ),
          ]);
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
  //  Add bank account
  void addBankAcForWithdraw(context, fullName, bankName, ifsc, account) async {
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
      Dialogs.materialDialog(
          msg:
          'Account added successfully',
          title: "Success",
          titleAlign: TextAlign.center,
          color: Colors.white,
          context: context,
          actions: [
            IconsButton(
              onPressed: () {
                Get.back();
                Get.to(() => const BankListWithdraw());
              },
              text: 'Go back',
              color: primaryColor,
              textStyle:
              const TextStyle(color: Colors.white),
            ),
          ]);
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

    bankList.clear();
    if (reply['status'] == 1) {
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
      Get.back();
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

    userInfoController
        .getUserInfo();
    if (reply['status'] == 1) {
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
