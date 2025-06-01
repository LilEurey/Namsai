import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileScreen());
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Screen',
      debugShowCheckedModeBanner: false,
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const Color _darkBlue = Color(0xFF64B5F6);
  static const Color _lightBlue = Color(0xFFB3E5FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with two overlapping waves
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                // Dark blue wave (background)
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(height: 200, color: _darkBlue),
                ),
                // Light blue wave (in front, slightly lower)
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(height: 180, color: _lightBlue),
                ),
                // Circular avatar positioned to overlap the waves
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade200,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Spacing between avatar bottom and content
          const SizedBox(height: 16),

          // Profile details section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  // Name row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      Text(
                        'Jaew',
                        style: TextStyle(fontSize: 16, color: _darkBlue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // E-mail row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'E-mail',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      Text(
                        'namsaijaew@gmail.com',
                        style: TextStyle(fontSize: 16, color: _darkBlue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Tel. row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Tel.',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      Text(
                        '+66 987654321',
                        style: TextStyle(fontSize: 16, color: _darkBlue),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Log out button centered
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Implement log out functionality
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
          ),
        ],
      ),
    );
  }
}

/// A custom clipper that creates a simple wave shape for the header.
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    // Start at top-left corner
    path.lineTo(0, size.height - 40);

    // First control point (quarter-width, full-height)
    // End point (half-width, size.height - 30)
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height - 30,
    );

    // Second control point (three-quarters width, size.height - 60)
    // End point (size.width, size.height - 40)
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 60,
      size.width,
      size.height - 40,
    );

    // Line to top-right corner
    path.lineTo(size.width, 0);

    // Close the path
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
