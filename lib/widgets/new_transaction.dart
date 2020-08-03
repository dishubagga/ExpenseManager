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

  DateTime _selectedDate;

  void _submitData(BuildContext context) {
    final enteredTitle =
        (_titleController.text.isNotEmpty) ? _titleController.text : "";
    final enteredAmount = (_amountController.text.isNotEmpty)
        ? double.parse(_amountController.text)
        : 0;
    final trxDate = (_selectedDate == null) ? null : _selectedDate;
    if (enteredTitle.isEmpty || enteredAmount <= 0 || trxDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, trxDate);

    Navigator.of(context).pop();
  }

  _presentDatePicker(BuildContext ctx) {
    showDatePicker(
      context: ctx,
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
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                //keyboardType: num,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                      onPressed: () => _presentDatePicker(context),
                      child: Text(_selectedDate == null
                          ? "No date choosen"
                          : DateFormat.yMd().format(_selectedDate))
                      //textColor: Theme.of(context).accentColor,
                      ),
                  RaisedButton(
                    onPressed: () => _submitData(context),
                    child: Text(
                      "ADD ITEM",
                      style: TextStyle(fontSize: 15),
                    ),
                    //textColor: Theme.of(context).accentColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
