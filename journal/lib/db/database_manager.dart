import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/screens/journal_entries.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:journal/widgets/journal_entry_form.dart';

void database() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), "journal.db"),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT, rating INTEGER, date TEXT)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  Future<void> insertEntry(JournalEntry journalentry) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'journalentry',
      journalentry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<JournalEntry>> journalentries() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('jouranlenty');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return JournalEntry(
        title: maps[i]['title'],
        body: maps[i]['body'],
        rating: maps[i]['rating'],
        date: maps[i]['date'],
      );
    });
  }
}
