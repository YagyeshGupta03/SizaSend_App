// ignore_for_file: use_build_context_synchronously

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:savo/Constants/sizes.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Controllers/login_controller.dart';
import 'package:savo/screen/authentication/login_screen.dart';
import 'package:savo/util/widgets/text_field.dart';
import '../../Constants/theme_data.dart';
import '../../generated/l10n.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final LoginController _loginController = Get.put(LoginController());
  final _fullName = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  var codeOfCountry = '+27';
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              loadingController.updateLoading(false);
              Get.to(() => const LoginScreen());
            },
            icon: const Icon(Icons.arrow_back)),
        toolbarHeight: 50,
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
                    child: Text(S.of(context).createAnAccount,
                        style: themeController
                            .currentTheme.value.textTheme.displayLarge),
                  ),
                  // Text(
                  //   S
                  //       .of(context)
                  //       .loremIpsumDolorSitAmetConsecteturAdipiscingElitSedDo,
                  //   style: themeController
                  //       .currentTheme.value.textTheme.displaySmall,
                  //   textAlign: TextAlign.center,
                  // ),
                  const SizedBox(height: 20),
                  FormatterFields(
                    topTitle: S.of(context).fullName,
                    keyboardType: TextInputType.name,
                    formatter: FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z\s-]')),
                    fieldLabel: 'Name',
                    cont: _fullName,
                    suffixWidget: const SizedBox(),
                    prefixWidget: Icon(
                      Icons.person,
                      color: themeController.currentTheme.value.iconTheme.color,
                    ),
                  ),
                  SizedBox(height: screenHeight(context) * .015),
                  CustomTextFormField(
                    topTitle: S.of(context).phoneNo,
                    fieldLabel: 'Number',
                    keyboardType: TextInputType.phone,
                    cont: _phone,
                    prefixWidget: SizedBox(
                      child: CountryCodePicker(
                        onChanged: (countryCode) {
                          setState(() {
                            codeOfCountry = countryCode.toString();
                          });
                        },
                        dialogBackgroundColor:
                            themeController.currentTheme.value.cardColor,
                        initialSelection: '+91',
                        showFlag: false,
                        favorite: const ['+91', 'FR'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                      ),
                    ),
                    suffixWidget: false,
                  ),
                  SizedBox(height: screenHeight(context) * .015),
                  CustomTextFormField(
                    topTitle: S.of(context).password,
                    fieldLabel: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    cont: _password,
                    prefixWidget: Icon(
                      Icons.lock_outline,
                      color: themeController.currentTheme.value.iconTheme.color,
                    ),
                    suffixWidget: true,
                  ),
                  SizedBox(height: screenHeight(context) * .015),
                  CustomTextFormField(
                    topTitle: S.of(context).confirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    fieldLabel: 'Confirm password',
                    cont: _confirmPassword,
                    prefixWidget: Icon(
                      Icons.lock_outline,
                      color: themeController.currentTheme.value.iconTheme.color,
                    ),
                    suffixWidget: true,
                  ),
                  SizedBox(height: screenHeight(context) * .033),
                  ElevatedButton(
                    onPressed: () async {
                      loadingController.updateLoading(true);
                      if (_fullName.text.isNotEmpty &&
                          _phone.text.isNotEmpty &&
                          _password.text.isNotEmpty &&
                          _confirmPassword.text.isNotEmpty) {
                        if (_password.text == _confirmPassword.text) {
                          _loginController.verifySignNumber(
                              context,
                              _phone.text,
                              codeOfCountry,
                              _fullName.text,
                              _password.text);
                        } else {
                          Fluttertoast.showToast(
                            msg: S.of(context).confirmPasswordDoesNotMatch,
                            gravity: ToastGravity.SNACKBAR,
                            backgroundColor: Colors.red,
                          );
                          loadingController.updateLoading(false);
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: S.of(context).fillTheMandatoryFields,
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.red,
                        );
                        loadingController.updateLoading(false);
                      }
                    },
                    child: const Text(
                      'Verify phone number',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: screenHeight(context) * .015),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: themeController
                            .currentTheme.value.textTheme.displaySmall,
                        children: <TextSpan>[
                          TextSpan(
                            text: "${S.of(context).alreadyHaveAnAccountYet}  ",
                          ),
                          TextSpan(
                            text: S.of(context).login,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => const LoginScreen());
                              },
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: buttonColor),
                          ),
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
          ),
        ],
      ),
    );
  }
}
