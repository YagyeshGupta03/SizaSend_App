import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:savo/Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key, required this.status});

  final String status;

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  List<TextDto> orderList = [
    TextDto("Your order has been placed", ''),
  ];
  List<TextDto> shippedList = [
    TextDto("Your order has been shipped", ""),
  ];

  List<TextDto> outOfDeliveryList = [
    TextDto("Your order is reached to the store", ""),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Track your order',
          style: themeController.currentTheme.value.textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              OrderTracker(
                status: widget.status == 'paid' ? Status.order : Status.shipped,
                activeColor: primaryColor,
                inActiveColor: Colors.grey[300],
                orderTitleAndDateList: orderList,
                shippedTitleAndDateList: shippedList,
                deliveredTitleAndDateList: outOfDeliveryList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
