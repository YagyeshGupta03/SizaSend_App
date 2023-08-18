import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Controllers/profile_controller.dart';
import 'package:savo/util/widgets/login_button.dart';
import 'package:savo/util/widgets/text_field.dart';

import '../../../generated/l10n.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({Key? key}) : super(key: key);

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  final BankController _bankController = Get.put(BankController());
  final _fullName = TextEditingController();
  final _bankName = TextEditingController();
  final _ifsc = TextEditingController();
  final _account = TextEditingController();
  final _accountConfirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).addAccount,
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
                  cont: _fullName,
                  hintText: S.of(context).enterName,
                  title: S.of(context).yourName,
                  icon: const SizedBox(),
                  fieldLabel: 'Name',
                  keyboard: TextInputType.text,
                  fillColor: themeController.currentTheme.value.cardColor),
              const SizedBox(height: 15),
              CustomTextField(
                  cont: _bankName,
                  title: S.of(context).bankName,
                  hintText: S.of(context).enterBankName,
                  icon: const SizedBox(),
                  fieldLabel: 'Name',
                  keyboard: TextInputType.text,
                  fillColor: themeController.currentTheme.value.cardColor),
              const SizedBox(height: 15),
              CustomTextField(
                  cont: _ifsc,
                  title: S.of(context).ifscCode,
                  hintText: S.of(context).ifscCode,
                  icon: const SizedBox(),
                  fieldLabel: 'Name',
                  keyboard: TextInputType.text,
                  fillColor: themeController.currentTheme.value.cardColor),
              const SizedBox(height: 15),
              CustomTextField(
                  cont: _account,
                  title: S.of(context).accountNumber,
                  hintText: S.of(context).enterAccountNumber,
                  icon: const SizedBox(),
                  fieldLabel: '',
                  keyboard: TextInputType.number,
                  fillColor: themeController.currentTheme.value.cardColor),
              const SizedBox(height: 15),
              CustomTextField(
                  cont: _accountConfirm,
                  title: S.of(context).confirmAccountNumber,
                  hintText: S.of(context).confirmAccountNumber,
                  icon: const SizedBox(),
                  fieldLabel: '',
                  keyboard: TextInputType.number,
                  fillColor: themeController.currentTheme.value.cardColor),
              const SizedBox(height: 20),
              LoginButton(
                  onTap: () {
                    if (_fullName.text.isNotEmpty &&
                        _bankName.text.isNotEmpty &&
                        _account.text.isNotEmpty &&
                        _accountConfirm.text.isNotEmpty &&
                        _ifsc.text.isNotEmpty) {
                      if (_account.text == _accountConfirm.text) {
                        _bankController.addBankAc(context, _fullName.text,
                            _bankName.text, _ifsc.text, _account.text);
                      } else {
                        Fluttertoast.showToast(
                          msg: S.of(context).accountConfirmationDoesNotMatch,
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.red,
                        );
                      }
                    }
                    else {
                      Fluttertoast.showToast(
                        msg: S.of(context).kindlyFillAllTheFields,
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  title: S.of(context).addAccount,
                  txtColor: Colors.white,
                  btnColor: primaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
