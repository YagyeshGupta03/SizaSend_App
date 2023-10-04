import 'package:get/get.dart';
import 'package:savo/screen/dashboard_screen.dart';
import 'package:savo/screen/home/home_screen.dart';
import 'package:savo/screen/onboard/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/authentication/login_screen.dart';
import 'global_controllers.dart';

class CredentialController extends GetxController {
  String? id;
  String? fcmToken;
  String? onBoard;
  String? amount;

  //Login credentials
  setData(userID, token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userID);
    await prefs.setString('fcm_token', token);
    id = prefs.getString('user_id');
    fcmToken = prefs.getString('fcm_token');
    update();
  }

  //
  //
  //
  setOnBoard(onboard) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('onboard', onboard);
    onBoard = prefs.getString('onboard');
    update();
  }
  //
  //
  //
  setWithdraw(money) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('amount', money);
    amount = prefs.getString('amount');
    update();
  }
  //
  //
  //
  getData(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('user_id') ?? "";
    fcmToken = prefs.getString('fcm_token') ?? '';
    onBoard = prefs.getString('onboard') ?? '';
    loadingController.updateDispatchLoading(false);
    loadingController.updateProfileLoading(false);
    loadingController.updateVideoCompressionLoading(false);
    loadingController.updateLoading(false);

    if (id == "") {
      if (onBoard == '') {
        Get.off(() => const OnBoardingScreen());
      } else {
        Get.off(() => const LoginScreen());
      }
    } else {
      userInfoController.getUserInfo().then((value) {
        Get.off(() => const DashBoardScreen());
      });
    }
  }

  //
  //
  //
  deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', '');
    await prefs.setString('fcm_token', '');
    id = prefs.getString('id') ?? "";
    fcmToken = prefs.getString('fcm_token') ?? "";
    update();
  }

  //
  //
  //
  deleteWithdraw() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('amount', '');
    amount = prefs.getString('amount') ?? "";
    update();
  }
  //
  //
  //
  void refreshData() async {
    if (id != null) {
      Get.to(() => const HomeScreen());
    } else {
      Get.to(() => const LoginScreen());
    }
  }
}
