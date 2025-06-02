import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Toggle for showing/hiding password
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Top-right banner
            Positioned(
              top: 0,
              right: -70,
              child: Image.asset(
                'assets/image/banner2.png',
                width: 357, // adjust as needed
                height: 300, // adjust as needed
                fit: BoxFit.contain,
              ),
            ),

            // Bottom-left banner
            Positioned(
              bottom: -50,
              left: -30,
              child: Image.asset(
                'assets/image/banner3.png',
                width: 310, // adjust as needed
                height: 260, // adjust as needed
                fit: BoxFit.contain,
              ),
            ),

            // Main scrollable content
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // ← Align children to the left
                children: [
                  // Spacer so content starts below the top banner
                  const SizedBox(height: 95),

                  // ====== "Create account" Title (left-aligned) ======
                  const Text(
                    'Create account',
                    style: TextStyle(
                      fontSize: 24, // font size 24
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const Text(
                    'Sign up to get started!',
                    style: TextStyle(
                      fontSize: 14, // font size 24
                      fontWeight: FontWeight.w100,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ====== Name Field ======
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFFE8F4FF),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ====== Tel Field ======
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Tel',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFFE8F4FF),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ====== Email Field ======
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFFE8F4FF),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ====== Password Field ======
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFFE8F4FF),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ====== Confirm Password Field ======
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFFE8F4FF),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // ====== Sign Up Button ======
                  Center(
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF80C3FF), Color(0xFF4A90E2)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement sign-up logic
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 170),

                  // ==== "Already have an account? Sign In" ====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap:
                            () => Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/login', // replace with your actual SignIn route
                              (route) => false,
                            ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4A90E2),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
