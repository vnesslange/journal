import 'dart:ffi';
import 'package:journal/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:journal/screens/journal_entries.dart';
import 'package:journal/screens/entry_details.dart';
import 'package:journal/widgets/detail_hori.dart';
import 'package:journal/widgets/hori_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:journal/widgets/drawer_with_theme_settings.dart';

class MyApp extends StatefulWidget {
  final SharedPreferences preferences;

  MyApp({Key? key, required this.preferences}) : super(key: key);
  static ValueNotifier<bool> notify = ValueNotifier(false);
  static bool checkTog = false;

  static final routes = {
    EntriesList.routeName: (context) => EntriesList(),
    EntryDetails.routeName: (context) => EntryDetails(
          entry: EntriesList.ofEntries,
          i: EntriesList.theIndex,
        ),
  };

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const THEME_MODE_KEY = 'theme';
  static const TOGGLE_KEY = 'toggle';

  String? get darkMode =>
      widget.preferences.getString(THEME_MODE_KEY) ?? 'light';

  bool get toggle => widget.preferences.getBool('toggle') ?? false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        builder: (BuildContext context, value, child) {
          return MaterialApp(
            theme: getMode(darkMode),
            routes: MyApp.routes,
            initialRoute: EntriesList.routeName,
            home: Scaffold(
              body: LayoutBuilder(builder: mainLayout),
            ),
          );
        },
        valueListenable: MyApp.notify);
  }

  void pushEntries(BuildContext context) {
    Navigator.of(context).pushNamed(EntriesList.routeName);
  }

  ThemeData getMode(darkMode) {
    if (darkMode == 'light') {
      MyApp.checkTog = false;
      return ThemeData.light();
    } else {
      MyApp.checkTog = true;
      return ThemeData.dark();
    }
  }

  Widget mainLayout(BuildContext context, BoxConstraints constraints) {
    if (constraints.maxWidth > 800) {
      return HorizontalLayout();
    } else {
      return const EntriesList();
    }
  }
}

class HorizontalLayout extends StatelessWidget {
  final widgets = [
    Expanded(
      child: hori_entry(),
    ),
    Expanded(child: detais_hori()),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(children: widgets);
  }
}
