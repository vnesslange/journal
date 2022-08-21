import 'package:flutter/material.dart';

Widget detais_hori() {
  return Scaffold(
      appBar: AppBar(
        title: Text('entry[i].getTitle()'),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'entry[i].getDate()',
              style: TextStyle(height: 3, letterSpacing: 7, fontSize: 20),
            ),
          ),
          SizedBox(
              height: 35,
              child: Text(
                'entry[i].getRating()',
                style: const TextStyle(fontSize: 18),
              )),
          Text('entry[i].getBody(), style: TextStyle(fontSize: 18)'),
        ],
      ));
}
