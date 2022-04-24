import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction("t0001", "clothing", 34.54, DateTime(2022, 4, 18)),
    Transaction("t0002", "shoes", 18.04, DateTime(2022, 3, 18)),
    Transaction("t0003", "glasses", 908.00, DateTime(2022, 2, 01)),
  ];

  void _onPressAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _addNewTransaction(double amount, String title) {
    final newTx =
        Transaction(DateTime.now().toString(), title, amount, DateTime.now());
    setState(() {
      _transactions.add(newTx);
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
                child: Text("Chart is here"),
              ),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).backgroundColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () => {_onPressAddNewTransaction(context)},
      ),
    );
  }
}
