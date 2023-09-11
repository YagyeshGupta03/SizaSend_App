import 'package:get/get.dart';
import 'package:savo/screen/dashboard_screen.dart';
import 'package:savo/screen/home/home_screen.dart';
import 'package:savo/screen/onboard/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/authentication/login_screen.dart';
import 'global_controllers.dart';


class CredentialController extends GetxController{

  String? id;


  //Login credentials
  setData(userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userID);
    id = prefs.getString('user_id');
    update();
  }
  //
  //
  //
   getData(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('user_id') ?? "";

    if(id == ""){
      Get.off(()=> const OnBoardingScreen());
    } else {
      userInfoController.getUserInfo().then((value) {
        Get.off(()=> const DashBoardScreen());
      });
    }
  }
  //
  //
  //
   deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', '');
    id = prefs.getString('id')?? "";
    update();
  }

  //
  //
  //
  void refreshData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (id != null) {
     Get.to(()=> const HomeScreen());
    } else {
      Get.to(() => const LoginScreen());
    }
  }

}

