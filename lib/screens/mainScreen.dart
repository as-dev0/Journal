import 'package:call_me_maybe/app.dart';
import 'package:call_me_maybe/screens/addJournalEntry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'displaySingleJournalEntry.dart';

const createSchemaPath = "assets/createSchema.txt";

class listJournalEntries extends StatefulWidget{
  @override 
  listJournalEntriesState createState() => listJournalEntriesState();
}

class listJournalEntriesState extends State<listJournalEntries>{

  var journalEntries = [];

  @override 
  void initState(){
    super.initState();
    loadJournal();
  }

  @override 
  Widget build (BuildContext context){

    loadJournal();
    
    if (journalEntries.length == 0){
      return Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Icon(Icons.book,size:60), 
            Padding (padding: EdgeInsets.all(5),child: Text("Journal"),)],
            ) 
          );

    } else {
      return Container(
        child: ListView.builder(

          itemCount: journalEntries.length, itemBuilder: (context, index){

          return GestureDetector(
            onTap: (() {goToSingleEntry(
              journalEntries[index][0], 
              journalEntries[index][1], 
              journalEntries[index][2].substring(0,10) ,
              journalEntries[index][3]);}),
            child: ListTile(
            trailing: Icon(Icons.more_horiz),
            title: Text(journalEntries[index][0] ),
            subtitle: Text(journalEntries[index][2].substring(0,10)))
          );
        })
      );
    }
  }
// changed ---------------------------------------------------------------<<<<<<<<<<<<<<<<<<<<<
  void goToSingleEntry(title, body, date, id){

    setValues(title, body, date, id);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => journal1()
    ));
  }

  void loadJournal () async {

    String schemaString = await rootBundle.loadString(createSchemaPath);

    final Database database = await openDatabase(
      'journal.sqlite3.db', version: 1, onCreate: 
      (Database db, int version) async {
        await db.execute(schemaString);
      }
    );

    List<Map> journalRecords = await database.rawQuery('SELECT * FROM journal_entries');

    var journalEntriesDummy = journalRecords.map((record) {
      return [record['title'], record['body'], record['date'], record['id']];
    } ).toList();

    if (this.mounted){
      setState(() {
        journalEntries = journalEntriesDummy;
      });
    }

  }
}


class listJournalEntriesHorizontal extends StatefulWidget{
  @override 
  listJournalEntriesStateHorizontal createState() => listJournalEntriesStateHorizontal();
}

class listJournalEntriesStateHorizontal extends State<listJournalEntriesHorizontal>{

  var journalEntries = [];

  @override 
  void initState(){
    super.initState();
    loadJournal();
  }

  @override 
  Widget build (BuildContext context){

    loadJournal();
    
    if (journalEntries.length == 0){
      return Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Icon(Icons.book,size:60), 
            Padding (padding: EdgeInsets.all(5),child: Text("Journal"),)],
            ) 
          );

    } else {

      return Container(
        child: ListView.builder(

          itemCount: journalEntries.length, itemBuilder: (context, index){
          return GestureDetector(
            onTap: (() {updateSingleEntry(
              journalEntries[index][0], 
              journalEntries[index][1], 
              journalEntries[index][2].substring(0,10),
              journalEntries[index][3] );}),
            child: ListTile(
            trailing: Icon(Icons.more_horiz),
            title: Text(journalEntries[index][0] ),
            subtitle: Text(journalEntries[index][2].substring(0,10)))
          );
        })
      );
    }
  }

  void updateSingleEntry(title, body, date, id){
    setValues(title, body, date, id);
    HorizontalLayoutState? hLayout = context.findAncestorStateOfType<HorizontalLayoutState>();
    hLayout!.update();
  }

  void loadJournal () async {

    String schemaString = await rootBundle.loadString(createSchemaPath);

    final Database database = await openDatabase(
      'journal.sqlite3.db', version: 1, onCreate: 
      (Database db, int version) async {
        await db.execute(schemaString);
      }
    );

    List<Map> journalRecords = await database.rawQuery('SELECT * FROM journal_entries');

    var journalEntriesDummy = journalRecords.map((record) {
      return [record['title'], record['body'], record['date']];
    } ).toList();

    if (this.mounted){
      setState(() {
        journalEntries = journalEntriesDummy;
      });
    }
  }
}