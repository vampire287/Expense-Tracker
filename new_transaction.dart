// ignore_for_file: deprecated_member_use, unnecessary_null_comparison
import 'dart:io';
import 'package:basic_expense_tracker/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  // ignore: prefer_const_constructors_in_immutables
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val){
                //   titleInput=val,
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged:(val){
                //   amountInput=val,
                // },
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveFlatButton('Choose Date',_presentDatePicker)
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  onSurface: Theme.of(context).textTheme.button?.color,
                ),
                onPressed: _submitData,
                child: const Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
