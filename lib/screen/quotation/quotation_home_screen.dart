import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/quotation_controller.dart';
import 'package:savo/screen/quotation/add_quotation_screen.dart';
import 'package:savo/screen/quotation/quotation_list.dart';

class QuotationHomeScreen extends StatefulWidget {
  const QuotationHomeScreen({super.key});

  @override
  State<QuotationHomeScreen> createState() => _QuotationHomeScreenState();
}

class _QuotationHomeScreenState extends State<QuotationHomeScreen> {
  final QuotationController _quotationController = Get.put(QuotationController());
  @override
  void initState() {
    super.initState();
    _quotationController.receiveQuotation();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextButton(
              onPressed: (){
                Get.to(()=> const AddQuotationScreen(edit: false,));
              },
              child: const Text(
                'Add Quotation +',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
            ),
            const SizedBox(height: 10),
           const QuotationList(),
          ],
        ),
      ),
    );
  }
}
