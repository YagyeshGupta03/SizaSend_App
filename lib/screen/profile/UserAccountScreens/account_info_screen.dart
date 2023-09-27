import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/all_urls.dart';
import 'package:savo/screen/profile/UserAccountScreens/account_edit_screen.dart';
import 'package:savo/util/widgets/edit_image_button.dart';
import '../../../Controllers/global_controllers.dart';
import '../../../Controllers/profile_controller.dart';
import '../../../generated/l10n.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).account,
          style: themeController.currentTheme.value.textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: s.height * 0.029),
              Stack(
                children: [
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: themeController.currentTheme.value.cardColor),
                      padding: const EdgeInsets.all(5),
                      child: Obx(
                        () => userInfoController.profileImage.value == ''
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
                                  '$imageUrl${userInfoController.profileImage.value}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 80, bottom: 20),
                        child: EditImageButton(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                S.of(context).personalInfo,
                style: themeController.currentTheme.value.textTheme.titleMedium,
              ),
              ProfileListTile(
                title: S.of(context).yourName,
                value: userInfoController.fullName,
              ),
              ProfileListTile(
                title: S.of(context).occupation,
                value: userInfoController.occupation,
              ),
              ProfileListTile(
                title: S.of(context).employer,
                value: userInfoController.employer,
              ),
              SizedBox(
                height: s.height * 0.035,
              ),
              Text(S.of(context).contactInfo,
                  style:
                      themeController.currentTheme.value.textTheme.titleMedium),
              ProfileListTile(
                title: S.of(context).phoneNumber,
                value:
                    '${userInfoController.countryCode}${userInfoController.phone}',
              ),
              ProfileListTile(
                title: S.of(context).email,
                value: userInfoController.email,
              ),
              ElevatedButton(
                onPressed: () {
                  _profileController.getOccupationData();
                  Get.to(() => const AccountEditScreen());
                },
                child: const Text(
                  "Edit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileListTile extends StatelessWidget {
  final String title;
  final String? value;

  const ProfileListTile({super.key, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: themeController.currentTheme.value.textTheme.bodyLarge,
      ),
      trailing: Text(
        value ?? "",
        style: themeController.currentTheme.value.textTheme.displayMedium,
      ),
    );
  }
}
