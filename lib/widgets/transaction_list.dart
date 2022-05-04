import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text("No any transaction yet",
                    style: Theme.of(context).textTheme.titleMedium),
                Container(
                  height: 200,
                  padding: EdgeInsets.all(6),
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: FittedBox(
                            child: Text(
                                "\$${transactions[index].amount.toStringAsFixed(2)}"),
                          ),
                        ),
                      ),
                      title: Text(transactions[index].title),
                      subtitle: Text(
                          DateFormat("yMMMd")
                              .format(transactions[index].dateTime),
                          style: TextStyle(
                              color: Theme.of(context).hintColor,
                              decorationStyle: TextDecorationStyle.dotted))),
                );
              },
            ),
    );
  }
}
