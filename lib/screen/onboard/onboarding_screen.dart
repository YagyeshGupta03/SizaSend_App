import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:savo/Constants/sizes.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/authentication/login_screen.dart';
import 'package:savo/screen/authentication/sign_up_screen.dart';
import '../../generated/l10n.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void requestNotificationPermissions() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // User granted permission
    } else {
      // User denied permission
    }
  }

  @override
  void initState() {
    super.initState();
    requestNotificationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: Lottie.asset("assets/lottie/onboard.json")),
            Center(
              child: Text(
                S.of(context).letsGetStarted,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    fontSize: 26),
              ),
            ),
            SizedBox(
              height: screenHeight(context) * .005,
            ),
            Text(
              S.of(context).signUpOrLoginIntoToHaveAFullDigital,
              style: themeController.currentTheme.value.textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: screenHeight(context) * .04,
            ),
            ElevatedButton(
                onPressed: () {
                  credentialController.setOnBoard('1');
                  Get.off(() => const LoginScreen());
                },
                child: Text(
                  S.of(context).getStarted,
                  style: const TextStyle(color: Colors.white),
                )),
            SizedBox(
              height: screenHeight(context) * .02,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  style: themeController
                      .currentTheme.value.textTheme.displayMedium,
                  children: <TextSpan>[
                    TextSpan(
                      text: "${S.of(context).dontHaveAnAccount}  ",
                    ),
                    TextSpan(
                        text: S.of(context).signUp,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            credentialController.setOnBoard('1');
                            Get.to(() => const SignUpScreen());
                          },
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: buttonColor)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight(context) * .048,
            ),
          ],
        ),
      ),
    );
  }
}
