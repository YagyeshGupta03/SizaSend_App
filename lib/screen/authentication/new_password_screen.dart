import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/util/widgets/login_button.dart';
import '../../Controllers/global_controllers.dart';
import '../../Controllers/login_controller.dart';
import '../../util/widgets/text_field.dart';
import 'login_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final LoginController _loginController = Get.put(LoginController());
  final _password = TextEditingController();
  final _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              loadingController.updateLoading(false);
              Get.to(() => const LoginScreen());
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'Enter new password',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: SingleChildScrollView(
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                topTitle: 'Enter new password',
                fieldLabel: 'Password',
                cont: _password,
                suffixWidget: const SizedBox(),
                prefixWidget: Icon(
                  Icons.lock_outline,
                  color: themeController.currentTheme.value.iconTheme.color,
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                topTitle: 'Confirm password',
                fieldLabel: 'Confirm password',
                cont: _confirmPass,
                suffixWidget: const SizedBox(),
                prefixWidget: Icon(
                  Icons.lock_outline,
                  color: themeController.currentTheme.value.iconTheme.color,
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 35),
              LoginButton(
                  onTap: () {
                   if(_password.text.isNotEmpty && _confirmPass.text.isNotEmpty) {
                      if (_password.text == _confirmPass.text) {
                        _loginController.forgotChangePassword(
                            context,
                            _loginController.password,
                            _password.text,
                            _loginController.userrId);
                      } else {
                        Fluttertoast.showToast(
                          msg: "Password confirmation does not match",
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.red,
                        );
                      }
                    }
                   else {
                     Fluttertoast.showToast(
                       msg: "Enter all the fields",
                       gravity: ToastGravity.SNACKBAR,
                       backgroundColor: Colors.red,
                     );
                   }
                  },
                  title: 'Save',
                  txtColor: Colors.white,
                  btnColor: primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
