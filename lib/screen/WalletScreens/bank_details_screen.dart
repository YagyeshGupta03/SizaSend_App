import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/util/widgets/login_button.dart';
import 'package:savo/util/widgets/widget.dart';
import '../../Controllers/walllet_controller.dart';

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen(
      {super.key,
      required this.bankId,
      required this.acName,
      required this.bankName,
      required this.acNumber,
      required this.ifsc});

  final String bankId;
  final String acName;
  final String bankName;
  final String acNumber;
  final String ifsc;

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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BankListTile(
                title: 'Account holder name',
                value: acName,
              ),
              BankListTile(title: 'Bank name', value: bankName),
              BankListTile(
                title: 'Account number',
                value: acNumber,
              ),
              BankListTile(
                title: 'IFSC code',
                value: ifsc,
              ),
              BankListTile(
                title: 'Withdrawal amount',
                value: convertToCurrency(credentialController.amount.toString()),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LoginButton(
                    onTap: () {
                      walletController.withdrawMoney(context, bankId);
                    },
                    title: 'Confirm details',
                    txtColor: Colors.white,
                    btnColor: primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
//
//
//
//
class BankListTile extends StatelessWidget {
  final String title;
  final String? value;

  const BankListTile({super.key, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: themeController.currentTheme.value.textTheme.titleSmall,
      ),
      trailing: Text(
        value ?? "",
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: primaryColor),
      ),
    );
  }
}