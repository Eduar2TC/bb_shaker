import 'package:baby_shaker/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baby shaker',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.lightBlue,
          backgroundColor: Colors.lightBlueAccent,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        listTileTheme: const ListTileThemeData(
          tileColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
          selectedTileColor: Colors.blue,
          titleAlignment: ListTileTitleAlignment.center,
          contentPadding: EdgeInsets.all(10),
        ),
      ),
      home: const HomePage(),
    );
  }
}
