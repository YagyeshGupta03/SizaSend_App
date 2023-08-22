import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/theme_data.dart';
import '../../../Controllers/global_controllers.dart';
import '../../../Controllers/login_controller.dart';
import '../../../generated/l10n.dart';

class TermsAndConditonsScreen extends StatelessWidget {
  const TermsAndConditonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.put(LoginController());
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
                data: _loginController.description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
