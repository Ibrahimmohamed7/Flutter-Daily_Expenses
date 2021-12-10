import 'dart:math';

import 'package:daily_expenses/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TransactionItems extends StatefulWidget {

  final Transaction transaction ;
  final Function deletTx;

  const TransactionItems({
    Key key,
   @required this.transaction,
    @required this.deletTx,
  }) : super(key: key);

  @override
  _TransactionItemsState createState() => _TransactionItemsState();
}

class _TransactionItemsState extends State<TransactionItems> {

  Color _bgColor;
  @override
  void initState(){
    const avilableColors = [Colors.red,Colors.blue,Colors.black,Colors.purple];
      _bgColor = avilableColors[Random().nextInt(4)];
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
                child: Text('\$${widget.transaction.amount}')
            ),
          ),
        ),
        title: Text(widget.transaction.title,),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date),),
        trailing: MediaQuery.of(context).size.width > 460 ?
        FlatButton.icon(
            label: Text('Delete') ,
            textColor: Colors.red ,
            icon: Icon(Icons.delete, color: Colors.red,),
            onPressed: (){
              widget.deletTx(widget.transaction.id);
            }
        )
            :IconButton(
          icon: Icon(Icons.delete, color: Colors.red,),
          onPressed: (){
            widget.deletTx(widget.transaction.id);
          },
        ),
      )
    );
  }
}
