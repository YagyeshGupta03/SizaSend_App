import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/util/widgets/login_button.dart';
import '../../Controllers/walllet_controller.dart';
import '../profile/UserAccountScreens/account_info_screen.dart';

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen(
      {super.key,
      required this.bankId,
      required this.acName,
      required this.bankName,
      required this.acNumber,
      required this.ifsc,
      required this.amount});

  final String bankId;
  final String acName;
  final String bankName;
  final String acNumber;
  final String ifsc;
  final String amount;

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.put(WalletController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bank Details',
          style: themeController.currentTheme.value.textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileListTile(
                title: 'Account holder name',
                value: acName,
              ),
              ProfileListTile(title: 'Bank name', value: bankName),
              ProfileListTile(
                title: 'Account number',
                value: acNumber,
              ),
              ProfileListTile(
                title: 'IFSC code',
                value: ifsc,
              ),
              const SizedBox(height: 20),
              LoginButton(
                  onTap: () {
                    walletController.withdrawMoney(context, amount, bankId);
                  },
                  title: 'Confirm details',
                  txtColor: Colors.white,
                  btnColor: primaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
