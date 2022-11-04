import 'package:flutter/material.dart';
import '../screens/components/editEntry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import '../app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'models/journalEntryFields.dart';
import '../app.dart';

const deleteRowPath = "assets/deleteRow.txt";
const createSchemaPath = "assets/createSchema.txt";
const updateRowPath = "assets/updateRow.txt";


String singleTitle ="";
String singleBody = "";
String singleDate = "";
int? singleid;

void setValues (title, body, date, id){
  singleTitle = title;
  singleBody = body;
  singleDate = date;
  singleid = id;
}


class journal1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed:() {deleteEntry(context);},
          child: const Icon(Icons.delete_rounded),
          ),
        appBar: AppBar(title: Text('Journal Entry on ' + singleDate),),
        body: JournalEntryForm()
        );
  }
}

class JournalEntryForm extends StatefulWidget {
  @override 
  JournalEntryFormState createState() => JournalEntryFormState();
}

class JournalEntryFormState extends State<JournalEntryForm> {

  final formKey = GlobalKey<FormState>();
  final fields = JournalEntryFields();

  @override 
  Widget build (BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(

        key: formKey,

        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child:  Column(
        children: [

          TextFormField(
            initialValue: singleTitle,
            autofocus: false,
            decoration: InputDecoration(labelText: 'Title'),
            onSaved: (value) {
              fields.title = value;
            },
            validator: (value) {
              return value!.isEmpty ? "Please enter a title" : null;
            },
          ),

          TextFormField(
            initialValue: singleBody,
            maxLines: 7,
            autofocus: false,
            decoration: InputDecoration(labelText: 'Body'),
            onSaved: (value) {
              fields.body = value;
            },
            validator: (value) {
              return value!.isEmpty ? "Please enter a body" : null;
            },
          ),

          ElevatedButton(
            onPressed: () async {

              String schemaString = await rootBundle.loadString(createSchemaPath);
              String updateRow = await rootBundle.loadString(updateRowPath);

              if (formKey.currentState!.validate()){

                formKey.currentState!.save();
                fields.dateTime = DateTime.now().toString();
                //await deleteDatabase('journal.sqlite3.db');

                final Database database = await openDatabase(
                  'journal.sqlite3.db', version: 1, onCreate: 
                  (Database db, int version) async {
                    await db.execute(schemaString);}
                );

                await database.transaction( (txn) async {
                  await txn.rawInsert(updateRow,
                  [fields.title, fields.body, singleid]);
                });

                await database.close();

                MyAppState? aState = context.findAncestorStateOfType<MyAppState>();
                aState!.update();

                Navigator.of(context).pop();
              }
            }, 
            child: Text('Update Entry')
            ),
            
        ]
        )
          )
      ),
      )
    );
  }
}//------------------------------
class singleJournalEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Journal Entry on ' +  singleDate)),
        body: Column( 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(padding: EdgeInsets.all(20), 
            child: Text(singleTitle, style: TextStyle(fontSize: 40),),),

            Padding(padding: EdgeInsets.all(20), 
            child: Text(singleBody, style: TextStyle(fontSize: 20)),), 

            Padding(padding: EdgeInsets.all(20), 
            child: 
              GestureDetector(
                onTap: (() {deleteEntry(context);}),
                child: Icon(Icons.delete),
            ),
            
            
            )

          ])
        );
  }
}

void deleteEntry(context) async {

      String deleteRow = await rootBundle.loadString(deleteRowPath);
      String schemaString = await rootBundle.loadString(createSchemaPath);

      final Database database = await openDatabase(
        'journal.sqlite3.db', version: 1, onCreate: 
        (Database db, int version) async {
          await db.execute(schemaString);}
      );

      await database.transaction( (txn) async {
        await txn.rawInsert(deleteRow,
        [singleid]);
      });

      await database.close();

      MyAppState? aState = context.findAncestorStateOfType<MyAppState>();
      aState!.update();

      Navigator.of(context).pop();

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
          
          ]
      );
  }
}
