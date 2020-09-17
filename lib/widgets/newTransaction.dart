import 'dart:io';
import 'adaptive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selecteddate;

  void _submitData() {
    final eneterTitle = _titleController.text;
    final enterAmount = double.parse(_amountController.text);
    if (enterAmount <= 0 || eneterTitle.isEmpty || _selecteddate == null)
      return;

    widget.addTx(_titleController.text, double.parse(_amountController.text),
        _selecteddate);

    Navigator.of(context).pop();
  }

  void _precentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selecteddate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selecteddate == null
                          ? 'No Date Chosen'
                          : 'Picked Date: ${DateFormat.yMd().format(_selecteddate)}'),
                    ),
                    AdaptiveFlatButton('Choose Date', _precentDatePicker),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: RaisedButton(
                  onPressed: () {
                    _submitData();
                  },
                  child: Text('Add Transaction'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
