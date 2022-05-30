import 'dart:async';

import 'package:expense_app/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInputController = TextEditingController();
  final _amountInputController = TextEditingController();
  DateTime _datePicked = DateTime.now();

  void _onSubmit() {
    var amount = double.parse(_amountInputController.text);
    var title = _titleInputController.text;

    if (amount <= 0 || title.isEmpty) return;
    widget.addNewTransaction(amount, title, _datePicked);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: _datePicked,
            firstDate: DateTime.now().subtract(Duration(days: 300)),
            lastDate: DateTime.now().add(Duration(days: 300)))
        .then(_onDatePicked);
  }

  FutureOr<Null> _onDatePicked(datePicked) {
    if (datePicked == null) return null;
    setState(() {
      _datePicked = datePicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    var viewInsertsBottom = MediaQuery.of(context).viewInsets.bottom;
    print("view insets bottom " + viewInsertsBottom.toString());
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
            top: 10, left: 10, right: 10, bottom: viewInsertsBottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              autocorrect: true,
              decoration: InputDecoration(labelText: "Item Title"),
              controller: _titleInputController,
              onSubmitted: (_) => _onSubmit,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountInputController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _onSubmit,
            ),
            Row(
              children: [
                Expanded(child: Text(DateFormat.yMMMd().format(_datePicked))),
                AdaptiveFlatButton("Pick a date", _presentDatePicker)
              ],
            ),
            AdaptiveButton("Add Transaction", _onSubmit)
          ],
        ),
      ),
    );
  }
}
