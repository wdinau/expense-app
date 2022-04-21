import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleInputController = TextEditingController();
  final amountInputController = TextEditingController();
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

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
          ),
          TextField(
            decoration: InputDecoration(labelText: "Amount"),
            controller: amountInputController,
          ),
          TextButton(
              onPressed: () {
                addNewTransaction(double.parse(amountInputController.text),
                    titleInputController.text);
              },
              child: Text(
                "Add Transaction",
                style: TextStyle(color: Colors.purple),
              ))
        ],
      ),
    );
  }
}
