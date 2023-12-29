import 'package:ace_app/pages/form.dart';
import 'package:flutter/material.dart';
import 'package:ace_app/components/bar_bottom.dart';
import 'package:ace_app/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isButton = false;
  int _currentIndex = 0;

  void updateButton(bool newState) {
    setState(() {
      isButton = newState;
    });
  }

  setCurrentIndex(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: [HomePage(), const FormPage()][_currentIndex],
          bottomNavigationBar: BottomNavigation(
            onIndexChanged: setCurrentIndex,
            currentIndex: _currentIndex,
          ),
        )
    );
  }
}
