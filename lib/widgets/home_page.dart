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
  final List<Transaction> _transactions = [];

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
        title: Text("Log Your Expense!",
            style: Theme.of(context).textTheme.titleMedium),
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
            TransactionList(_transactions),
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
