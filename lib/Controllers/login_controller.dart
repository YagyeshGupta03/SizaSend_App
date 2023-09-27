import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/authentication/success_screen.dart';
import 'package:savo/screen/dashboard_screen.dart';
import '../Constants/all_urls.dart';
import '../Helper/http_helper.dart';
import '../screen/authentication/otp_screen.dart';

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
      "token": credentialController.fcmToken.toString(),
      "user_id": credentialController.id.toString(),
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
      "user_id": credentialController.id.toString(),
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
  //
  //
  //
  //
  String privacyTitle = '';
  String privacyDescription = '';
  Future privacyPolicy() async {
    final NetworkHelper networkHelper = NetworkHelper(url: privacyUrl);
    var reply = await networkHelper.postData({});

    if (reply['status'] == 1) {
      privacyTitle = reply['data']['title'];
      privacyDescription = reply['data']['description'];

      // Navigator.pop(context);
    } else {
      print('error in getting terms and conditons');
    }
  }

  //
  //
  //
  //
  String userrId = '';
  Future forgotPassword(context, contactsToSend, codeOfCountry) async {
    await loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: contactListUrl);
    var reply = await networkHelper.postData({
      'contect_list': contactsToSend,
    });

    if (reply['status'] == 1) {
      userrId = reply['data'][0]['id'];
      await FirebaseAuth.instance
          .verifyPhoneNumber(
            phoneNumber: codeOfCountry.toString() + contactsToSend,
            verificationCompleted: (PhoneAuthCredential credential) {},
            verificationFailed: (FirebaseAuthException e) {
              Fluttertoast.showToast(
                msg: 'Your daily limit exceeded',
                gravity: ToastGravity.SNACKBAR,
                backgroundColor: Colors.red,
              );
            },
            codeSent: (String verificationId, int? resendToken) {
              Get.to(() => OtpScreen(
                  verifyId: verificationId,
                  userId: userrId));
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          )
          .whenComplete(() => loadingController.updateLoading(false));
    } else {
      userrId = '';
      Fluttertoast.showToast(
        msg: "Phone number is not registered",
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
      loadingController.updateLoading(false);
    }
  }

  //
  //
  //
  //
  Future forgotChangePassword(context, newPass, userId) async {
    final NetworkHelper networkHelper = NetworkHelper(url: forgotPasswordUrl);
    var reply = await networkHelper.postData({
      "user_id": userId,
      "password": newPass,
    });

    if (reply['status'] == 1) {
      Get.to(() => const SuccessScreen());
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
  Future adminEnquiry(context, subject, description) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: adminEnquiryUrl);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id.toString(),
      "subject": subject,
      "comments": description,
    });

    if (reply['status'] == 1) {
      Fluttertoast.showToast(
        msg: "Enquiry submitted successfully",
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              'Enquiry submitted successfully',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            content: const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'You will shortly receive a reply on your registered e-mail',
                 style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Home',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                onPressed: () {
                  Get.to(() => const DashBoardScreen());
                },
              ),
            ],
          );
        },
      );
      loadingController.updateLoading(false);
    } else {
      Fluttertoast.showToast(
        msg: "${reply['message']}",
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
      loadingController.updateLoading(false);
    }
  }
}
