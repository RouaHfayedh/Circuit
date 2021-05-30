import 'package:flutter/material.dart';

import 'UI/Screens/homePage.dart';

void main() {
  runApp(MyApp());
}

const kApiKey =
    'pk.eyJ1IjoiN2FtbWEiLCJhIjoiY2tuMGw1MTU4MHAxbjJ0bGVqZm85bGo2NSJ9.VChadkXvg2NY4fDi-ZCWQg';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    assert(kApiKey != 'YOUR_API_KEY',
        "You must provide an API Key in order to run this example.");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Transpori.tn'),
    );
  }
}
