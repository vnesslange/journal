import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/screens/journal_entries.dart';
import 'package:journal/widgets/dropdown_rating_form_field.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

const CREATE_TABLE = 'assets/schema_1.sql.txt';
const INSERT = 'assets/schema_4.sql.txt';

class JournalEntryForm extends StatefulWidget {
  const JournalEntryForm({Key? key}) : super(key: key);

  @override
  _JournalEntryFormState createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final formKey = GlobalKey<FormState>();
  int? myRating;
  final myTitle = TextEditingController();
  final myBody = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  static final routes = {
    EntriesList.routeName: (context) => EntriesList(),
  };

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myTitle.dispose();
    myBody.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                    labelText: 'Title', border: OutlineInputBorder()),
                controller: myTitle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                    labelText: 'Body', border: OutlineInputBorder()),
                controller: myBody,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              DropdownRatingFormField(
                  maxRating: 4,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter a rating';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() => myRating = value);
                  }),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      var toInsert = JournalEntry(
                          title: myTitle.text,
                          body: myBody.text,
                          rating: myRating,
                          date: DateTime.now());
                      final Database database = await openDatabase("journal.db",
                          version: 1, onCreate: (Database db, version) async {
                        // Run the CREATE TABLE statement on the database.
                        String createTable =
                            await rootBundle.loadString(CREATE_TABLE);
                        await db.execute(
                          createTable,
                        );
                      });
                      await database.transaction(((txn) async {
                        String insertInto = await rootBundle.loadString(INSERT);
                        await txn.rawInsert(insertInto, [
                          toInsert.title,
                          toInsert.body,
                          toInsert.rating,
                          formatter.format(toInsert.date)
                        ]);
                      }));
                      await database.close();
                      displayEntries(context);
                    }
                  },
                  child: const Text('Save Entry')),
            ],
          )),
    );
  }
}

void displayEntries(BuildContext context) {
  Navigator.pushNamed(context, EntriesList.routeName);
}
