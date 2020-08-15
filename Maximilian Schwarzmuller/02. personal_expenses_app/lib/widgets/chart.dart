import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  // dynamically generated property list that returns List<Map<String, Object>> type
  List<Map<String, Object>> get groupedTransactionValues {
    // utility constructore
    return List.generate(7, (index) {
      // getting iteration day
      final weekDay = DateTime.now().subtract(Duration(days: index));
      // double totalSum;
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    // });
    }).reversed.toList();
  }

  double get totalSpending {
    // fold() allows to change a list to another type, which a certain logic define in the function
    // works like js reduce function
    // 0.0 is a initial value
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      // margin: EdgeInsets.all(5),
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
