import 'package:flutter/material.dart';
import 'package:journal/screens/journal_entries.dart';
import 'package:journal/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerSettings extends StatefulWidget {
  const DrawerSettings({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerSettings> createState() => _DrawerSettingsState();
}

class _DrawerSettingsState extends State<DrawerSettings> {
  static const THEME_MODE_KEY = 'theme';
  static const TOGGLE_KEY = 'toggle';

  void initState() {
    super.initState();
  }

  String darkMode = 'light';
  bool toggle = MyApp.checkTog;

  void initChange(bool value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (value == true) {
      darkMode = 'dark';
      toggle = true;
    } else {
      darkMode = 'light';
      toggle = false;
    }
    await preferences.setString(THEME_MODE_KEY, darkMode);
    await preferences.setBool(TOGGLE_KEY, toggle);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const SizedBox(
          height: 130,
          child: DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 24, 58, 86)),
            child: (Text('Settings', style: TextStyle(fontSize: 20))),
          ),
        ),
        SwitchListTile(
            title: const Text('Dark Mode'),
            secondary: const Icon(Icons.dark_mode),
            value: toggle,
            onChanged: (bool value) {
              setState(() {
                toggle = value;
              });
              initChange(value);
              MyApp.notify.value = value;
            }),
      ],
    ));
  }
}
