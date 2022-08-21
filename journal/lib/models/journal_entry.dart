import 'package:intl/intl.dart';

// object with an id (an int), title (a string), body (string),
// rating (int), date (date time)

class JournalEntry {
  final String title;
  final String body;
  final int? rating;
  final DateTime date;

  JournalEntry({
    required this.title,
    required this.body,
    required this.rating,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {'title': title, 'body': body, 'rating': rating, 'date': date};
  }

  String getTitle() {
    return title;
  }

  String getBody() {
    return body;
  }

  String getRating() {
    return rating.toString();
  }

  String getDate() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String dateText = formatter.format(date);
    return dateText;
  }
}
