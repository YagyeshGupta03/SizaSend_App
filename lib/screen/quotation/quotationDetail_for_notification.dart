
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Controllers/quotation_controller.dart';
import 'package:savo/screen/quotation/quotation_details.dart';
import '../../Constants/sizes.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/walllet_controller.dart';
import '../../util/widgets/login_button.dart';

class QuotationDetailForNotification extends StatefulWidget {
  const QuotationDetailForNotification({super.key});

  @override
  State<QuotationDetailForNotification> createState() =>
      _QuotationDetailForNotificationState();
}

class _QuotationDetailForNotificationState
    extends State<QuotationDetailForNotification> {
  final WalletController _walletController = Get.put(WalletController());
  final QuotationController _quotationController =
      Get.put(QuotationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quotation Details',
          style: themeController.currentTheme.value.textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: Obx(()=> Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _quotationController.productName,
                  style:
                  themeController.currentTheme.value.textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  '${_quotationController.price} USD',
                  style: const TextStyle(fontSize: 15, color: primaryColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _quotationController.description,
              style: themeController.currentTheme.value.textTheme.displayMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 35),
            Text(
              'Store Location',
              style: themeController.currentTheme.value.textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(width: 10),
            Text(
              _quotationController.store,
              style: themeController.currentTheme.value.textTheme.displayMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 8),
            Container(
              height: 150,
              width: screenWidth(context),
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'assets/images/map.png',
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 35),
            Text(
              'Information',
              style: themeController.currentTheme.value.textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoColumn(
                      title: 'Quantity', value: _quotationController.quantity),
                  InfoColumn(title: 'Price', value: _quotationController.price),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoColumn(
                      title: 'Weight', value: _quotationController.weight),
                  InfoColumn(
                      title: 'Size',
                      value:
                      '${_quotationController.height} cm x ${_quotationController.width} cm'),
                ],
              ),
            ),
            const SizedBox(height: 40),
            LoginButton(
                onTap: () {
                  _walletController.quotationPay(
                      _quotationController.price,
                      _quotationController.senderId,
                      _quotationController.orderId, _quotationController.productName);
                },
                title: 'Pay',
                txtColor: Colors.white,
                btnColor: primaryColor)
          ]),
        ),
      )),
    );
  }
}
