import 'package:journal/models/journal_entry.dart';

class Journal {
  final List items;

  Journal({required this.items});

  List getList() {
    return items;
  }
}
