import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:sqflite/sqflite.dart';
import 'package:journal/widgets/fab_button.dart';
import 'package:journal/widgets/drawer_with_theme_settings.dart';

//Display the details of the journal entry, including its title, body, date
//and numeric rating, when tapped on in the list.

class EntryDetails extends StatelessWidget {
  final List<dynamic> entry;
  final int i;
  const EntryDetails({Key? key, required this.entry, required this.i})
      : super(key: key);

  static const routeName = '/entry_details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(entry[i].getTitle()),
        ),
        body: Column(
          children: [
            Center(
              child: Text(
                entry[i].getDate(),
                style: TextStyle(height: 3, letterSpacing: 7, fontSize: 20),
              ),
            ),
            SizedBox(
                height: 35,
                child: Text(
                  entry[i].getRating(),
                  style: const TextStyle(fontSize: 18),
                )),
            Text(entry[i].getBody(), style: TextStyle(fontSize: 18)),
          ],
        ));
  }
}
