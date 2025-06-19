import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  /// Optional callback when an item is tapped; defaults to internal navigation if null.
  final ValueChanged<int>? onTap;

  const BottomNavBar({Key? key, required this.currentIndex, this.onTap})
    : super(key: key);

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
    // Calculate safe area inset at the bottom (e.g. home indicator)
    final bottomInset = MediaQuery.of(context).padding.bottom;
    // Standard BottomNavigationBar height
    const barHeight = kBottomNavigationBarHeight;
    // Total height including safe area
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
            onTap:
                onTap != null
                    ? (index) => onTap!(index)
                    : (index) => _navigate(context, index),
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
