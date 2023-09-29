import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/screen/dashboard_screen.dart';
import 'package:savo/screen/quotation/quotation_details.dart';
import 'package:savo/util/widgets/login_button.dart';

import '../../Controllers/global_controllers.dart';

class PaymentStatusScreen extends StatelessWidget {
  const PaymentStatusScreen(
      {super.key, required this.success, required this.status});

  final bool success;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(() => const DashBoardScreen());
          },
          icon: Icon(Icons.arrow_back,
              color: themeController.currentTheme.value.iconTheme.color),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: success
              ? Column(
                  children: [
                    const Icon(Icons.check_circle,
                        size: 60, color: Colors.green),
                    const SizedBox(height: 30),
                    Text('Success',
                        style: themeController
                            .currentTheme.value.textTheme.displayLarge),
                    const SizedBox(height: 15),
                    const Text('Amount added to your wallet',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 50),
                    LoginButton(
                        onTap: () {
                          status
                              ? Get.to(() => const DashBoardScreen())
                              : Get.to(() => const QuotationDetailScreen());
                        },
                        title: 'Go to Home',
                        txtColor: Colors.white,
                        btnColor: primaryColor),
                  ],
                )
              : Column(
                  children: [
                    Image.asset('assets/icons/ic_reject.png',
                        fit: BoxFit.fill, height: 70, width: 70),
                    const SizedBox(height: 30),
                    Text('Failed',
                        style: themeController
                            .currentTheme.value.textTheme.displayLarge),
                    const SizedBox(height: 15),
                    const Text('Transaction failed',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 50),
                    LoginButton(
                        onTap: () {
                          status
                              ? Get.to(() => const DashBoardScreen())
                              : Get.to(() => const QuotationDetailScreen());
                        },
                        title: 'Go to Home',
                        txtColor: Colors.white,
                        btnColor: primaryColor),
                  ],
                ),
        ),
      ),
    );
  }
}
