import 'dart:io';

import 'package:flutter/cupertino.dart'; //for using cupertino for ios
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/listTransaction.dart';
//import './widgets/user_transaction.dart';
import './models/transaction.dart';
import './widgets/add_transaction.dart';
import './widgets/charts.dart';

void main() {
  //restricting the app to show only in portrait mode only
  /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.deepPurple,
        fontFamily: 'Quicksand',
        errorColor: Colors.red,
        //seting the default styling for the textTheme which can be obtain by other widget using theme.of(context).textTheme.title
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        //setting the default styling for the title of appbar
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(color: Colors.white),
              ),
        ),
      ),
      title: 'Expense App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      amount: 30000,
      date: DateTime.now(),
      id: '0',
      title: 'food',
    ),
    Transaction(
      id: '1',
      title: 'cloths',
      amount: 10000,
      date: DateTime.now(),
    ),
  ];
  List<Transaction> get _recenTransaction {
    return _userTransactions.where((ut) {
      return ut.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool _switchValue = false;
  void _addNewUserTransaction(
      String newTitle, double newAmount, DateTime newDate) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: newDate);
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _userTransactionDelete(String id) {
    print(id);
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

//creating new pop up modal
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      // isScrollControlled: true, a another way to make scrollable bottomsheet
      context: ctx,
      builder: (_) {
        return AddTransaction(_addNewUserTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expense Planner'),
            backgroundColor: Theme.of(context).primaryColor,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _startAddNewTransaction(context),
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Expense Planner'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
    //showing content base on device orientation
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final transactionListWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(
        userTransactions: _userTransactions,
        userTransactionDelete: _userTransactionDelete,
      ),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('show chart',style: Theme.of(context).textTheme.title,),
                  Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      value: _switchValue,
                      onChanged: (val) {
                        setState(() {
                          _switchValue = val;
                        });
                      }),
                ],
              ),
            if (!isLandScape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recenTransaction),
              ),
            if (!isLandScape) transactionListWidget,
            if (isLandScape)
              _switchValue
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_recenTransaction),
                    )
                  :
                  //UserTransaction(),
                  transactionListWidget,
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
          );
  }
}
