import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentageOfTotal;

  ChartBar(this.label, this.amount, this.percentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: constraint.maxHeight * 0.15,
              child: Text(amount.toString())),
          Container(
              width: 20,
              height: constraint.maxHeight * 0.7,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Theme.of(context).backgroundColor),
              child: Container(
                  width: double.infinity,
                  height: percentageOfTotal * (constraint.maxHeight * 0.7),
                  color: Theme.of(context).primaryColor)),
          SizedBox(height: constraint.maxHeight * 0.15, child: Text(label))
        ],
      );
    });
  }
}
