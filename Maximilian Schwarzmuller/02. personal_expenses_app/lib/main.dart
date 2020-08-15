import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';

// import './widgets/user_transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      title: 'Personal Expensess App',
      // colored the uncolored defauld widget
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // primaryColorDark: Colors.redAccent,
        // accentColor: Colors.green,
        // fontFamily: 'Quicksand',
        errorColor: Colors.red,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(color: Colors.white),
              headline6: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple),
              headline5: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              headline4: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
              headline3: TextStyle(color: Colors.purple, fontSize: 14),
              headline2: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              bodyText1: TextStyle(fontSize: 20),
              subtitle1: TextStyle(fontSize: 22),
              subtitle2: TextStyle(fontSize: 20),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                // title: TextStyle(
                //   fontFamily: 'OpenSans',
                //   fontSize: 25,
                // ),
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // final List<Transaction> transactions = [
  //   Transaction(
  //     id: 't1',
  //     title: 'New Shoes',
  //     amount: 69.66,
  //     date: DateTime.now(),
  //   ),
  //   Transaction(
  //     id: 't2',
  //     title: 'Weekly Groceries',
  //     amount: 99.66,
  //     date: DateTime.now(),
  //   )
  // ];

  // String titleInput;
  // String amountInput;

  // basically in stateless have to create a final property
  // but text input value always changed
  // so we can not do before as we use TextEditingController
  // final titleController = TextEditingController();
  // final amountController = TextEditingController();

  // Color _colorFromHex(String hexColor) {
  //   final hexCode = hexColor.replaceAll('#', '');
  //   return Color(int.parse('FF$hexCode',radix: 16));
  // }

  // Color color = _colorFromHex('#f4af01');

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddNewTransaction(BuildContext context) {
    // this is a default function provided by flutter
    showModalBottomSheet(
        context: context,
        builder: (_) {
          // for controlling click
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.66,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 99.66,
    //   date: DateTime.now(),
    // )
  ];

  // _recentTransactions is dynamically generated property
  List<Transaction> get _recentTransactions {
    // where is method iterate to all,
    // returna list that match the logic, if true then return that
    return _userTransactions.where((transaction) {
      // checking is it a from last week
      // only transaction that are youger than 7 days are inluded
      return transaction.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(
      String transactionTitle, double transactionAmount, DateTime chosenDate) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: transactionTitle,
      amount: transactionAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String transactionId) {
    setState(() {
      _userTransactions
          .removeWhere((transaction) => transaction.id == transactionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.add_box),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Card(
            //   color: Colors.amberAccent,
            //   child: Container(
            //     width: double.infinity,
            //     child: Text('CHART'),
            //   ),
            //   elevation: 5,
            // ),
            // another option
            // Container(
            //   width: double.infinity,
            //   child: Card(
            //     // color: new Color.fromRGBO(59, 89, 152, 1),
            //     child: Text('CHART'),
            //     elevation: 5,
            //   ),
            // ),
            Chart(_recentTransactions),
            // Card(
            //   color: Colors.red,
            //   child: Text('List of texes'),
            // )
            // UserTransactions()
            // Expanded does not work cause ListView has infinite height, but Expanded also try to get infinite height, but that would not possible 
            // Expanded(
            //   child: TransactionList(_userTransactions, _deleteTransaction),
            // )
             TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 40),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
