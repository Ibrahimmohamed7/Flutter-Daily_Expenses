
import 'dart:io';

import 'package:daily_expenses/widgets/adaptive_flat_Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class New_Transaction extends StatefulWidget {
  final Function addTx ;

  New_Transaction(this.addTx);

  @override
  _New_TransactionState createState() => _New_TransactionState();
}

class _New_TransactionState extends State<New_Transaction> {

  TextEditingController title = TextEditingController();
  TextEditingController amount = TextEditingController();
  DateTime _selectedDate ;



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10 ,
              right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10 ,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: title,

              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amount,
                keyboardType: TextInputType.number,

              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(_selectedDate == null ? 'No Date Chosen':DateFormat.yMd().format(_selectedDate))
                    ),
                    AdaptiveFlatButton('Choose Date', _presentDatePicker),

                  ],
                ),
              ),
              RaisedButton(
                child: Text("Add Transaction"),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white ,
                onPressed: (){
                  onSubmitted();
                  } ,
              )
            ],
          ),
        ),
      ),
    ) ;
  }

  void onSubmitted(){
    if(title.text == null || double.parse(amount.text)<=0 || _selectedDate == null ){
      return ;
    }
    widget.addTx(
        title.text,
        double.parse(amount.text),
        _selectedDate
    );
  }

  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate == null){
        return;
      }
       setState(() {
         _selectedDate =  pickedDate ; 
       }); 
        
      
    });
  }
}
