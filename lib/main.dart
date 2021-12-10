import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:daily_expenses/widgets/chart.dart';
import 'package:daily_expenses/widgets/new_transaction.dart';
import 'package:daily_expenses/widgets/transaction_list.dart';
import 'model/transaction.dart';

void main() {
 /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'ViaodaLibire',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 final List<Transaction> _transactions = [
   /* Transaction(
      id:'t1',
      title:'New Shoes',
      amount:69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id:'t2',
      title:'Weekly Groceries ',
      amount:16.53,
      date: DateTime.now(),
    )*/
  ] ;

 bool _showChart = false;


 @override
  Widget build(BuildContext context) {
   var mediaQuery = MediaQuery.of(context);
   final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

   final PreferredSizeWidget appBar = Platform.isIOS? CupertinoNavigationBar(
     middle: Text("Personal Expenses"),
     trailing: Row(
       mainAxisSize: MainAxisSize.min,
       children: [
          GestureDetector(
            onTap:  (){showAddNewTransaction(context);},
            child: Icon(CupertinoIcons.add),
          )
       ],
     ) ,
   ) :AppBar(
      title: Text("Personal Expenses"),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: (){showAddNewTransaction(context);}
        )
      ],
    );

    final scaffoldBody = SafeArea(child:SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if(isLandscape) Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Show Chart",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
              ),),
              Switch.adaptive(
                  value: _showChart,
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (val){
                    setState(() {
                      _showChart = val;
                    });
                  }
              )
            ],
          ),
          if (isLandscape) _showChart ? Container(
              height: (mediaQuery.size.height
                  -appBar.preferredSize.height
                  -mediaQuery.padding.top)*0.7,
              child: Chart(_recentTransactions)
          ):
          Container(
              height: (mediaQuery.size.height
                  -appBar.preferredSize.height
                  -mediaQuery.padding.top)*0.7,
              child: Transaction_List(_transactions,_deleteTransaction)
          ),

          if (!isLandscape)  Container(
              height: (mediaQuery.size.height
                  -appBar.preferredSize.height
                  -mediaQuery.padding.top)*0.3,
              child: Chart(_recentTransactions)
          ),
          if(!isLandscape) Container(
              height: (mediaQuery.size.height
                  -appBar.preferredSize.height
                  -mediaQuery.padding.top)*0.7,
              child: Transaction_List(_transactions,_deleteTransaction)
          ),
        ],
      ),
    ));
    return Platform.isIOS? CupertinoPageScaffold(
      navigationBar: appBar ,
      child: scaffoldBody,
    ):Scaffold(
      appBar: appBar,
      floatingActionButton: Platform.isIOS ? Container() :FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){showAddNewTransaction(context);},
      ),
      body: scaffoldBody,
    );
  }

 void _addNewTransaction(String title ,double amount, DateTime date){

   final newTx = Transaction(
       id: DateTime.now().toString(),
       title: title,
       amount: amount,
       date: date,
   );
   setState(() {
     _transactions.add(newTx);
   });
   Navigator.of(context).pop();
 }

 void _deleteTransaction(String id){
   setState(() {
     _transactions.removeWhere((tx){
       return tx.id == id ;
     });
   });
 }

 void showAddNewTransaction(BuildContext context){
   showModalBottomSheet(
       context: context ,
       builder: (_){
         return New_Transaction(_addNewTransaction) ;
       }
   );
 }

 List<Transaction> get _recentTransactions{
   return _transactions.where((tx){
     return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
   }).toList();
 }
}


