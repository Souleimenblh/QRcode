import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.green[50], 
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green, 
          titleTextStyle: TextStyle(
            color: Colors.white, 
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.green[800], 
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: MainScreen(),
    );
  }
}
