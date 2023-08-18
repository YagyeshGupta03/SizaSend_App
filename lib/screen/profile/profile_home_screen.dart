import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/authentication/login_screen.dart';
import 'package:savo/screen/profile/BankAccount_screens/bankAc_listing.dart';
import 'package:savo/screen/profile/account_info_screen.dart';
import 'package:savo/screen/profile/change_password_screen.dart';
import '../../generated/l10n.dart';
import '../../util/images.dart';

class ProfileHomeScreen extends StatefulWidget {
  const ProfileHomeScreen({super.key});

  @override
  State<ProfileHomeScreen> createState() => _ProfileHomeScreenState();
}

class _ProfileHomeScreenState extends State<ProfileHomeScreen> {
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
              child: SizedBox(
                height: 10,
                width: 10,
                child: Image.asset('assets/images/profilePic.jpg', fit: BoxFit.fill,),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text("Marvin McKinney"),
          const SizedBox(height: 10),
          const Text("(303) 555-0105"),
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
              image: Images.icLanguage, title: S.of(context).language),
          const SizedBox(height: 20),
          ImageListTile(
              image: Images.icSetting, title: S.of(context).generalSetting),
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
              await credentialController.deleteData();
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
