import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({Key? key}) : super(key: key);

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction("t0001", "clothing", 34.54, DateTime(2022, 4, 18)),
    Transaction("t0002", "shoes", 18.04, DateTime(2022, 3, 18)),
    Transaction("t0003", "glasses", 908.00, DateTime(2022, 2, 01)),
  ];

  void _addNewTransaction(double amount, String title) {
    final newTx = Transaction(
        DateTime.now().toString(), title, amount, DateTime.now());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
