import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Controllers/notifications_controller.dart';
import 'package:savo/screen/home/home_header.dart';
import 'package:savo/screen/home/home_operations.dart';
import 'package:savo/screen/home/home_transaction_list.dart';
import '../../Controllers/quotation_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final QuotationController _quotationController = Get.put(QuotationController());

  @override
  void initState() {
    super.initState();
    _quotationController.receiveQuotation();
    _quotationController.receiveQuotationHistory();
    loadingController.updateDispatchLoading(false);
    loadingController.updateProfileLoading(false);
    loadingController.updateVideoCompressionLoading(false);
    loadingController.updateLoading(false);
    userInfoController.getUserInfo();
    FCM().setNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            HomeHeaderScreen(),
            HomeOperations(),
            // HomeTopBuyersScreen(),
            HomeTransactionList()
          ],
        ),
      ),
    );
  }
}
