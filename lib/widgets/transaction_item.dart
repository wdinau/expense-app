import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem(
      {Key? key, required this.transaction, required this.deleteTransaction})
      : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  final List<Color> randomColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.yellow
  ];

  late Color _bgColor;

  @override
  void initState() {
    super.initState();
    _bgColor = randomColors.elementAt(Random().nextInt(4));
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);

    return Card(
      elevation: 4,
      child: ListTile(
          leading: Container(
            decoration:
                BoxDecoration(shape: BoxShape.rectangle, color: _bgColor),
            height: 300,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: FittedBox(
                child:
                    Text("\$${widget.transaction.amount.toStringAsFixed(2)}"),
              ),
            ),
          ),
          title: Text(widget.transaction.title),
          subtitle: Text(
              DateFormat("yMMMd").format(widget.transaction.dateTime),
              style: TextStyle(
                  color: themeData.hintColor,
                  decorationStyle: TextDecorationStyle.dotted)),
          trailing: mediaQueryData.size.width > 460
              ? TextButton.icon(
                  onPressed: () =>
                      widget.deleteTransaction(widget.transaction.id),
                  icon: Icon(Icons.delete),
                  label: Text("Delete"))
              : Icon(Icons.delete),
          onTap: () => widget.deleteTransaction(widget.transaction.id)),
    );
  }
}
