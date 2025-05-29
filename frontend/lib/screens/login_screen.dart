import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Image.asset(
              'assets/image/Logo_namsai.png', // Update this path to match your asset
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 40),

            // Google Sign-In Button
            SizedBox(
              width: 250,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement Google Sign-In logic
                },
                icon: Image.asset(
                  'assets/image/google_logo.png',
                  height: 24,
                  width: 24,
                ),
                label: const Text(
                  'Continue with Google',
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
