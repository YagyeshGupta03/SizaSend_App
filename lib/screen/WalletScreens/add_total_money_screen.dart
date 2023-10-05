import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/util/widgets/login_button.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';
import '../../Controllers/walllet_controller.dart';

class AddTotalMoneyScreen extends StatelessWidget {
  const AddTotalMoneyScreen(
      {super.key,
      required this.amount,
      required this.type,
      required this.charges, required this.transactionGateway, required this.status});

  final String amount;
  final String type;
  final String transactionGateway;
  final String charges;
  final bool status;

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.put(WalletController());
    double price = double.parse(amount)+ double.parse(charges);
    String finalPrice = price.toStringAsFixed(1);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
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
                        child: Text('Add to wallet',
                            style: themeController
                                .currentTheme.value.textTheme.headlineLarge)),
                    const SizedBox(height: 20),
                    TotalAmountTile(value: amount, title: 'Amount to add'),
                    TotalAmountTile(value: transactionGateway, title: 'Transaction type'),
                    TotalAmountTile(
                        value: '+ $charges', title: 'Transaction charges'),
                    TotalAmountTile(
                        value: finalPrice,
                        title: 'Total amount'),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: LoginButton(
                          onTap: () {
                            walletController.webOpen(finalPrice, status, type, amount);
                          },
                          title: 'Proceed to pay',
                          txtColor: Colors.white,
                          btnColor: primaryColor),
                    )
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

class TotalAmountTile extends StatelessWidget {
  const TotalAmountTile({
    super.key,
    required this.value,
    required this.title,
  });

  final String value;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: themeController.currentTheme.value.textTheme.titleSmall),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: primaryColor)),
        ],
      ),
    );
  }
}
