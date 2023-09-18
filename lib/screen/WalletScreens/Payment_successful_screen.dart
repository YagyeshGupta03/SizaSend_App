import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/screen/dashboard_screen.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  const PaymentSuccessfulScreen({super.key, required this.orderId, required this.orderName, required this.amount});

  final String orderId;
  final String orderName;
  final String amount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text('Payment successful',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              const SizedBox(height: 15),
              const Center(
                child: Icon(Icons.check_circle, color: Colors.green, size: 45),
              ),
              const SizedBox(height: 30),
               PaymentTile(name: 'Order id', value: orderId),
              const SizedBox(height: 20),
              PaymentTile(name: 'Order name', value: orderName),
              const SizedBox(height: 20),
              PaymentTile(name: 'Amount Paid', value: '$amount USD'),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    Get.to(()=> const DashBoardScreen());
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Text(
                      'Go back',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentTile extends StatelessWidget {
  const PaymentTile({
    super.key,
    required this.name,
    required this.value,
  });

  final String name;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        Text(value, style: const TextStyle(fontSize: 16, color: Colors.black))
      ],
    );
  }
}
