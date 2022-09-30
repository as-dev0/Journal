import 'package:flutter/material.dart';
import '../../app.dart';

class drawerSettings extends StatefulWidget{
  @override 
  drawerSettingsState createState() => drawerSettingsState();
}


class drawerSettingsState extends State<drawerSettings> {
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
            )
            ],
        ),
    );
  }
}
