import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap, required currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Tips'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      // Optional: adjust type to fixed for equal spacing
      type: BottomNavigationBarType.fixed,
      // Optional: elevate to cast a shadow
      elevation: 8,
    );
  }
}
