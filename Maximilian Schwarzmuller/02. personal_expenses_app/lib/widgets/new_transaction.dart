import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    // get data before submit
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    // by calling widget we can access the original class property, it is only for stateful class
    widget.addTransaction(enteredTitle, enteredAmount,_selectedDate);

    // here context is a class property
    Navigator.of(context).pop();
  }

  void _presentdatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              style: Theme.of(context).textTheme.headline4,
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (value) {
              //   titleInput = value;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              style: Theme.of(context).textTheme.headline4,
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 76,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentdatePicker,
                    child: Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            // FlatButton(
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text('Add Transaction'),
              // textColor: Colors.white,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }
}
