import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/NotificationScreen/notification_screen.dart';
import 'package:savo/screen/authentication/login_screen.dart';
import 'package:savo/screen/profile/BankAccount_screens/bankAc_listing.dart';
import 'package:savo/screen/profile/GeneralSettings/general_settings.dart';
import 'package:savo/screen/profile/UserAccountScreens/account_info_screen.dart';
import 'package:savo/screen/profile/change_password_screen.dart';
import '../../Constants/all_urls.dart';
import '../../Controllers/login_controller.dart';
import '../../generated/l10n.dart';
import '../../util/images.dart';

class ProfileHomeScreen extends StatefulWidget {
  const ProfileHomeScreen({super.key});

  @override
  State<ProfileHomeScreen> createState() => _ProfileHomeScreenState();
}

class _ProfileHomeScreenState extends State<ProfileHomeScreen> {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeController.currentTheme.value.cardColor),
              padding: const EdgeInsets.all(5),
              child: userInfoController.profileImage == ''
                  ? SizedBox(
                      height: 10,
                      width: 10,
                      child: Image.asset(
                        'assets/images/profilePic.jpg',
                        fit: BoxFit.fill,
                      ),
                    )
                  : SizedBox(
                      height: 10,
                      width: 10,
                      child: Image.network(
                        '$imageUrl${userInfoController.profileImage.toString()}',
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            userInfoController.fullName,
            style: themeController.currentTheme.value.textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Text(
            '${userInfoController.countryCode}${userInfoController.phone}',
            style: themeController.currentTheme.value.textTheme.displaySmall,
          ),

          // List Tiles
          const SizedBox(height: 10),
          ImageListTile(
              onTap: () {
                Get.to(() => const AccountInfoScreen());
              },
              image: Images.icAccountInfo,
              title: S.of(context).accountInfo),
          ImageListTile(
            image: Images.icBank,
            title: S.of(context).bankAccount,
            onTap: () {
              Get.to(() => const BankListingScreen());
            },
          ),
          ImageListTile(
            image: Images.icLanguage,
            title: 'Notification',
            onTap: () {
              Get.to(() => const NotificationScreen());
            },
          ),
          const SizedBox(height: 20),
          ImageListTile(
            image: Images.icSetting,
            title: S.of(context).generalSetting,
            onTap: () {
              Get.to(const GeneralSettings());
            },
          ),
          ImageListTile(
            image: Images.icChangePassword,
            title: S.of(context).changePassword,
            onTap: () {
              Get.to(() => const ChangePasswordScreen());
            },
          ),
          ImageListTile(
            image: Images.icLogout,
            title: S.of(context).logout,
            onTap: () async {
              loadingController.updateVideoCompressionLoading(false);
              loadingController.updateProfileLoading(false);
              loadingController.updateLoading(false);
              await credentialController.deleteData();
              // _loginController.logout(token);
              Get.off(() => const LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}

//
//
//
//
class ImageListTile extends StatefulWidget {
  final String image;
  final String title;
  final Function()? onTap;
  const ImageListTile(
      {super.key, required this.image, required this.title, this.onTap});

  @override
  State<ImageListTile> createState() => _ImageListTileState();
}

class _ImageListTileState extends State<ImageListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: themeController.currentTheme.value.cardColor,
      child: InkWell(
        onTap: () {
          widget.onTap!();
        },
        child: ListTile(
          leading: Image.asset(
            widget.image,
            scale: 3,
          ),
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}
