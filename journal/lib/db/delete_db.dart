import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

delete() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'journal.db');

// Delete the database
  await deleteDatabase(path);
}
