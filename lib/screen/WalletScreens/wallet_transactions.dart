import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:savo/Controllers/walllet_controller.dart';
import '../../Controllers/global_controllers.dart';

class WalletTransactions extends StatefulWidget {
  const WalletTransactions({super.key});

  @override
  State<WalletTransactions> createState() => _WalletTransactionsState();
}

class _WalletTransactionsState extends State<WalletTransactions> {
  final WalletController _walletController = Get.put(WalletController());

  @override
  void initState() {
    super.initState();
    _walletController.getWalletHistory();
  }

  transactionTitle(val, status) {
    if (val == 'Bank transfer') {
      return 'Bank transfer';
    } else if (val == 'Wallet transfer') {
      return 'Wallet transfer';
    } else {
      if (status == 'addition') {
        return 'From $val';
      } else {
        return 'To $val';
      }
    }
  }

  transactionImage(val) {
    if (val == 'Bank transfer') {
      return Image.asset('assets/icons/bankTransfer.png', fit: BoxFit.fill);
    } else if (val == 'Wallet transfer') {
      return Image.asset('assets/icons/walletTransfer.png', fit: BoxFit.fill);
    } else {
      return const Icon(Icons.send);
    }
  }

  String lastDisplayedDate = "";
  String currentDate = DateFormat.yMMMMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Wallet transactions',
            style: themeController.currentTheme.value.textTheme.bodyLarge,
          ),
          centerTitle: true),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SingleChildScrollView(
          child: Obx(
            () => _walletController.walletTransactionsList.length.isEqual(0)
                ? Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                      child: Text('No transactions',
                          style: themeController
                              .currentTheme.value.textTheme.titleSmall),
                    ),
                )
                : ListView.builder(
                    itemCount: _walletController.walletTransactionsList.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final displayDate =
                          _walletController.walletTransactionsList[index].date;

                      final showDate = displayDate != lastDisplayedDate;
                      lastDisplayedDate = displayDate;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showDate)
                            currentDate ==
                                    _walletController
                                        .walletTransactionsList[index].date
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10),
                                    child: Text(
                                      'Today',
                                      style: themeController.currentTheme.value
                                          .textTheme.titleSmall,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 20, bottom: 10),
                                    child: Text(
                                      _walletController
                                          .walletTransactionsList[index].date,
                                      style: themeController.currentTheme.value
                                          .textTheme.titleSmall,
                                    ),
                                  ),
                          Card(
                            color: themeController.currentTheme.value.cardColor,
                            elevation: 0,
                            child: ListTile(
                              tileColor:
                                  themeController.currentTheme.value.cardColor,
                              leading: Container(
                                height: 40,
                                width: 40,
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: transactionImage(_walletController
                                    .walletTransactionsList[index].paidUser),
                              ),
                              title: Text(
                                transactionTitle(
                                    _walletController
                                        .walletTransactionsList[index].paidUser,
                                    _walletController
                                        .walletTransactionsList[index].status),
                                style: themeController
                                    .currentTheme.value.textTheme.titleSmall,
                              ),
                              subtitle: Text(
                                _walletController.walletTransactionsList[index]
                                            .status ==
                                        'addition'
                                    ? 'Credit'
                                    : 'Debit',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: _walletController
                                                .walletTransactionsList[index]
                                                .status ==
                                            'addition'
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              trailing: Text(
                                _walletController.walletTransactionsList[index]
                                    .status ==
                                    'addition'
                                    ? '+${_walletController.walletTransactionsList[index].balance}'
                                    : '-${_walletController.walletTransactionsList[index].balance}',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: _walletController
                                                .walletTransactionsList[index]
                                                .status ==
                                            'addition'
                                        ? Colors.green
                                        : Colors.red),
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
                                      .walletTransactionsList[index].time,
                                  style: themeController
                                      .currentTheme.value.textTheme.labelSmall,
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
