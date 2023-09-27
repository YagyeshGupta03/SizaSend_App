import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:savo/screen/authentication/login_screen.dart';
import 'package:savo/util/images.dart';
import 'package:savo/util/widgets/text_field.dart';
import '../../Constants/sizes.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';
import '../../Controllers/login_controller.dart';
import '../../generated/l10n.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final LoginController _loginController = Get.put(LoginController());
  bool rememberMe = false;
  final _phone = TextEditingController();
  var codeOfCountry = '+91';

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
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: s.height * .05,
                ),
                Center(
                  child: Text(
                    S.of(context).forgotPassword,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Text(
                  S.of(context).toResetYourPasswordYouNeedYourEmailOrMobile,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                Image.asset(
                  Images.forgotImage,
                  scale: 3,
                ),
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
                      favorite: ['+91', 'FR'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                  ),
                  suffixWidget: false,
                ),
                SizedBox(
                  height: s.height * .02,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_phone.text.isNotEmpty) {
                        _loginController.forgotPassword(
                            context, _phone.text, codeOfCountry);
                      }
                    },
                    child: Text(
                      S.of(context).sendOtp,
                      style: const TextStyle(color: Colors.white),
                    )),
              ],
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
      ),
    );
  }
}
