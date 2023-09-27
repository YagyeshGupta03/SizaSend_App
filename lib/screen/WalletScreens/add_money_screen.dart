import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/util/widgets/login_button.dart';
import 'package:savo/util/widgets/text_field.dart';
import '../../Controllers/walllet_controller.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({Key? key}) : super(key: key);

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final _amount = TextEditingController();
  final WalletController _walletController = Get.put(WalletController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Available balance',
                  style:
                      themeController.currentTheme.value.textTheme.bodyLarge),
              Text(userInfoController.balance,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: primaryColor)),
              const SizedBox(height: 25),
              CustomTextField(
                  cont: _amount,
                  title: 'Amount',
                  icon: const SizedBox(),
                  fieldLabel: 'Amount',
                  keyboard: TextInputType.number,
                  fillColor: themeController.currentTheme.value.cardColor,
                  hintText: 'Enter Amount in USD'),
              const SizedBox(height: 25),
              LoginButton(
                  onTap: () {
                    if (_amount.text.isNotEmpty) {
                      // _walletController.webOpen(_amount.text);
                      _walletController.addMoney(context, _amount.text);
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Enter the amount',
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  title: 'Add Money',
                  txtColor: Colors.white,
                  btnColor: primaryColor)
            ],
          ),
        ),
      ),
    );
  }
}

class QuotationMoneyAdd extends StatefulWidget {
  const QuotationMoneyAdd({super.key, required this.price});

  final String price;

  @override
  State<QuotationMoneyAdd> createState() => _QuotationMoneyAddState();
}

class _QuotationMoneyAddState extends State<QuotationMoneyAdd> {
  String requiredAmount = '';

  @override
  void initState() {
    super.initState();
    calculateAmount(widget.price);
  }

  final _amount = TextEditingController();
  final WalletController _walletController = Get.put(WalletController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Available balance',
                  style:
                      themeController.currentTheme.value.textTheme.bodyLarge),
              Text('${userInfoController.balance}  USD',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: primaryColor)),
              const SizedBox(height: 25),
              Text('Required extra',
                  style:
                      themeController.currentTheme.value.textTheme.bodyLarge),
              Text('$requiredAmount  USD',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: primaryColor)),
              const SizedBox(height: 25),
              CustomTextField(
                  cont: _amount,
                  title: 'Amount',
                  icon: const SizedBox(),
                  fieldLabel: 'Amount',
                  keyboard: TextInputType.number,
                  fillColor: themeController.currentTheme.value.cardColor,
                  hintText: 'Enter Amount in USD'),
              const SizedBox(height: 25),
              LoginButton(
                  onTap: () {
                    if (_amount.text.isNotEmpty) {
                      _walletController.quotationAddMoney(
                          context, _amount.text);
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Enter the amount',
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  title: 'Add Money',
                  txtColor: Colors.white,
                  btnColor: primaryColor)
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

    requiredAmount = amount.toString();
  }
}
