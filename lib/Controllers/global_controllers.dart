import 'package:get/get.dart';
import 'package:savo/Controllers/connectivity_controller.dart';
import 'package:savo/Controllers/credential_controller.dart';
import 'common_controllers.dart';


final ThemeController themeController = Get.put(ThemeController());

final CredentialController credentialController = Get.put(CredentialController());

final UserInfoController userInfoController = Get.put(UserInfoController());

final LoadingController loadingController = Get.put(LoadingController());

final ConnectivityController connectivityController = Get.put(ConnectivityController());
