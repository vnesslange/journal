import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/screens/welcome.dart';
import 'package:sqflite/sqflite.dart';
import 'package:journal/widgets/fab_button.dart';
import 'package:journal/widgets/drawer_with_theme_settings.dart';
import 'package:journal/screens/entry_details.dart';
//Display a list of existing journal entries, by displaying the title and date
//of the journal entry.

const CREATE_TABLE = 'assets/schema_1.sql.txt';
const SELECT = 'assets/schema_2.sql.txt';
const DELETE = 'assets/schema_3.sql.txt';

class EntriesList extends StatefulWidget {
  const EntriesList({Key? key}) : super(key: key);

  static const routeName = '/journal_entries';
  static List ofEntries = [];
  static int theIndex = 0;

  @override
  EntrieState createState() => EntrieState();
}

class EntrieState extends State<EntriesList> {
  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  List myEntries = [];
  int index = 0;

  void loadJournal() async {
    String createTable = await rootBundle.loadString(CREATE_TABLE);
    final Database database = await openDatabase("journal.db", version: 1,
        onCreate: (Database db, version) async {
      await db.execute(createTable);
    });

    deleteEntry(int id) async {
      String deleteEntryFromTable = await rootBundle.loadString(DELETE);
      await database.rawQuery(deleteEntryFromTable, [id]);
    }

    String selectEntry = await rootBundle.loadString(SELECT);
    List<Map> journalRecords = await database.rawQuery(selectEntry);
    final journalEntries = journalRecords.map((record) {
      return JournalEntry(
          title: record['title'],
          body: record['body'],
          rating: record['rating'],
          date: DateTime.parse(record['date']));
    }).toList();
    setState(() {
      myEntries = journalEntries;
      index = journalEntries.length;
    });
  }

  Widget build(BuildContext context) {
    if (myEntries.isEmpty) {
      return const Scaffold(body: WelcomeScreen());
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Journal Entries'),
          ),
          floatingActionButton: const DisplayFormButton(),
          endDrawer: const DrawerSettings(),
          body: Center(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: myEntries.length,
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                    textColor: const Color.fromARGB(255, 14, 61, 100),
                    shape: const Border(
                        bottom: BorderSide(
                            width: 5.0, color: Color.fromARGB(255, 24, 58, 86)),
                        top: BorderSide(
                            width: 5.0,
                            color: Color.fromARGB(255, 24, 58, 86))),
                    leading: const Icon(Icons.star_border_purple500),
                    tileColor: const Color.fromARGB(255, 165, 198, 213),
                    title: Text(myEntries[i].getTitle()),
                    subtitle: Text(myEntries[i].getDate()),
                    onTap: () {
                      EntriesList.theIndex = i;
                      EntriesList.ofEntries = myEntries;
                      Navigator.pushNamed(context, EntryDetails.routeName);
                    },
                  );
                }),
          ));
    }
  }
}
