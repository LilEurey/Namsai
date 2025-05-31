import 'package:flutter/material.dart';
import 'package:frontend/screens/first_page.dart';
import 'package:frontend/screens/user/notification_screen.dart';
import 'package:frontend/screens/user/report_step1_water_type.dart';
import 'package:frontend/screens/user/report_step2_location.dart';
import 'package:frontend/screens/user/report_step3_submitted.dart';
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
        '/reportStep1': (context) => const ReportStep1WaterType(),
        '/reportStep2':
            (context) => const ReportStep2Location(waterType: '', details: ''),
        '/reportStep3': (context) => const ReportStep3Submitted(reportData: {}),
        '/usernoti': (context) => const NotificationScreen(),
        '/uservideotips': (context) => const NotificationScreen(),
        '/userinfographictips': (context) => const NotificationScreen(),
        '/userprofile': (context) => const NotificationScreen(),
      },
    );
  }
}
