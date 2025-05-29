import 'package:flutter/material.dart';
import 'package:frontend/screens/first_page.dart';
import 'screens/login_screen.dart';
import 'screens/user/user_home_screen.dart';

void main() {
  runApp(const NamSaiApp());
}

class NamSaiApp extends StatelessWidget {
  const NamSaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NamSai',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstPage(),
        '/login': (context) => const LoginScreen(),
        '/userhome': (context) => const UserHomeScreen(),
      },
    );
  }
}
