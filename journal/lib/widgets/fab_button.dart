import 'package:flutter/material.dart';
import 'package:journal/screens/new_entry.dart';

class DisplayFormButton extends StatelessWidget {
  const DisplayFormButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 180, 73, 108),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const NewEntry()));
      },
      child: const Icon(Icons.add),
    );
  }
}
