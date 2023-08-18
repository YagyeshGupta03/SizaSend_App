import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/dashboard_screen.dart';
import 'package:savo/screen/home/home_screen.dart';
import 'package:savo/screen/profile/profile_home_screen.dart';
import '../Constants/all_urls.dart';
import '../Helper/http_helper.dart';

class LoginController extends GetxController {

  //
  //
  //
  Future signUp(context, fullName, phone, password, countryCode) async {
    final NetworkHelper networkHelper = NetworkHelper(url: signupURl);

    var reply = await networkHelper.postData({
      "full_name": fullName,
      "phone": phone,
      "password": password,
      "country_code": countryCode,
    });
    if (reply['status'] == 1) {
      await credentialController.setData(reply['data']['id']);
      userInfoController.getUserInfo().then((value) {
        Get.off(()=> const DashBoardScreen());
      });
      Fluttertoast.showToast(
        msg: "${reply['message']}",
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
        // textColor: Colors.white,
      );
    } else {
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
  Future login (context, phone, password) async {
    final NetworkHelper networkHelper = NetworkHelper(url: loginUrl);
    var reply = await networkHelper.postData({
      "phone": phone,
      "password": password,
    });
    
    if (reply['status'] == 1) {
      await credentialController.setData(reply['data']['id']);
      userInfoController.getUserInfo().then((value) {
        Get.off(()=> const DashBoardScreen());
      });
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
  Future changePassword (context, oldPass, newPass, confirmPass) async {
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
}