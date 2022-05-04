import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';

typedef DataRows = List<Map<String, double>>;

class Chart extends StatelessWidget {
  final List<Transaction> transactions;
  double totalReportingValue = 0.0;

  Chart(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionsLast7Days.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                tx["weekday"].toString(),
                tx["amount"] as double,
                getPercentageOfTotal(tx),
              ),
            );
          }).toList(),
        ));
  }

  List<Map<String, dynamic>> get groupedTransactionsLast7Days {
    print("THIS.TRANSACTIONS ");
    print(transactions.length);
    final results = transactions
        .fold<Map<DateTime, double>>(
          emptyReport(7),
          addTransactionToReport,
        )
        .entries
        .sortWith((e) => e.key, dateOrder)
        .map(toChartData)
        .toList();

    totalReportingValue =
        results.fold(0.0, (sum, item) => sum += item["amount"]);
    print(results);
    return results;
  }

  Map<DateTime, double> emptyReport(int numberOfDays) {
    return Map.fromEntries(List.generate(
        numberOfDays,
        (index) => MapEntry(
            atStartOfDay(DateTime.now()).subtract(Duration(days: index)), 0)));
  }

  Map<String, dynamic> toChartData(e) =>
      {"weekday": dateTimeToWeekDay(e.key), "amount": e.value};

  Map<DateTime, double> addTransactionToReport(
      Map<DateTime, double> reportValues, Transaction tx) {
    final startOfDay = atStartOfDay(tx.dateTime);
    return reportValues.updateAtIfPresent(dateEqYearMonthDay)(
        startOfDay, (reportValues[startOfDay] ?? 0.0) + tx.amount);
  }

  double getPercentageOfTotal(Map<String, dynamic> tx) {
    return totalReportingValue == 0.0
        ? totalReportingValue
        : (tx["amount"] as double) / totalReportingValue;
  }
}

String dateTimeToWeekDay(DateTime dateTime) {
  return DateFormat.E().format(dateTime);
}

bool isInLastNDays(DateTime dateTime, int numberOfDays) {
  return dateTime
      .isAfter(DateTime.now().subtract(Duration(days: numberOfDays)));
}

DateTime atStartOfDay(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}
