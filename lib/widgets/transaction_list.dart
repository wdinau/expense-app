import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraint) {
              return Column(
                children: [
                  Text("No any transaction yet",
                      style: Theme.of(context).textTheme.titleMedium),
                  Container(
                    padding: EdgeInsets.all(6),
                    height: constraint.maxHeight *
                        (MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 0.5
                            : 0.7),
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final themeData = Theme.of(context);
                var mediaQueryData = MediaQuery.of(context);

                return Card(
                  elevation: 4,
                  child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: themeData.backgroundColor),
                        height: 300,
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
                              color: themeData.hintColor,
                              decorationStyle: TextDecorationStyle.dotted)),
                      trailing: mediaQueryData.size.width > 460
                          ? TextButton.icon(
                              onPressed: () => deleteTransaction(index),
                              icon: Icon(Icons.delete),
                              label: Text("Delete"))
                          : Icon(Icons.delete)),
                );
              },
            ),
    );
  }
}
