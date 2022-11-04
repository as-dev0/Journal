import 'package:call_me_maybe/screens/displaySingleJournalEntry.dart';
import 'package:flutter/material.dart';
import 'screens/addJournalEntry.dart';
import 'screens/components/toggleMode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/mainScreen.dart';
import 'package:sqflite/sqflite.dart';

class MyApp extends StatefulWidget{
  @override 
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  var darkMode = false;

  void initState(){
    print("init state");
    super.initState();
    //darkMode = false;
    initDarkMode("0");
  }

  void initDarkMode(val) async{
    print("initDarkMode");
    print("------------");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (val == "0"){
      setState(() {darkMode = prefs.getBool("darkMode") ?? false;}) ;
      }
    else { //updating the darkMode value
      print(val);
      prefs.setBool("darkMode",val);
      setState(() {darkMode = val;}); 
    }
    print("------------");
    //await deleteDatabase('journal.sqlite3.db');
  }

  void update(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("inside build. darkmode=");
    print("------------");
    print(darkMode);
    print("------------");
      return MaterialApp(
        title: 'Flutter Demo',
        home: ScaffoldController(),
        theme: darkMode == false ? ThemeData.light() : ThemeData.dark(),
      );
  }
}


class ScaffoldController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: drawerSettings(),
        appBar: AppBar(
          title: Text('Journal'),
          ),
        body: Container(
          child: LayoutBuilder(builder: (context, constraints){
            return constraints.maxWidth < 600 ? VerticalLayout() : HorizontalLayout();
          },)
        ) ,
        floatingActionButton: FloatingActionButton(
          onPressed:() {goToAddEntry(context);},
          child: const Icon(Icons.add),
          ),
        );
        
  }
}

class VerticalLayout extends StatelessWidget{

    @override 
  Widget build(BuildContext context) {
    print("Displaying vertical");
    return listJournalEntries();
  }
}

class HorizontalLayout extends StatefulWidget{
  @override 
  HorizontalLayoutState createState() => HorizontalLayoutState();
}

class HorizontalLayoutState extends State<HorizontalLayout>{

  void update() {setState(() {});}

  @override 
  Widget build(BuildContext context) {
    print("Displaying horizontal");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
      children: [
        Expanded(child: listJournalEntriesHorizontal()),
        Expanded(child: singleJournalEntryHorizontal()),
      ],
    );
  }
}

void goToAddEntry(BuildContext context){
	Navigator.of(context).push(MaterialPageRoute(builder: (context) => journal()));
}