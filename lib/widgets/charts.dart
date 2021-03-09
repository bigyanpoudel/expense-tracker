import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../widgets/char_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalAmount = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) { 
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month ==
                recentTransaction[i].date.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalAmount += recentTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
      //for reversing a list
    }).reversed.toList();
  }

  double get totalAmountSpending {
    return groupedTransactionValues.fold(
        0.0, (val, element) => val + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(

      elevation: 7,
      margin: EdgeInsets.all(5),
      //padding we=idget provie padding 
      child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((val) {
            //flexible wrap the items so that it can grow when the content on the child grow or take more space
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  val['day'],
                  val['amount'],
                  totalAmountSpending == 0.0
                      ? 0.0
                      : (val['amount'] as double) / totalAmountSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
