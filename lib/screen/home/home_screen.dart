import 'package:flutter/material.dart';
import 'package:savo/screen/home/home_header.dart';
import 'package:savo/screen/home/home_operations.dart';
import 'package:savo/screen/home/home_top_buyers.dart';
import 'package:savo/screen/home/home_transaction_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            HomeHeaderScreen(),
            HomeOperations(),
            HomeTopBuyersScreen(),
            HomeTransactionList()
          ],
        ),
      ),
    );
  }
}
