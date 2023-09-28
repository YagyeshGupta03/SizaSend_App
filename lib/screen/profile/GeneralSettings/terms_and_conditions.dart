import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/theme_data.dart';
import '../../../Controllers/global_controllers.dart';
import '../../../Controllers/login_controller.dart';
import '../../../generated/l10n.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor.withOpacity(0.25),
        title: Text(S.of(context).termsAndConditions,
            style: themeController.currentTheme.value.textTheme.bodyMedium),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).ourPolicy,
                style: const TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Html(
                data: loginController.description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor.withOpacity(0.25),
        title: Text('Privacy policy',
            style: themeController.currentTheme.value.textTheme.bodyMedium),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).ourPolicy,
                style: const TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Html(
                data: loginController.privacyDescription,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
