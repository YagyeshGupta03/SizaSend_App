import 'package:flutter/material.dart';
import 'package:savo/screen/quotation/quotation_list.dart';

class QuotationHomeScreen extends StatefulWidget {
  const QuotationHomeScreen({super.key});

  @override
  State<QuotationHomeScreen> createState() => _QuotationHomeScreenState();
}

class _QuotationHomeScreenState extends State<QuotationHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            QuotationList(),
          ],
        ),
      ),
    );
  }
}
