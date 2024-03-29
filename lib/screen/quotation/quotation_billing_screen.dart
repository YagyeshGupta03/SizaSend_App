import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/util/widgets/widget.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';
import '../../Controllers/quotation_controller.dart';
import '../../util/widgets/login_button.dart';
import '../WalletScreens/add_total_money_screen.dart';

class QuotationBillingScreen extends StatefulWidget {
  const QuotationBillingScreen({super.key});

  @override
  State<QuotationBillingScreen> createState() => _QuotationBillingScreenState();
}

class _QuotationBillingScreenState extends State<QuotationBillingScreen> {
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
