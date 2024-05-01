import 'package:ace_app/database/ace_database.dart';
import 'package:flutter/material.dart';
import 'package:ace_app/pages/home.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await ACEDatabase.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ACEDatabase(), 
      child: const MyApp()
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}
