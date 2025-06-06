import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Please enter both email and password.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await AuthService.login(email: email, password: password);

      if (result['success']) {
        final role = result['role'];
        if (role == 'admin') {
          Navigator.pushReplacementNamed(context, '/adminhome');
        } else {
          Navigator.pushReplacementNamed(context, '/userhome');
        }
      } else {
        _showError(result['message']);
      }
    } catch (e) {
      _showError('An error occurred. Please try again.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

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
                width: 357,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            // Bottom-left banner
            Positioned(
              bottom: -85,
              left: -30,
              child: Image.asset(
                'assets/image/banner3.png',
                width: 310,
                height: 260,
                fit: BoxFit.contain,
              ),
            ),
            // Main scrollable login form
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 200),
                  Image.asset(
                    'assets/image/logo_namsai.png',
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(height: 48),

                  // Email field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDecoration('Email'),
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: _inputDecoration('Password').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Sign In button or loader
                  _isLoading
                      ? const CircularProgressIndicator()
                      : _buildSignInButton(),

                  const SizedBox(height: 230),

                  // "Don't have an account? Sign Up"
                  _buildSignupText(),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Container(
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
        onPressed: _handleLogin,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSignupText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
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
                '/signup',
                (route) => false,
              ),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF4A90E2),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[600]),
      filled: true,
      fillColor: const Color(0xFFE8F4FF),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
  }
}
