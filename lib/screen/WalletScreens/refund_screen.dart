import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Controllers/walllet_controller.dart';
import 'package:savo/util/widgets/login_button.dart';
import 'package:savo/util/widgets/text_field.dart';

import '../../Controllers/quotation_controller.dart';

class RefundScreen extends StatefulWidget {
  const RefundScreen({super.key});

  @override
  State<RefundScreen> createState() => _RefundScreenState();
}

class _RefundScreenState extends State<RefundScreen> {
  final _refund = TextEditingController();
  final QuotationController _quotationController =
      Get.put(QuotationController());
  final WalletController _walletController = Get.put(WalletController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                  cont: _refund,
                  title: 'Reason',
                  icon: const SizedBox(),
                  fieldLabel: '',
                  keyboard: TextInputType.text,
                  fillColor: themeController.currentTheme.value.cardColor,
                  hintText: ''),
              const SizedBox(height: 25),
              LoginButton(
                  onTap: () {
                    Dialogs.materialDialog(
                        msg: 'Are you sure to refund your order?',
                        title: 'Refund',
                        context: context,
                        actions: [
                          IconsButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Cancel',
                            color: primaryColor,
                            textStyle: const TextStyle(color: Colors.white),
                          ),
                          IconsButton(
                            onPressed: () {
                              _walletController.completeOrderPayment(
                                  context,
                                  _quotationController.orderId,
                                  'refund',
                                  _quotationController.senderId);
                            },
                            text: 'Refund',
                            color: primaryColor,
                            textStyle: const TextStyle(color: Colors.white),
                          ),
                        ]);
                  },
                  title: 'Ask for refund',
                  txtColor: Colors.white,
                  btnColor: primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
