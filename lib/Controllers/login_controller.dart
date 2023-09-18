import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/dashboard_screen.dart';
import '../Constants/all_urls.dart';
import '../Helper/http_helper.dart';

class LoginController extends GetxController {
  //
  //
  //
  Future signUp(context, fullName, phone, password, countryCode, token) async {
    await loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: signupURl);

    var reply = await networkHelper.postData({
      "full_name": fullName,
      "phone": phone,
      "password": password,
      "country_code": countryCode,
      "balance": '0'
    });
    if (reply['status'] == 1) {
      login(context, phone, password, token);
      // await credentialController.setData(reply['data']['id'], token);
      // userInfoController.getUserInfo().then((value) {
      //   loadingController.updateLoading(false);
      //   Get.off(() => const DashBoardScreen());
      // });
      Fluttertoast.showToast(
        msg: "${reply['message']}",
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
        // textColor: Colors.white,
      );
    } else {
      loadingController.updateLoading(false);
      Fluttertoast.showToast(
        msg: "${reply['message']}",
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        // textColor: Colors.white,
      );
    }
  }

  //
  //
  //
  //
  Future login(context, phone, password, token) async {
    await loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: loginUrl);
    var reply = await networkHelper.postData({
      "phone": phone,
      "password": password,
      'token': token,
    });

    if (reply['status'] == 1) {
      await credentialController.setData(reply['data']['id'], token);
      userInfoController.getUserInfo().then((value) {
        loadingController.updateLoading(false);
        Get.off(() => const DashBoardScreen());
      });
    } else {
      Fluttertoast.showToast(
        msg: "${reply['message']}",
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
      loadingController.updateLoading(false);
    }
  }

  //
  //
  //
  Future<bool> logout() async {
    final NetworkHelper networkHelper = NetworkHelper(url: logoutUrl);
    var reply = await networkHelper.postData({
      "token": credentialController.fcmToken,
      "user_id": credentialController.id,
    });

    if (reply['status'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  //
  //
  //
  //
  Future changePassword(context, oldPass, newPass, confirmPass) async {
    final NetworkHelper networkHelper = NetworkHelper(url: changePasswordUrl);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
      "password": oldPass,
      "new_password": newPass,
      "confirm_password": confirmPass,
    });

    if (reply['status'] == 1) {
      Fluttertoast.showToast(
        msg: "${reply['message']}",
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
      );
      Navigator.pop(context);
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
  //
  String title = '';
  String description = '';
  Future termsAndConditions() async {
    final NetworkHelper networkHelper = NetworkHelper(url: termsUrl);
    var reply = await networkHelper.postData({});

    if (reply['status'] == 1) {
      title = reply['data']['title'];
      description = reply['data']['description'];

      // Navigator.pop(context);
    } else {
      print('error in getting terms and conditons');
    }
  }
}
