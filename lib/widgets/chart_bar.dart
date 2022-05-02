import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentageOfTotal;
  static const double fullBarHeight = 100;

  ChartBar(this.label, this.amount, this.percentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(amount.toString()),
        Container(
            width: 20,
            height: fullBarHeight,
            color: Theme.of(context).backgroundColor,
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: percentageOfTotal * fullBarHeight,
              color: Theme.of(context).primaryColor,
            )),
        Text(label)
      ],
    );
  }
}
