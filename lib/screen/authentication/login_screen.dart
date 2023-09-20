// ignore_for_file: use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:savo/Constants/sizes.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/authentication/forgot_screen.dart';
import 'package:savo/screen/authentication/sign_up_screen.dart';
import 'package:savo/util/widgets/text_field.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/login_controller.dart';
import '../../generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String fcmToken = '';
class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = Get.put(LoginController());
  bool rememberMe = false;
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(S.of(context).welcomeBack,
                      style: themeController
                          .currentTheme.value.textTheme.displayLarge),
                ),
                const SizedBox(height: 10),
                Text(
                  S
                      .of(context)
                      .loremIpsumDolorSitAmetConsecteturAdipiscingElitSedDo,
                  style:
                      themeController.currentTheme.value.textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  topTitle: S.of(context).phoneNo,
                  fieldLabel: 'Number',
                  cont: _phone,
                  suffixWidget: const SizedBox(),
                  prefixWidget: Icon(
                    Icons.phone,
                    color: themeController.currentTheme.value.iconTheme.color,
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: screenHeight(context) * .015),
                CustomTextFormField(
                  topTitle: S.of(context).password,
                  fieldLabel: 'password',
                  cont: _password,
                  suffixWidget: const SizedBox(),
                  prefixWidget: Icon(
                    Icons.lock_outline,
                    color: themeController.currentTheme.value.iconTheme.color,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(
                  height: screenHeight(context) * .02),
                Row( mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Checkbox(
                    //     value: rememberMe,
                    //     onChanged: (value) {
                    //       rememberMe = value!;
                    //       setState(() {});
                    //     }),
                    // Text(S.of(context).rememberMe,
                    //     style: themeController
                    //         .currentTheme.value.textTheme.displayMedium),
                    // const Spacer(),
                    TextButton(
                        onPressed: () {
                          Get.to(()=> const ForgotScreen());
                        },
                        child: Text(S.of(context).forgotPassword))
                  ],
                ),
                SizedBox(height: screenHeight(context) * .033),
                ElevatedButton(
                    onPressed: () async {
                      if(_phone.text.isNotEmpty && _password.text.isNotEmpty){
                        connectivityController.connectedLogin(context);
                        fcmToken = await _firebaseMessaging.getToken() ?? '';
                        print(fcmToken);
                        _loginController.login(context, _phone.text, _password.text, fcmToken.toString());
                      } else {
                        Fluttertoast.showToast(
                          msg: "Fill all the fields",
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    child: Text(
                      S.of(context).login,
                      style: const TextStyle(color: Colors.white),
                    ),
                ),
                SizedBox(height: screenHeight(context) * .015),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: "${S.of(context).dontHaveAnAccount}  ",
                            style: themeController
                                .currentTheme.value.textTheme.displayMedium),
                        TextSpan(
                            text: S.of(context).signUp,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                                Get.to(()=> const SignUpScreen());
                              },
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: buttonColor)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
          Obx(
                () => loadingController.loading.value
                ? Center(
              child: Container(
                height: screenHeight(context),
                width: screenWidth(context),
                color: Colors.black12,
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: primaryColor,
                  size: 50,
                ),
              ),
            )
                : const SizedBox(),
          ),]
      ),
    );
  }
}
