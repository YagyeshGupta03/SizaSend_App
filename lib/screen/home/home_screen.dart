import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/common_controllers.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Controllers/notifications_controller.dart';
import 'package:savo/screen/home/home_header.dart';
import 'package:savo/screen/home/home_operations.dart';
import 'package:savo/screen/home/home_transaction_list.dart';
import '../../Controllers/quotation_controller.dart';
import 'home_top_buyers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final QuotationController _quotationController =
      Get.put(QuotationController());
  final BuyerInfoController _buyerInfoController =
      Get.put(BuyerInfoController());

  @override
  void initState() {
    super.initState();
    _quotationController.receiveQuotation();
    _quotationController.receiveQuotationHistory();
    _buyerInfoController.getBuyerData();
    loadingController.updateDispatchLoading(false);
    loadingController.updateProfileLoading(false);
    loadingController.updateVideoCompressionLoading(false);
    loadingController.updateLoading(false);
    userInfoController.getUserInfo();
    FCM().setNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            const HomeHeaderScreen(),
            const HomeOperations(),
           Obx(() =>  _buyerInfoController.buyerList.length.isEqual(0)
               ? const SizedBox()
               : const HomeTopBuyersScreen()),
            const HomeTransactionList()
          ],
        ),
      ),
    );
  }
}
