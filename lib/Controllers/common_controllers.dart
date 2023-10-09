import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/all_urls.dart';
import '../Constants/theme_data.dart';
import '../Helper/http_helper.dart';
import '../Models/models.dart';
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
class UserInfoController extends GetxController {
  String fullName = '';
  String phone = '';
  String countryCode = '';
  RxString profileImage = ''.obs;
  String occupation = '';
  String employer = '';
  String email = '';
  String balance = '';

  Future getUserInfo() async {
    final NetworkHelper networkHelper = NetworkHelper(url: userInfoUrl);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id.toString(),
    });

    fullName = '';
    phone = '';
    countryCode = '';
    profileImage.value = '';
    occupation = '';
    employer = '';
    email = '';
    balance = '';

    if (reply['status'] == 1) {
      fullName = reply['data']['full_name'];
      phone = reply['data']['phone'];
      countryCode = reply['data']['country_code'];
      balance = reply['data']['balance'];
      profileImage.value = reply['data']['profile_image'] ?? '';
      employer = reply['data']['employer'] ?? '';
      occupation = reply['data']['occupation_name'] ?? '';
      email = reply['data']['email'] ?? '';
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
  RxBool profileLoading = false.obs;
  RxBool videoCompressionLoad = false.obs;
  RxBool dispatchLoad = false.obs;
  RxBool payLoad = false.obs;
  RxBool contactLoad = false.obs;

  updateContactLoading(val) {
    contactLoad.value = val;
    update();
  }

  updateLoading(val) {
    loading.value = val;
    update();
  }

  updateDispatchLoading(val) {
    dispatchLoad.value = val;
    update();
  }

  updatePayLoading(val) {
    payLoad.value = val;
    update();
  }

  updateProfileLoading(val) {
    profileLoading.value = val;
    update();
  }

  updateVideoCompressionLoading(val) {
    videoCompressionLoad.value = val;
    update();
  }
}

//
//
//
class BuyerInfoController extends GetxController {
  RxList<BuyerModel> buyerList = <BuyerModel>[].obs;
  void getBuyerData() async {
    final NetworkHelper networkHelper = NetworkHelper(url: buyerListUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id.toString(),
    });

    buyerList.clear();
    if (reply['status'] == 1) {
      for (int i = 0; i < reply['data'].length; i++) {
        buyerList.add(
            BuyerModel(
            receiverId: reply['data'][i]['receiver_id'],
            fullName: reply['data'][i]['full_name'],
            phone: reply['data'][i]['phone'],
            email: reply['data'][i]['email'] ?? '',
            image: reply['data'][i]['profile_image'] ?? ''));
        update();
      }
    } else {
      loadingController.updateLoading(false);
    }
  }
}
