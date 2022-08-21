import 'package:flutter/material.dart';

Widget hori_entry() {
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
  );
}
