import 'dart:math';

import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'chart.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final List<Transaction> _transactions = [];
  final List<Transaction> _transactions = [
    Transaction(DateTime.now().toString(), "new shoes", 475.22,
        DateTime.now().subtract(Duration(days: Random().nextInt(7)))),
    Transaction(
        DateTime.now().toString(),
        "small something something very very long and super long and see how this one goes",
        2.22,
        DateTime.now().subtract(Duration(days: Random().nextInt(7)))),
    Transaction(DateTime.now().toString(), "very large rubber ducky", 23475.9,
        DateTime.now().subtract(Duration(days: Random().nextInt(7)))),
    Transaction(DateTime.now().toString(), "dr. glove stuff", 13.90,
        DateTime.now().subtract(Duration(days: Random().nextInt(7)))),
    Transaction(DateTime.now().toString(), "somewhat expensive stuff", 3413.90,
        DateTime.now().subtract(Duration(days: Random().nextInt(7)))),
  ];

  void _onPressAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _addNewTransaction(double amount, String title, DateTime dateTime) {
    final newTx =
        Transaction(DateTime.now().toString(), title, amount, dateTime);
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(int index) {
    setState(() {
      _transactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log Your Expense!"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Theme.of(context).canvasColor,
              // width: double.infinity,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(2),
              child: Card(
                  elevation: 5,
                  color: Theme.of(context).cardColor,
                  child: Chart(_transactions)),
            ),
            TransactionList(_transactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {_onPressAddNewTransaction(context)},
      ),
    );
  }
}
