import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/screen/history/transaction_list.dart';
import '../../Controllers/quotation_controller.dart';

class HistoryHomeScreen extends StatefulWidget {
  const HistoryHomeScreen({super.key});

  @override
  State<HistoryHomeScreen> createState() => _HistoryHomeScreenState();
}

class _HistoryHomeScreenState extends State<HistoryHomeScreen> {
  final QuotationController _quotationController =
  Get.put(QuotationController());

  @override
  void initState() {
    super.initState();
   _quotationController.receiveQuotationHistory();
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
             SizedBox(height: 20),
            TransactionList(),
          ],
        ),
      ),
    );
  }
}
