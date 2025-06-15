import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/widgets/user/bottom_nav_bar.dart';
import 'package:frontend/widgets/admin/bottom_nav_bar.dart' as admin;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const Color _darkBlue = Color(0xFF64B5F6);
  static const Color _lightBlue = Color(0xFFB3E5FC);

  String name = '';
  String email = '';
  String tel = '';
  String role = 'user';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final userRole = prefs.getString('userRole');

    if (userId == null) {
      setState(() => isLoading = false);
      return;
    }

    try {
      final res = await http.get(
        Uri.parse(
          'https://badeesorn.pawarisa.com/intproj/app4api/api/users/$userId',
        ),
      );

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        setState(() {
          name = data['name'] ?? '';
          email = data['email'] ?? '';
          tel = data['tel'] ?? '';
          role = userRole ?? 'user';
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      print('Error fetching user: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // กรณีจอเล็กจะเลื่อนขึ้นลงได้
        child: Column(
          children: [
            // 1) Banner ด้านบน ความสูง 160
            SizedBox(
              height: 160,
              width: double.infinity,
              child: Image.asset('assets/image/banner.png', fit: BoxFit.cover),
            ),

            const SizedBox(height: 16),

            // 3) ข้อมูลโปรไฟล์ + ปุ่ม Logout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  _buildInfoRow('Name', name),
                  _buildInfoRow('E-mail', email),
                  _buildInfoRow('Tel.', tel),
                  const SizedBox(height: 150),
                  Center(
                    child: OutlinedButton(
                      onPressed: () async {
                        await AuthService.logout();
                        if (!mounted) return;
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          (route) => false,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: _darkBlue, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                      ),

                      child: const Text(
                        'Log out',
                        style: TextStyle(
                          color: _darkBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),

      // 4) Bottom navigation bar แยก user/​admin
      bottomNavigationBar:
          role == 'admin'
              ? admin.BottomNavBar(
                currentIndex: 2,
                onTap: (index) {
                  if (index == 1) {
                    Navigator.pushNamed(context, '/adminhome');
                  } else if (index == 0) {
                    Navigator.pushNamed(context, '/admintips');
                  }
                },
              )
              : BottomNavBar(
                currentIndex: 2,
                onTap: (index) {
                  if (index == 1) {
                    Navigator.pushNamed(context, '/userHome');
                  } else if (index == 0) {
                    Navigator.pushNamed(context, '/usertips');
                  }
                },
              ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          Text(value, style: const TextStyle(fontSize: 16, color: _darkBlue)),
        ],
      ),
    );
  }
}

/// คลิปเปอร์คลื่น (WaveClipper) เหมือนเดิม
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height - 30,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 60,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
