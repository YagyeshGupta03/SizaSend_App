import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Controllers/login_controller.dart';
import 'package:savo/screen/profile/GeneralSettings/terms_and_conditions.dart';
import 'package:savo/screen/profile/UserAccountScreens/account_info_screen.dart';

class GeneralSettings extends StatefulWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  final LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
            style: themeController.currentTheme.value.textTheme.bodyMedium),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileListTile(
                title: 'Language',
                value: 'English',
              ),
              const ProfileListTile(
                title: 'Currency',
                value: 'USD',
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  _loginController.termsAndConditions();
                  Get.to(() => const TermsAndConditionsScreen());
                },
                child: const Text(
                  'Terms and Conditions',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: primaryColor),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  _loginController
                      .privacyPolicy()
                      .whenComplete(() => Get.to(() => const PrivacyPolicy()));
                },
                child: const Text(
                  'Privacy Policies',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
