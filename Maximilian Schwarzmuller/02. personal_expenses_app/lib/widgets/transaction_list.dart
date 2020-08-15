import 'package:flutter/material.dart';
import '../models/transaction.dart';

import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transaction added yet',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (currentTransaction, index) {
                // return Card(
                //   elevation: 2,
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         margin: EdgeInsets.symmetric(
                //           vertical: 10,
                //           horizontal: 15,
                //         ),
                //         padding: EdgeInsets.all(10),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             width: 1,
                //             color: Theme.of(context).primaryColor,
                //           ),
                //         ),
                //         child: Text(
                //           'A: \$${transactions[index].amount.toStringAsFixed(2)}',
                //           style: Theme.of(context).textTheme.headline3,
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           Text(
                //             transactions[index].title,
                //             style: Theme.of(context).textTheme.headline5,
                //             // style: TextStyle(
                //             //   fontSize: 20,
                //             //   fontFamily: 'OpenSans',
                //             //   fontWeight: FontWeight.w600,
                //             //   // color: new Color.fromRGBO(110, 112, 129, 1)),
                //             //   color: Theme.of(context).primaryColor,
                //             // ),
                //           ),
                //           Text(
                //             DateFormat.yMMMd().format(transactions[index].date),
                //             style: TextStyle(
                //               fontSize: 16,
                //               fontFamily: 'OpenSans',
                //               color: Theme.of(context).primaryColor,
                //             ),
                //           )
                //         ],
                //       )
                //     ],
                //   ),
                // );

                /**
                 * Design List widget with custom styling
                 * ListTitle Widget
                 */
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      //  Container(
                      //   height: 60,
                      //   width: 60,
                      //   decoration: BoxDecoration(
                      //     color: Theme.of(context).primaryColor,
                      //     shape: BoxShape.circle
                      //   ),
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    trailing: IconButton(
                      iconSize: 35,
                      color: Theme.of(context).primaryColor,
                      icon: Icon(Icons.delete_forever),
                      onPressed: () => deleteTransaction(transactions[index].id)
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}

/*

import 'package:flutter/material.dart';
import '../models/transaction.dart';

import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView(
        //  ListView(
        // Container(
        //   height: 300,
        //   child: SingleChildScrollView(
        children: transactions.map((transaction) {
          return Card(
            elevation: 2,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black12,
                    ),
                  ),
                  // child: Text('A: ' + transaction.amount.toString()),
                  child: Text('A: \$${transaction.amount}'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transaction.title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: new Color.fromRGBO(110, 112, 129, 1)),
                    ),
                    Text(
                      // transaction.date.toString(),
                      // DateFormat('yyyy-MM-dd').format(transaction.date),
                      DateFormat.yMMMd().format(transaction.date),
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    )
                  ],
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
 */
