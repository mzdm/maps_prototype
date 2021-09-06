import 'package:flutter/material.dart';
import 'package:maps_prototype/ui/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loono Maps Playground',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(190, 88, 23, 1),
      ),
      home: HomeScreen(),
    );
  }
}
