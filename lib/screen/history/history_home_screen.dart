import 'package:flutter/material.dart';
import 'package:savo/screen/history/transaction_list.dart';

class HistoryHomeScreen extends StatefulWidget {
  const HistoryHomeScreen({super.key});

  @override
  State<HistoryHomeScreen> createState() => _HistoryHomeScreenState();
}

class _HistoryHomeScreenState extends State<HistoryHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            TransactionList()
          ],
        ),
      ),
    );
  }
}
