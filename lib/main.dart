import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/view/home.ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amiibo Responsive App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePageUI(title: 'Amiibo App'),
    );
  }
}
