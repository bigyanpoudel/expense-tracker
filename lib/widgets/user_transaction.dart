import 'package:expense_app/widgets/add_transaction.dart';
import 'package:expense_app/widgets/listTransaction.dart';
import 'package:flutter/material.dart';
import './add_transaction.dart';
import './listTransaction.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(
      amount: 30000,
      date: DateTime.now(),
      id: '1',
      title: 'food',
    ),
    Transaction(
      id: '2',
      title: 'cloths',
      amount: 10000,
      date: DateTime.now(),
    ),
  ];
  void _addNewUserTransaction(String newTitle, double newAmount) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AddTransaction(_addNewUserTransaction),
        TransactionList(
          userTransactions: _userTransactions,
        ),
      ],
    );
  }
}
