import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/all_urls.dart';
import '../Constants/theme_data.dart';
import '../Helper/http_helper.dart';
import 'global_controllers.dart';


class ThemeController extends GetxController {
  var currentTheme = lightTheme.obs; // Initialize with the default theme

  void setTheme(ThemeData theme) {
    currentTheme.value = theme;
  }
}
//
//
//
class UserInfoController extends GetxController{

  String fullName = '';
  String phone = '';
  String countryCode = '';
  String profileImage = '';
  String occupation = '';
  String employer = '';
  String email = '';


  Future getUserInfo() async {
    final NetworkHelper networkHelper = NetworkHelper(url: userInfoUrl);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
    });

    fullName = '';
    phone = '';
    countryCode = '';
    profileImage = '';
    occupation = '';
    employer = '';
    email = '';

    if (reply['status'] == 1) {
     fullName = reply['data']['full_name'];
     phone = reply['data']['phone'];
     countryCode = reply['data']['country_code'];
     profileImage = reply['data']['profile_image']??'';
     employer = reply['data']['employer']??'';
     occupation = reply['data']['occupation_name']??'';
     email = reply['data']['email']??'';
      update();
    } else {
      print('Error in getting user details');
    }
  }
}
//
//
//
class LoadingController extends GetxController {
  RxBool loading = false.obs;

  updateLoading(val) {
    loading.value = val;
    update();
  }
}
