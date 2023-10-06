import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/sizes.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Controllers/quotation_controller.dart';
import 'package:savo/screen/WalletScreens/add_total_money_screen.dart';
import 'package:savo/screen/dashboard_screen.dart';
import 'package:savo/screen/quotation/quotation_details.dart';
import 'package:savo/util/widgets/text_field.dart';

import '../../util/widgets/widget.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({Key? key}) : super(key: key);

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final _amount = TextEditingController();
  String text = '';
  List paymentsWay = [
    'EFT',
    'Credit card',
    'Debit card',
    'Masterpass',
    'Mobicred',
    'SnapScan',
    'Zapper',
    'Store card',
  ];

  List paymentTypes = [
    'eft',
    'cc',
    'dc',
    'mp',
    'mc',
    'ss',
    'zp',
    'rcs',
  ];

  List images = [
    'assets/images/InstantEFT.png',
    'assets/images/CreditCard.png',
    'assets/images/CreditCard.png',
    'assets/images/ScanToPay.png',
    'assets/images/MobiCred.png',
    'assets/images/SnapScan.png',
    'assets/images/Zapper.png',
    'assets/images/RCS.png',
  ];

  calculate(double amount, paymentTypes) {
    String paymentType = paymentTypes;

    //EFT Method
    eftMethod(amount) {
      double minimum = 2.00;
      double percent = 2 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = (amountPercentage + minimum) * 2;
      return finalPrice.toStringAsFixed(1);
    }

    creditCardMethod(amount) {
      double minimum = 2.00;
      double percent = 3.2 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = (amountPercentage + minimum) * 2;
      return finalPrice.toStringAsFixed(1);
    }

    debitCardMethod(amount) {
      double minimum = 2.00;
      double percent = 3.5 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = (amountPercentage + minimum) * 2;
      return finalPrice.toStringAsFixed(1);
    }

    masterPassMethod(amount) {
      double minimum = 2.00;
      double percent = 3.5 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = (amountPercentage + minimum) * 2;
      return finalPrice.toStringAsFixed(1);
    }

    mobiCredMethod(amount) {
      double percent = 3.2 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = amountPercentage * 2;
      return finalPrice.toStringAsFixed(1);
    }

    snapScanMethod(amount) {
      double minimum = 2.00;
      double percent = 3.5 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = (amountPercentage + minimum) * 2;
      return finalPrice.toStringAsFixed(1);
    }

    zapperMethod(amount) {
      double minimum = 2.00;
      double percent = 3.5 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = (amountPercentage + minimum) * 2;
      return finalPrice.toStringAsFixed(1);
    }

    storeCardMethod(amount) {
      double minimum = 2.00;
      double percent = 3.2 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = (amountPercentage + minimum) * 2;
      return finalPrice.toStringAsFixed(1);
    }

    //Calculation

    switch (paymentType) {
      case 'eft':
        return eftMethod(amount);
      case 'cc':
        return creditCardMethod(amount);
      case 'dc':
        return debitCardMethod(amount);
      case 'mp':
        return masterPassMethod(amount);
      case 'mc':
        return mobiCredMethod(amount);
      case 'ss':
        return snapScanMethod(amount);
      case 'zp':
        return zapperMethod(amount);
      case 'rcs':
        return storeCardMethod(amount);
      default:
        return double.parse('0.0');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    double balance = double.parse(userInfoController.balance);
    String walletBalance = balance.toStringAsFixed(1);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(() => const DashBoardScreen());
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Available balance',
                        style: themeController
                            .currentTheme.value.textTheme.bodyLarge),
                    Text(convertToCurrency(walletBalance),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: primaryColor)),
                    const SizedBox(height: 25),
                    CustomTextField(
                        cont: _amount,
                        title: 'Amount',
                        onChanged: (val) {
                          setState(() {
                            text == val;
                          });
                        },
                        icon: const SizedBox(),
                        fieldLabel: 'Amount',
                        keyboard: TextInputType.number,
                        fillColor: themeController.currentTheme.value.cardColor,
                        hintText: 'Enter Amount'),
                    const SizedBox(height: 25),
                    // LoginButton(
                    //     onTap: () {
                    //       if (_amount.text.isNotEmpty) {
                    //         _walletController.webOpen(_amount.text, true);
                    //         // _walletController.addMoney(context, _amount.text);
                    //       } else {
                    //         Fluttertoast.showToast(
                    //           msg: 'Enter the amount',
                    //           gravity: ToastGravity.SNACKBAR,
                    //           backgroundColor: Colors.red,
                    //         );
                    //       }
                    //     },
                    //     title: 'Add Money',
                    //     txtColor: Colors.white,
                    //     btnColor: primaryColor),
                    // const SizedBox(height: 25),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                      child: Text(
                        'Pay using',
                        style: themeController
                            .currentTheme.value.textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                itemCount: 8,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (_amount.text.isNotEmpty) {
                        Get.to(() => AddTotalMoneyScreen(
                            amount: _amount.text,
                            status: true,
                            type: paymentTypes[index],
                            charges:
                                '${calculate(double.parse(_amount.text.isNotEmpty ? _amount.text : "0.0"), paymentTypes[index])}',
                            transactionGateway: paymentsWay[index]));
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Enter the amount',
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(color: Colors.black12)),
                      child: Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: ListTile(
                          title: Text(
                            paymentsWay[index],
                            style: themeController
                                .currentTheme.value.textTheme.titleSmall,
                          ),
                          trailing: Container(
                            constraints: BoxConstraints(
                                maxWidth: screenWidth(context) / 2.8),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Image.asset(images[index], fit: BoxFit.fill),
                          ),
                          subtitle: Text(
                            '- R ${calculate(double.parse(_amount.text.isNotEmpty ? _amount.text : "0.0"), paymentTypes[index])}',
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuotationMoneyAdd extends StatefulWidget {
  const QuotationMoneyAdd(
      {super.key, required this.price, required this.orderID});

  final String price;
  final String orderID;

  @override
  State<QuotationMoneyAdd> createState() => _QuotationMoneyAddState();
}

class _QuotationMoneyAddState extends State<QuotationMoneyAdd> {
  String requiredAmount = '';
  final QuotationController _quotationController =
      Get.put(QuotationController());
  @override
  void initState() {
    super.initState();
    calculateAmount(widget.price);
  }

  final _amount = TextEditingController();

  String text = '';
  List paymentsWay = [
    'EFT',
    'Credit card',
    'Debit card',
    'Masterpass',
    'Mobicred',
    'SnapScan',
    'Zapper',
    'Store card',
  ];

  List paymentTypes = [
    'eft',
    'cc',
    'dc',
    'mp',
    'mc',
    'ss',
    'zp',
    'rcs',
  ];

  List images = [
    'assets/images/InstantEFT.png',
    'assets/images/CreditCard.png',
    'assets/images/CreditCard.png',
    'assets/images/ScanToPay.png',
    'assets/images/MobiCred.png',
    'assets/images/SnapScan.png',
    'assets/images/Zapper.png',
    'assets/images/RCS.png',
  ];

  calculate(double amount, paymentTypes) {
    String paymentType = paymentTypes;

    //EFT Method
    eftMethod(amount) {
      double minimum = 2.00;
      double percent = 2 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = (amountPercentage + minimum) * 2;
      return finalPrice.toStringAsFixed(1);
    }

    creditCardMethod(amount) {
      double minimum = 2.00;
      double percent = 3.2 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = (amountPercentage + minimum) * 2;
      return finalPrice.toStringAsFixed(1);
    }

    debitCardMethod(amount) {
      double minimum = 2.00;
      double percent = 3.5 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = (amountPercentage + minimum) * 2;
      return finalPrice.toStringAsFixed(1);
    }

    masterPassMethod(amount) {
      double minimum = 2.00;
      double percent = 3.5 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = (amountPercentage + minimum) * 2;
      return finalPrice.toStringAsFixed(1);
    }

    mobiCredMethod(amount) {
      double percent = 3.2 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = amountPercentage * 2;
      return finalPrice.toStringAsFixed(1);
    }

    snapScanMethod(amount) {
      double minimum = 2.00;
      double percent = 3.5 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = (amountPercentage + minimum) * 2;
      return finalPrice.toStringAsFixed(1);
    }

    zapperMethod(amount) {
      double minimum = 2.00;
      double percent = 3.5 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = (amountPercentage + minimum) * 2;
      return finalPrice.toStringAsFixed(1);
    }

    storeCardMethod(amount) {
      double minimum = 2.00;
      double percent = 3.2 / 100;
      double amountPercentage = amount * percent;
      double finalPrice = (amountPercentage + minimum) * 2;
      return finalPrice.toStringAsFixed(1);
    }

    //Calculation

    switch (paymentType) {
      case 'eft':
        return eftMethod(amount);
      case 'cc':
        return creditCardMethod(amount);
      case 'dc':
        return debitCardMethod(amount);
      case 'mp':
        return masterPassMethod(amount);
      case 'mc':
        return mobiCredMethod(amount);
      case 'ss':
        return snapScanMethod(amount);
      case 'zp':
        return zapperMethod(amount);
      case 'rcs':
        return storeCardMethod(amount);
      default:
        return double.parse('0.0');
    }
  }

  @override
  Widget build(BuildContext context) {
    double balance = double.parse(userInfoController.balance);
    String walletBalance = balance.toStringAsFixed(1);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _quotationController
                .getQuotationByOrderId(widget.orderID)
                .whenComplete(() => Get.to(
                      () => const QuotationDetailScreen(),
                    ));
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Available balance',
                      style: themeController
                          .currentTheme.value.textTheme.bodyLarge),
                  Text(convertToCurrency(walletBalance),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: primaryColor)),
                  const SizedBox(height: 25),
                  Text('Required extra',
                      style: themeController
                          .currentTheme.value.textTheme.bodyLarge),
                  Text(convertToCurrency(requiredAmount),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: primaryColor)),
                  const SizedBox(height: 25),
                  CustomTextField(
                      cont: _amount,
                      title: 'Amount',
                      icon: const SizedBox(),
                      onChanged: (val) {
                        setState(() {
                          text == val;
                        });
                      },
                      fieldLabel: 'Amount',
                      keyboard: TextInputType.number,
                      fillColor: themeController.currentTheme.value.cardColor,
                      hintText: 'Enter Amount in USD'),
                  const SizedBox(height: 25),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                    child: Text(
                      'Pay using',
                      style: themeController
                          .currentTheme.value.textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              // LoginButton(
              //     onTap: () {
              //       if (_amount.text.isNotEmpty) {
              //         _walletController.webOpen(_amount.text, false);
              //         // _walletController.quotationAddMoney(
              //         //     context, _amount.text);
              //       } else {
              //         Fluttertoast.showToast(
              //           msg: 'Enter the amount',
              //           gravity: ToastGravity.SNACKBAR,
              //           backgroundColor: Colors.red,
              //         );
              //       }
              //     },
              //     title: 'Add Money',
              //     txtColor: Colors.white,
              //     btnColor: primaryColor)
              ListView.builder(
                itemCount: 8,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (_amount.text.isNotEmpty) {
                        Get.to(() => AddTotalMoneyScreen(
                            amount: _amount.text,
                            status: false,
                            type: paymentTypes[index],
                            charges:
                                '${calculate(double.parse(_amount.text.isNotEmpty ? _amount.text : "0.0"), paymentTypes[index])}',
                            transactionGateway: paymentsWay[index]));
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Enter the amount',
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(color: Colors.black12)),
                      child: Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: ListTile(
                          title: Text(
                            paymentsWay[index],
                            style: themeController
                                .currentTheme.value.textTheme.titleSmall,
                          ),
                          trailing: Container(
                            constraints: BoxConstraints(
                                maxWidth: screenWidth(context) / 2.8),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Image.asset(images[index], fit: BoxFit.fill),
                          ),
                          subtitle: Text(
                            '- R ${calculate(double.parse(_amount.text.isNotEmpty ? _amount.text : "0.0"), paymentTypes[index])}',
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateAmount(value) {
    double balance = double.parse(userInfoController.balance);
    double price = double.parse(value);
    double amount = price - balance;

    requiredAmount = amount.toStringAsFixed(1);
  }
}
