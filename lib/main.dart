import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/user_transaction.dart';
import 'package:flutter/material.dart';

import 'widgets/transaction_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  List<Transaction> _userTransactions = [
    Transaction("t0001", "clothing", 34.54, DateTime(2022, 4, 18)),
    Transaction("t0002", "shoes", 18.04, DateTime(2022, 3, 18)),
    Transaction("t0003", "glasses", 908.00, DateTime(2022, 2, 01)),
  ];

  double amountInput = 0.0;
  String titleInput = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("app bar title")),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.orange,
                // width: double.infinity,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(2),
                child: Card(
                  elevation: 5,
                  color: Colors.blue,
                  child: Text("Chart is here"),
                ),
              ),
              UserTransaction(),
            ],
          ),
        ));
  }
}
