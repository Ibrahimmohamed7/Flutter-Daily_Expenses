import 'package:daily_expenses/model/transaction.dart';
import 'package:daily_expenses/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction_List extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deletTx;
  Transaction_List(this.transactions,this.deletTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: transactions.isEmpty ? LayoutBuilder(
            builder: (context,constraints){
              return Column(children: [
                Text(
                  "No Transactions",
                  style: TextStyle(fontSize: 20,color: Colors.red),
                ),
                SizedBox(height: 10,),
                Container(
                    height: constraints.maxHeight*0.6,
                    child: Image.asset(
                      "assets/images/Bebo.jpg",
                      fit: BoxFit.cover,
                    )
                )
              ],
              );
            }):
        ListView(
          children: transactions.map((tx) => TransactionItems(
              key: ValueKey(tx.id),
              transaction: tx,
              deletTx: deletTx
          )).toList(),
        )
      );

  }





}