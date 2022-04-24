import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInputController = TextEditingController();

  final amountInputController = TextEditingController();

  void _onSubmit() {
    var amount = double.parse(amountInputController.text);
    var title = titleInputController.text;

    if (amount <= 0 || title.isEmpty) return;
    widget.addNewTransaction(amount, title);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            autocorrect: true,
            decoration: InputDecoration(labelText: "Item Title"),
            controller: titleInputController,
            onSubmitted: (_) => _onSubmit,
          ),
          TextField(
            decoration: InputDecoration(labelText: "Amount"),
            controller: amountInputController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _onSubmit,
          ),
          TextButton(
              onPressed: _onSubmit,
              child: Text(
                "Add Transaction",
              ))
        ],
      ),
    );
  }
}
