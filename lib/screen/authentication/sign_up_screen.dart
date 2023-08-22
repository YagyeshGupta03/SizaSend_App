import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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
  var codeOfCountry = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(S.of(context).createAnAccount,
                    style: themeController
                        .currentTheme.value.textTheme.displayLarge),
              ),
              Text(
                S
                    .of(context)
                    .loremIpsumDolorSitAmetConsecteturAdipiscingElitSedDo,
                style:
                    themeController.currentTheme.value.textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                topTitle: S.of(context).fullName,
                keyboardType: TextInputType.name,
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
                    favorite: ['+91', 'FR'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                ),
                suffixWidget: const SizedBox(),
              ),
              SizedBox(height: screenHeight(context) * .015),
              CustomTextFormField(
                topTitle: S.of(context).password,
                keyboardType: TextInputType.visiblePassword,
                cont: _password,
                prefixWidget: Icon(
                  Icons.lock_outline,
                  color: themeController.currentTheme.value.iconTheme.color,
                ),
                suffixWidget: const SizedBox(),
              ),
              SizedBox(height: screenHeight(context) * .015),
              CustomTextFormField(
                topTitle: S.of(context).confirmPassword,
                keyboardType: TextInputType.visiblePassword,
                cont: _confirmPassword,
                prefixWidget: Icon(
                  Icons.lock_outline,
                  color: themeController.currentTheme.value.iconTheme.color,
                ),
                suffixWidget: const SizedBox(),
              ),
              SizedBox(height: screenHeight(context) * .033),
              ElevatedButton(
                  onPressed: () {
                    if (_fullName.text.isNotEmpty &&
                        _phone.text.isNotEmpty &&
                        _password.text.isNotEmpty &&
                        _confirmPassword.text.isNotEmpty) {
                      if (_password.text == _confirmPassword.text) {
                        _loginController.signUp(context, _fullName.text, _phone.text,
                            _password.text, codeOfCountry);
                      } else {
                        Fluttertoast.showToast(
                          msg: S.of(context).confirmPasswordDoesNotMatch,
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.red,
                        );
                      }
                    } else {
                      Fluttertoast.showToast(
                        msg: S.of(context).fillTheMandatoryFields,
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  child: Text(
                    S.of(context).signUp,
                    style: const TextStyle(color: Colors.white),
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
                             Get.to(()=> const LoginScreen());
                            },
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: buttonColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
