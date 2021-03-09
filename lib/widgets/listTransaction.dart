import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function userTransactionDelete;
  TransactionList(
      {@required this.userTransactions, @required this.userTransactionDelete});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, //listview is by default column with singleChildScrollView
      //to use Listview we must have conatiner with fixed height as it takes infinity
      //we can use listview two ways by using children:[] or listview.builer
      //listview.builder loads the item that can fit in the window i.e lazily loads as we scroll it loads other items
      //where as it listview children:[] methods load all items at once
      child: userTransactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constrains) {
              return Column(
                children: [
                  Text('No transaction is added!',
                      style: Theme.of(context).textTheme.title),
                  //create the box with hight and width of specified and can have child if you required
                  SizedBox(
                    height: constrains.maxHeight * 0.1,
                  ),
                  Container(
                    height: constrains.maxHeight * 0.5,
                    child: Image.asset(
                      'image/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                /*return Card(
                  elevation: 5,
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColorDark,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${userTransactions[index].amount.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      Container(
                        height: 60,
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              userTransactions[index].title.toUpperCase(),
                              style: Theme.of(context).textTheme.title,
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(userTransactions[index].date),
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );*/
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      //circleavattar can be achieved by using conatiner with shape properties
                      radius: 30,
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                              child: Text(
                            '\$${userTransactions[index].amount.toStringAsFixed(2)}',
                          ))),
                    ),
                    title: Text(
                      '${userTransactions[index].title}',
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(DateFormat.yMMMd()
                        .format(userTransactions[index].date)),
                    trailing: MediaQuery.of(context).size.width > 420
                        ? FlatButton.icon(
                            onPressed: () => userTransactionDelete(
                                userTransactions[index].id),
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),

                            textColor: Theme.of(context).errorColor,
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => userTransactionDelete(
                                userTransactions[index].id),
                            color: Theme.of(context).errorColor,
                          ),
                  ),
                );
              },
              itemCount: userTransactions.length,
            ),
    );
  }
}
