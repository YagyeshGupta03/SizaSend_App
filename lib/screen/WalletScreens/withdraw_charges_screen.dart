import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/screen/WalletScreens/withdraw_money_screen.dart';
import 'package:savo/util/widgets/login_button.dart';
import 'package:savo/util/widgets/widget.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';

class WithdrawChargesScreen extends StatelessWidget {
  const WithdrawChargesScreen(
      {super.key,
      required this.withdrawAmount,
      required this.charges,
      required this.bankName,
      required this.status,
      required this.acNumber,
      required this.ifsc});

  final String withdrawAmount;
  final String charges;
  final String bankName;
  final String status;
  final String acNumber;
  final String ifsc;

  @override
  Widget build(BuildContext context) {
    double chargeAmount =
        (double.parse(withdrawAmount) / 100) * double.parse(charges);
    double remainAmount = double.parse(withdrawAmount) - chargeAmount;
    String finalAmount = remainAmount.toStringAsFixed(1);

    statusManagement(val) {
      if (val == 'Accept') {
        return 'Approved';
      } else if (val == 'Reject') {
        return 'Rejected';
      } else if (val == 'Pending') {
        return 'Pending';
      } else {
        return 'Pending';
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text('Withdrawal request',
                            style: themeController
                                .currentTheme.value.textTheme.headlineLarge)),
                    const SizedBox(height: 10),
                    Center(
                        child: Text(statusManagement(status),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: status == 'Accept'
                                    ? Colors.green
                                    : primaryColor))),
                    const SizedBox(height: 30),
                    // WithdrawAmountTile(value: status, title: 'Status'),
                    WithdrawAmountTile(
                        value: bankName, title: 'Bank', status: status),
                    WithdrawAmountTile(
                        value: acNumber,
                        title: 'Account number',
                        status: status),
                    WithdrawAmountTile(
                        value: ifsc, title: 'IFSC code', status: status),
                    WithdrawAmountTile(
                        value: convertToCurrency(withdrawAmount),
                        title: 'Amount requested',
                        status: status),
                    WithdrawAmountTile(
                        value: '$charges%',
                        title: 'Transaction charges',
                        status: status),
                    const SizedBox(height: 10),
                    const Divider(),
                    WithdrawAmountTile(
                        value: convertToCurrency(finalAmount),
                        title: 'Withdrawal Amount',
                        status: status),
                    const SizedBox(height: 45),
                    LoginButton(
                        onTap: () {
                          Get.to(()=> const WithdrawMoneyScreen());
                        },
                        title: 'Go Back',
                        txtColor: Colors.white,
                        btnColor: primaryColor),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WithdrawAmountTile extends StatelessWidget {
  const WithdrawAmountTile({
    super.key,
    required this.value,
    required this.title,
    required this.status,
  });

  final String value;
  final String title;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: themeController.currentTheme.value.textTheme.bodyLarge),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: status == 'Accept' ? Colors.green : primaryColor)),
        ],
      ),
    );
  }
}
