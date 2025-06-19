import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    Key? key,
    required this.currentIndex, required Null Function(dynamic index) onTap,
  }) : super(key: key);

  void _navigate(BuildContext context, int index) {
    const routes = ['/admintips', '/adminhome', '/profile'];
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
    // คำนวณพื้นที่ safe area ด้านล่าง (เช่น notch หรือ gesture area)
    final bottomInset = MediaQuery.of(context).padding.bottom;
    // ความสูงมาตรฐานของ BottomNavigationBar = 56.0
    const barHeight = kBottomNavigationBarHeight;
    // รวมความสูงทั้งหมด
    final totalHeight = barHeight + bottomInset;

    return SafeArea(
      top: false,
      child: Container(
        height: totalHeight,
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
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
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