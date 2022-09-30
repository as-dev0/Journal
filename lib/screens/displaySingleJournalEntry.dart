import 'package:flutter/material.dart';

String singleTitle ="";
String singleBody = "";
String singleRating = "";
String singleDate = "";

void setValues (title, body, rating, date){
  singleTitle = title;
  singleBody = body;
  singleRating = rating;
  singleDate = date;
}


class singleJournalEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Journal Entry')),
        body: Column( 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.all(20), 
            child: Text(singleTitle, style: TextStyle(fontSize: 40),),),

            Padding(padding: EdgeInsets.all(20), 
            child: Text(singleBody, style: TextStyle(fontSize: 20)),), 

            Padding(padding: EdgeInsets.all(20), 
            child: Text(singleRating, style: TextStyle(fontSize: 20)),),

            Padding(padding: EdgeInsets.all(20), 
            child: Text(singleDate, style: TextStyle(fontSize: 20)),), 
          ])
        );
  }
}


class singleJournalEntryHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column( 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.all(20), 
            child: Text(singleTitle, style: TextStyle(fontSize: 40),),),

            Padding(padding: EdgeInsets.all(20), 
            child: Text(singleBody, style: TextStyle(fontSize: 20)),), 

            Padding(padding: EdgeInsets.all(20), 
            child: Text(singleRating, style: TextStyle(fontSize: 20)),),
            
            Padding(padding: EdgeInsets.all(20), 
            child: Text(singleDate, style: TextStyle(fontSize: 20)),),]);
  }
}
