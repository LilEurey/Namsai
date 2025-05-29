import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  final VoidCallback? onTap;

  const NotificationButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Stack(
        children: [
          const Icon(Icons.notifications, color: Colors.black87, size: 28),
          // Optional: Notification dot/badge
          // Positioned(
          //   right: 0,
          //   top: 0,
          //   child: Container(
          //     width: 8,
          //     height: 8,
          //     decoration: BoxDecoration(
          //       color: Colors.red,
          //       shape: BoxShape.circle,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}