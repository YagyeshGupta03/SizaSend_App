import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:savo/util/widgets/widget.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';
import '../../Controllers/quotation_controller.dart';
import '../../Controllers/walllet_controller.dart';
import '../../util/widgets/login_button.dart';
import '../WalletScreens/add_total_money_screen.dart';

class QuotationBillingScreen extends StatefulWidget {
  const QuotationBillingScreen({super.key});

  @override
  State<QuotationBillingScreen> createState() => _QuotationBillingScreenState();
}

class _QuotationBillingScreenState extends State<QuotationBillingScreen> {
  final WalletController _walletController = Get.put(WalletController());
  final QuotationController _quotationController =
      Get.put(QuotationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text('Total payment',
                            style: themeController
                                .currentTheme.value.textTheme.headlineLarge)),
                    const SizedBox(height: 20),
                    TotalAmountTile(
                        value: convertToCurrency(_quotationController.itemCost),
                        title: 'Cost of item'),
                    TotalAmountTile(
                        value: convertToCurrency(
                            _quotationController.courierCharges),
                        title: 'Courier charges'),
                    TotalAmountTile(
                        value: convertToCurrency(
                            _quotationController.adminCharges),
                        title: 'Sizasend charges'),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),
                    TotalAmountTile(
                        value: convertToCurrency(_quotationController.price),
                        title: 'Total payment'),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: LoginButton(
                          onTap: () {
                            Dialogs.materialDialog(
                                msg: 'Do you want to pay for this quotation?',
                                msgAlign: TextAlign.center,
                                title: "Pay",
                                color: Colors.white,
                                titleAlign: TextAlign.center,
                                context: context,
                                actions: [
                                  IconsOutlineButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    text: 'Cancel',
                                    iconData: Icons.cancel_outlined,
                                    textStyle:
                                        const TextStyle(color: Colors.grey),
                                    iconColor: Colors.grey,
                                  ),
                                  IconsButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      _walletController.quotationPay(
                                          _quotationController.price,
                                          _quotationController.senderId,
                                          _quotationController.orderId,
                                          _quotationController.productName);
                                    },
                                    text: 'Pay',
                                    color: primaryColor,
                                    textStyle:
                                        const TextStyle(color: Colors.white),
                                    iconColor: Colors.white,
                                  ),
                                ]);
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
