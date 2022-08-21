import 'package:flutter/material.dart';
import 'package:journal/widgets/journal_entry_form.dart';

class NewEntry extends StatelessWidget {
  const NewEntry({Key? key}) : super(key: key);

  static const routeName = 'new';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Journal Entry'),
        ),
        body: Center(
          child: JournalEntryForm(),
        ));
  }
}
