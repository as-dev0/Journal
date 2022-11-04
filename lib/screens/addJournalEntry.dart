import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'models/journalEntryFields.dart';
import '../app.dart';

const createSchemaPath = "assets/createSchema.txt";
const insertRowPath = "assets/insertRow.txt";

class journal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Journal Entry'),),
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
            autofocus: true,
            decoration: InputDecoration(labelText: 'Title'),
            onSaved: (value) {
              fields.title = value;
            },
            validator: (value) {
              return value!.isEmpty ? "Please enter a title" : null;
            },
          ),

          TextFormField(
            maxLines: 7,
            autofocus: true,
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
              String insertRow = await rootBundle.loadString(insertRowPath);

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
                  await txn.rawInsert(insertRow,
                  [fields.title, fields.body, fields.dateTime]);
                });

                await database.close();

                MyAppState? aState = context.findAncestorStateOfType<MyAppState>();
                aState!.update();

                Navigator.of(context).pop();
              }
            }, 
            child: Text('Save Entry')
            )
        ]
        )
          )
      ),
      )
    );
  }
}