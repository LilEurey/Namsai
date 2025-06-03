import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  final VoidCallback? onTap;

  const NotificationButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/usernoti');
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          const Icon(Icons.notifications, color: Colors.black87, size: 28),
          // Optional red dot indicator
          Positioned(
            right: 0,
            top: 2,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
