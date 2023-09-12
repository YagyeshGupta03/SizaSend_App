import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/util/widgets/login_button.dart';
import 'package:savo/util/widgets/text_field.dart';
import '../../Controllers/walllet_controller.dart';

class WithdrawMoneyScreen extends StatefulWidget {
  const WithdrawMoneyScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawMoneyScreen> createState() => _WithdrawMoneyScreenState();
}

class _WithdrawMoneyScreenState extends State<WithdrawMoneyScreen> {
  final _amount = TextEditingController();
  final WalletController _walletController =
  Get.put(WalletController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                  cont: _amount,
                  title: 'Amount',
                  icon: const SizedBox(),
                  fieldLabel: 'Amount',
                  keyboard: TextInputType.number,
                  fillColor: themeController.currentTheme.value.cardColor,
                  hintText: 'Enter Amount in USD'),
              const SizedBox(height: 25),
              LoginButton(
                  onTap: () {
                    if(_amount.text.isNotEmpty){
                      _walletController.withdrawMoney(_amount.text);
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Enter the amount',
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  title: 'Withdraw Money',
                  txtColor: Colors.white,
                  btnColor: primaryColor)
            ],
          ),
        ),
      ),
    );
  }
}


