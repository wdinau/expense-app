import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    var _emptyTransactionWidget = LayoutBuilder(builder: (context, constraint) {
      return Column(
        children: [
          Text("No any transaction yet",
              style: Theme.of(context).textTheme.titleMedium),
          Container(
            padding: EdgeInsets.all(6),
            height: constraint.maxHeight *
                (MediaQuery.of(context).orientation == Orientation.portrait
                    ? 0.5
                    : 0.7),
            child: Image.asset(
              "assets/images/waiting.png",
              fit: BoxFit.cover,
            ),
          )
        ],
      );
    });

    // listview builder won't work with the Key supplied

    // var _listViewWidget = ListView.builder(
    //   itemCount: transactions.length,
    //   itemBuilder: (context, index) {
    //     return TransactionItem(
    //         key: ValueKey(transactions[index].id),
    //         transaction: transactions[index],
    //         deleteTransaction: deleteTransaction);
    //   },
    // );

    var _listViewWidget = ListView(
      children: transactions
          .map((tx) => TransactionItem(
              key: ValueKey(tx.id), // the magic makes bg color not shifting
              transaction: tx,
              deleteTransaction: deleteTransaction))
          .toList(),
    );

    return Container(
        child:
            transactions.isEmpty ? _emptyTransactionWidget : _listViewWidget);
  }
}
