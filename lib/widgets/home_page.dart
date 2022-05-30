import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
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

  bool _displayChart = false;

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

  void _onSwitchChanged(newValue) {
    setState(() {
      _displayChart = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Log Your Expense!"),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        )
      ],
    );

    final cupertinoNavBar = CupertinoNavigationBar(
      middle: Text("Personal Expense"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
              child: Icon(CupertinoIcons.add),
              onPressed: () => {_onPressAddNewTransaction(context)}),
        ],
      ),
    );

    var _switcherWidget =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Chart View",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      Switch.adaptive(
        activeColor: Theme.of(context).toggleableActiveColor,
        onChanged: _onSwitchChanged,
        value: _displayChart,
      ),
    ]);

    var _chartWidget = Container(
      color: Theme.of(context).canvasColor,
      height: MediaQuery.of(context).size.height *
              (MediaQuery.of(context).orientation == Orientation.portrait
                  ? 0.3
                  : 0.7) -
          (Platform.isIOS
              ? cupertinoNavBar.preferredSize.height
              : appBar.preferredSize.height),
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(2),
      child: Card(
          elevation: 5,
          color: Theme.of(context).cardColor,
          child: Chart(_transactions)),
    );

    var _transactionListViewWidget = Container(
        height: MediaQuery.of(context).size.height * 0.7 -
            (Platform.isIOS
                ? cupertinoNavBar.preferredSize.height
                : appBar.preferredSize.height),
        child: TransactionList(_transactions, _deleteTransaction));

    var pageWidget = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: MediaQuery.of(context).orientation == Orientation.portrait
            ? [_chartWidget, _transactionListViewWidget]
            : [
                _switcherWidget,
                _displayChart ? _chartWidget : _transactionListViewWidget
              ]);
    var pageBodyWidget = SafeArea(
      child: SingleChildScrollView(
        primary: true,
        child: pageWidget,
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBodyWidget,
            navigationBar: cupertinoNavBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBodyWidget,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => {_onPressAddNewTransaction(context)},
                  ),
          );
  }
}
