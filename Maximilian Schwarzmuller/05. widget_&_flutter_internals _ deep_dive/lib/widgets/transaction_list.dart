import 'package:flutter/material.dart';

import '../widgets/transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  // const TransactionList(this.transactions, this.deleteTransaction) {}
  TransactionList(this.transactions, this.deleteTransaction) {
    print('TransactionList Constructor');
  }

  @override
  Widget build(BuildContext context) {
    print('TransactionList build');
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transaction added yet',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 10),
                Container(
                  height: constraints.maxWidth * .6,
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover),
                )
              ],
            );
          })
        // there is a bug with ListView.builder if use key
        // : ListView.builder(
        //     itemBuilder: (currentTransaction, index) {
        //       return TransactionItem(key: UniqueKey(), transaction: transactions[index], deleteTransaction: deleteTransaction);
        //     },
        //     itemCount: transactions.length,
        // );

        /**
         * Keys mostly need into when ListView with statefull children scenario, if chnage data internally
         */
        : ListView(
            children: transactions.map((currentTransaction) {
              return TransactionItem(
                  // ValueKey simply wraps a unique identifier by using id
                  key: ValueKey(currentTransaction.id),
                  transaction: currentTransaction,
                  deleteTransaction: deleteTransaction);
            }).toList(),
          );
  }
}
