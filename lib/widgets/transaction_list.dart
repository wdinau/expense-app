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
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(4),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                  ),
                  child: Text(
                    "\$${transactions[index].amount.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transactions[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(DateFormat("yMMMd").format(transactions[index].dateTime),
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          decorationStyle: TextDecorationStyle.dotted))
                ],
              )
            ]),
          );
        },
      ),
    );
  }
}
