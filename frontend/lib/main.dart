import 'package:flutter/material.dart';
import 'package:frontend/screens/first_page.dart';
import 'package:frontend/screens/user/notification_screen.dart';
import 'package:frontend/screens/user/report_step1_water_type.dart';
import 'package:frontend/screens/user/report_step2_location.dart';
import 'package:frontend/screens/user/report_step3_submitted.dart';
import 'screens/admin/admin_home_screen.dart';
import 'package:frontend/screens/user/user_water_tips.dart';
import 'package:frontend/screens/user/user_home_screen.dart';

import 'screens/signup_screen.dart';
import 'screens/admin/admin_water_tips.dart';
import 'screens/admin/admin_report_detail.dart';
import 'screens/login_screen.dart';
import 'screens/profile.dart';

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
        '/profile': (context) => const ProfilePage(),
        '/signup': (context) => const SignupScreen(),

        //user
        '/userhome': (context) => const UserHomeScreen(),
        '/reportStep1': (context) => const ReportStep1WaterType(),
        '/reportStep2':
            (context) => const ReportStep2Location(
              waterType: '',
              details: '',
              customWaterType: '',
            ),
        '/reportStep3': (context) => const ReportStep3Submitted(reportData: {}),
        // '/usernoti': (context) => const NotificationScreen(),
        '/usertips': (context) => const UserTipsScreen(),

        //admin
        '/adminhome': (context) => const AdminHomeScreen(),
        '/adminreport': (context) => const AdminReportDetailScreen(status: ''),
        '/admintips': (context) => const AdminTipsScreen(),
      },
    );
  }
}
