// lib/widgets/user/bottom_nav_bar.dart

import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required Null Function(dynamic i)
    onTap, // ถ้าไม่ใช้ onTap ภายนอก สามารถลบทิ้งได้
  });

  void _navigate(BuildContext context, int index) {
    const routes = ['/usertips', '/userhome', '/profile'];
    if (ModalRoute.of(context)?.settings.name != routes[index]) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        routes[index],
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // ห่อด้วย Container เพื่อใส่ BoxDecoration (เงา + ขอบโค้งบน)
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(66, 142, 142, 142),
            offset: Offset(0, -2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: SizedBox(
          height:
              90, // ความสูงของ Nav bar (ต้องตรงกับ bottom padding ที่เราให้ ListView = 90)
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            onTap: (index) => _navigate(context, index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            iconSize: 28,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book),
                label: 'Tips',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
