import 'package:flutter/material.dart';

class DropdownRatingFormField extends StatefulWidget {
  final int maxRating;
  final String? Function(dynamic) validator;
  final void Function(int?) onChanged;

  DropdownRatingFormField({
    Key? key,
    required this.maxRating,
    required this.validator,
    required this.onChanged,
  }) : super(key: key);

  @override
  DropdownRatingFormFieldState createState() => DropdownRatingFormFieldState();
}

class DropdownRatingFormFieldState extends State<DropdownRatingFormField> {
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
        value: selectedValue,
        items: ratingMenuItems(maxRating: widget.maxRating),
        onChanged: widget.onChanged,
        decoration:
            InputDecoration(labelText: 'Rating', border: OutlineInputBorder()),
        validator: widget.validator);
  }

  List<DropdownMenuItem<int>> ratingMenuItems({required int maxRating}) {
    return List<DropdownMenuItem<int>>.generate(maxRating, (i) {
      return DropdownMenuItem<int>(value: i + 1, child: Text('${i + 1}'));
    });
  }
}
