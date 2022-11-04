import 'package:flutter/material.dart';
import '../../app.dart';

class editSettings extends StatefulWidget{
  @override 
  editSettingsState createState() => editSettingsState();
}

class editSettingsState extends State<editSettings> {
  @override
  Widget build(BuildContext context) {

    MyAppState? aState = context.findAncestorStateOfType<MyAppState>();

    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,

          children: [

            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Settings'),
            ),

            ListTile(
              title:  Row(
                children: [
                  const Text('Dark Mode'), 
                  Switch(value: aState!.darkMode, 
                        onChanged: (value) => aState.initDarkMode(value))
                  ])  , 
            ),

            ListTile()
            ],
        ),
    );
  }
}