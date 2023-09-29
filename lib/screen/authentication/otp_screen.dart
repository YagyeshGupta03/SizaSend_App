import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:savo/screen/authentication/login_screen.dart';
import 'package:savo/screen/authentication/new_password_screen.dart';
import '../../Constants/sizes.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';
import '../../generated/l10n.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen(
      {super.key,
      required this.verifyId,
      required this.userId});

  final String verifyId;
  final String userId;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool rememberMe = false;
  String currentText = "";
  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              loadingController.updateLoading(false);
              Get.to(() => const LoginScreen());
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: s.height * .05,
                ),
                Center(
                  child: Text(
                    S.of(context).enterYourOtp,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Text(
                  S.of(context).enterTheOtpCodeWeSentYou,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: s.height * .05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 61,
                      fieldWidth: 48,
                      activeFillColor: const Color(0xffF7F8FB),
                      selectedColor: const Color(0xffF7F8FB),
                      inactiveFillColor: const Color(0xffF7F8FB),
                      selectedFillColor: const Color(0xffF7F8FB),
                      inactiveColor: const Color(0xffF7F8FB),
                      activeColor: const Color(0xffF7F8FB),
                      disabledColor: const Color(0xffF7F8FB),
                      errorBorderColor: const Color(0xffF7F8FB),
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    // backgroundColor: Colors.blue.shade50,
                    enableActiveFill: true,
                    controller: textEditingController,
                    onCompleted: (v) {
                    },
                    onChanged: (value) {
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                    appContext: context,
                  ),
                ),
                SizedBox(
                  height: s.height * .1,
                ),
                ElevatedButton(
                    onPressed: () async {
                      loadingController.updateLoading(true);
                      try {
                        String smsCode = currentText;
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: widget.verifyId,
                                smsCode: smsCode);
                        await FirebaseAuth.instance
                            .signInWithCredential(credential)
                            .then((value) => Get.to(() =>
                                const NewPasswordScreen()));
                        loadingController.updateLoading(false);
                      } catch (e) {
                        Fluttertoast.showToast(
                          msg: 'Invalid OTP',
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.red,
                        );
                        loadingController.updateLoading(false);
                      }
                    },
                    child: Text(
                      S.of(context).submit,
                      style: const TextStyle(color: Colors.white),
                    )),
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
        ),
      ]),
    );
  }
}
