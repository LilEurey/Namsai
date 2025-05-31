import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        String? currentRoute = ModalRoute.of(context)?.settings.name;

        if (index == 0 && currentRoute != '/uservideotips') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/uservideotips',
            (route) => false,
          );
        } else if (index == 1 && currentRoute != '/userhome') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/userhome',
            (route) => false,
          );
        } else if (index == 2 && currentRoute != '/userprofile') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/userprofile',
            (route) => false,
          );
        }

        onTap(index); // Still call onTap to update selectedIndex state
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Tips'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );
  }
}
