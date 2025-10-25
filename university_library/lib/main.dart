// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const UniversityLibraryApp());
}

class UniversityLibraryApp extends StatelessWidget {
  const UniversityLibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Library',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     
    );
  }
}

