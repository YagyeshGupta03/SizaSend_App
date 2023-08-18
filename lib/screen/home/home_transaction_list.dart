import 'package:flutter/material.dart';
import 'package:savo/screen/history/transaction_list.dart';

import '../../generated/l10n.dart';

class HomeTransactionList extends StatelessWidget {
  const HomeTransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        ListTile(
          title: Text(S.of(context).recentTransactions),
          trailing:
              TextButton(onPressed: () {}, child: Text(S.of(context).viewAll)),
        ),
        const TransactionList()
      ],
    );
  }
}
