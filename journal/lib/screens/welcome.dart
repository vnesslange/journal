import 'package:flutter/material.dart';
import 'package:journal/widgets/fab_button.dart';
import 'package:journal/widgets/drawer_with_theme_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to the Journal'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              "Journal",
              style: TextStyle(
                  fontSize: 50, color: Color.fromARGB(255, 54, 31, 101)),
            ),
          ),
          Icon(
            Icons.book,
            size: 100,
            color: Color.fromARGB(255, 37, 5, 100),
          ),
        ],
      ),
      floatingActionButton: const DisplayFormButton(),
      endDrawer: const DrawerSettings(),
    );
  }
}
