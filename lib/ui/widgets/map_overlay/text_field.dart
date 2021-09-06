import 'package:flutter/material.dart';

class TextFieldMapOverlay extends StatelessWidget {
  const TextFieldMapOverlay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Praha',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
        ),
      ),
    );
  }
}
