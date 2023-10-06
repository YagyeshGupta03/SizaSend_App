import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Controllers/walllet_controller.dart';
import 'package:savo/screen/WalletScreens/withdraw_charges_screen.dart';
import 'package:savo/screen/dashboard_screen.dart';
import 'package:savo/screen/profile/BankAccount_screens/bank_account_listing.dart';
import 'package:savo/util/widgets/login_button.dart';
import 'package:savo/util/widgets/text_field.dart';
import 'package:savo/util/widgets/widget.dart';

class WithdrawMoneyScreen extends StatefulWidget {
  const WithdrawMoneyScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawMoneyScreen> createState() => _WithdrawMoneyScreenState();
}

class _WithdrawMoneyScreenState extends State<WithdrawMoneyScreen> {
  final _amount = TextEditingController();
  final WalletController _walletController = Get.put(WalletController());

  @override
  void initState() {
    super.initState();
    _walletController.getWithdrawalHistory();
    userInfoController.getUserInfo();
  }

  String lastDisplayedDate = "";
  String currentDate = DateFormat.yMMMMd().format(DateTime.now());

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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Available balance',
                  style:
                      themeController.currentTheme.value.textTheme.bodyLarge),
              Text(convertToCurrency(walletBalance),
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
                      credentialController.setWithdraw(_amount.text);
                      Get.to(() => const BankListWithdraw());
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Enter the amount',
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  title: 'Select bank account',
                  txtColor: Colors.white,
                  btnColor: primaryColor),
              const SizedBox(height: 25),
              Obx(
                () => _walletController.withdrawRequestList.length.isEqual(0)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text('No transactions',
                              style: themeController
                                  .currentTheme.value.textTheme.titleSmall),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _walletController.withdrawRequestList.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final displayDate =
                              _walletController.withdrawRequestList[index].date;

                          final showDate = displayDate != lastDisplayedDate;
                          lastDisplayedDate = displayDate;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (showDate)
                                currentDate ==
                                        _walletController
                                            .withdrawRequestList[index].date
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        child: Text(
                                          'Today',
                                          style: themeController.currentTheme
                                              .value.textTheme.titleSmall,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 20, bottom: 10),
                                        child: Text(
                                          _walletController
                                              .withdrawRequestList[index].date,
                                          style: themeController.currentTheme
                                              .value.textTheme.titleSmall,
                                        ),
                                      ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => WithdrawChargesScreen(
                                      withdrawAmount: _walletController
                                          .withdrawRequestList[index].amount,
                                      charges: _walletController
                                          .withdrawRequestList[index].charges,
                                      bankName: _walletController
                                          .withdrawRequestList[index].bankName,
                                      status: _walletController
                                          .withdrawRequestList[index].status,
                                      acNumber: _walletController
                                          .withdrawRequestList[index].bankName,
                                      ifsc: _walletController
                                          .withdrawRequestList[index].ifsc));
                                },
                                child: Card(
                                  color: themeController
                                      .currentTheme.value.cardColor,
                                  elevation: 0,
                                  child: ListTile(
                                    tileColor: themeController
                                        .currentTheme.value.cardColor,
                                    leading: Container(
                                      height: 40,
                                      width: 40,
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Image.asset(
                                          'assets/icons/bankTransfer.png',
                                          fit: BoxFit.fill),
                                    ),
                                    title: Text(
                                      _walletController
                                          .withdrawRequestList[index].bankName,
                                      style: themeController.currentTheme.value
                                          .textTheme.titleSmall,
                                    ),
                                    subtitle: Text(
                                      _walletController
                                                  .withdrawRequestList[index]
                                                  .status ==
                                              'Accept'
                                          ? 'Bank transfer success'
                                          : _walletController
                                              .withdrawRequestList[index]
                                              .status,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w800,
                                          color: _walletController
                                                      .withdrawRequestList[
                                                          index]
                                                      .status ==
                                                  'Accept'
                                              ? Colors.green
                                              : primaryColor),
                                    ),
                                    trailing: Text(
                                      convertToCurrency(_walletController.withdrawRequestList[index].amount),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: _walletController
                                                      .withdrawRequestList[
                                                          index]
                                                      .status ==
                                                  'Accept'
                                              ? Colors.green
                                              : primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      _walletController
                                          .withdrawRequestList[index].time,
                                      style: themeController.currentTheme.value
                                          .textTheme.labelSmall,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
