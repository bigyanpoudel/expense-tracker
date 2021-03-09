import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_flat_button.dart';

class AddTransaction extends StatefulWidget {
  final Function addnewTransaction;
  AddTransaction(this.addnewTransaction);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate;
  void submitData() {
    if (_amountController.text == null) {
      return;
    }
    final addedTitle = _titleController.text;
    final addedAmount = double.parse(_amountController.text);
    if (addedTitle.isEmpty || addedAmount <= 0 || _selectedDate == null) {
      return;
    }
    //to access parent properties we use widget in stateFullwidget
    widget.addnewTransaction(addedTitle, addedAmount, _selectedDate);
//it basically closes the top most model screen form the screen after we submit the data;
//context and widget are speciall property due to extends state;
    Navigator.of(context).pop();
  }

//adding date picker
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = selectedDate;
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
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom +
                10, //inorder to prevent model overlap form the keybord
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.text_fields,
                  ),
                  //its works as same as oulinedInputDecoration as bello
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  labelStyle: TextStyle(fontSize: 20),
                  labelText: 'Title',
                  enabledBorder: OutlineInputBorder(
                      //we casn use errorBorder for errors
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      gapPadding: 50 //provide label a padding
                      ),
                ),
                controller: _titleController,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => submitData(),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.money),
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.greenAccent,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: 'please enter amount',
                  helperStyle: TextStyle(fontSize: 20),
                  labelStyle: TextStyle(fontSize: 20),
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
                //onChanged: (val)=> amountInput=val,
              ),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate != null
                          ? 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'
                          : 'No date selected'),
                    ),
                    //flatbutton
                    AdaptiveFlatButton(text: 'Choose Date', pressHandler: _showDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                  onPressed: submitData
                  //(){
                  //due to anonymous function we can pass value to the function rather then reference
                  //addnewTransaction(titleController.text,
                  //  double.parse(amountController.text));
                  //}
                  ,
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: Text(
                    'Add Trasaction',
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
