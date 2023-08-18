import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/login_controller.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';
import '../../generated/l10n.dart';
import '../../util/widgets/login_button.dart';
import '../../util/widgets/text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final LoginController _loginController = Get.put(LoginController());
  final _oldPass = TextEditingController();
  final _newPass = TextEditingController();
  final _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).changePassword,
          style: themeController.currentTheme.value.textTheme.displaySmall,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                  cont: _oldPass,
                  hintText: 'Enter existing password',
                  title: 'Old Password',
                  icon: const SizedBox(),
                  fieldLabel: 'Name',
                  keyboard: TextInputType.text,
                  fillColor: themeController.currentTheme.value.cardColor),
              const SizedBox(height: 15),
              CustomTextField(
                  cont: _newPass,
                  title: 'New Password',
                  hintText: 'Enter new password',
                  icon: const SizedBox(),
                  fieldLabel: 'Name',
                  keyboard: TextInputType.text,
                  fillColor: themeController.currentTheme.value.cardColor),
              const SizedBox(height: 15),
              CustomTextField(
                  cont: _confirmPass,
                  title: 'Confirm Password',
                  hintText: 'Confirm your password',
                  icon: const SizedBox(),
                  fieldLabel: 'Name',
                  keyboard: TextInputType.text,
                  fillColor: themeController.currentTheme.value.cardColor),
              const SizedBox(height: 20),
              LoginButton(
                  onTap: () {
                    if (_oldPass.text.isNotEmpty &&
                        _newPass.text.isNotEmpty &&
                        _confirmPass.text.isNotEmpty) {
                      if (_newPass.text == _confirmPass.text) {
                        _loginController.changePassword(context, _oldPass.text,
                            _newPass.text, _confirmPass.text);
                      } else {
                        Fluttertoast.showToast(
                          msg: S.of(context).passwordConfirmationDoesNotMatch,
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.red,
                        );
                      }
                    } else {
                      Fluttertoast.showToast(
                        msg: S.of(context).kindlyFillAllTheFields,
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  title: 'Save',
                  txtColor: Colors.white,
                  btnColor: primaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
