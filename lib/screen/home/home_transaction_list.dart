import 'package:flutter/material.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/history/transaction_list.dart';
import '../../generated/l10n.dart';

class HomeTransactionList extends StatelessWidget {
  const HomeTransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        Text(S.of(context).recentTransactions,
            style: themeController.currentTheme.value.textTheme.bodyLarge),
        const SizedBox(height: 10),
        const TransactionList()
      ],
    );
  }
}
