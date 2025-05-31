import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart'; // Import DarkTheme

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isEmailStep = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitEmail() {
    if (_emailFormKey.currentState!.validate()) {
      // Simulate sending a reset email (replace with actual logic, e.g., Firebase)
      setState(() {
        _isEmailStep = false;
      });
    }
  }

  void _resetPassword() {
    if (_passwordFormKey.currentState!.validate()) {
      // Implement password reset logic here (e.g., via AuthProvider)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password reset successfully',
            style: GoogleFonts.poppins(
              color: Theme.of(context).brightness == Brightness.dark
                  ? DarkTheme.textColor
                  : AppTheme.whiteColor,
            ),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? DarkTheme.accentColor
              : AppTheme.accentColor,
        ),
      );
      Navigator.pop(context); // Return to SignInScreen
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? DarkTheme.backgroundColor : AppTheme.backgroundColor,
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: isDarkMode ? DarkTheme.whiteColor : AppTheme.whiteColor,
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24.0),
            child: _isEmailStep ? _buildEmailForm(isDarkMode) : _buildPasswordForm(isDarkMode),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailForm(bool isDarkMode) {
    return Form(
      key: _emailFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter your email to reset password',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter email',
              filled: true,
              fillColor: isDarkMode
                  ? DarkTheme.whiteColor.withOpacity(0.1)
                  : AppTheme.whiteColor.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              hintStyle: GoogleFonts.poppins(
                color: isDarkMode ? DarkTheme.secondaryTextColor : AppTheme.secondaryTextColor,
                fontSize: 14,
              ),
              labelStyle: GoogleFonts.poppins(
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                fontSize: 14,
              ),
            ),
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter an email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitEmail,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? DarkTheme.primaryColor : AppTheme.primaryColor,
                foregroundColor: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Reset Password',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordForm(bool isDarkMode) {
    return Form(
      key: _passwordFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose your new password',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter password',
              filled: true,
              fillColor: isDarkMode
                  ? DarkTheme.whiteColor.withOpacity(0.1)
                  : AppTheme.whiteColor.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              hintStyle: GoogleFonts.poppins(
                color: isDarkMode ? DarkTheme.secondaryTextColor : AppTheme.secondaryTextColor,
                fontSize: 14,
              ),
              labelStyle: GoogleFonts.poppins(
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                fontSize: 14,
              ),
            ),
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter a password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Re-Enter password',
              filled: true,
              fillColor: isDarkMode
                  ? DarkTheme.whiteColor.withOpacity(0.1)
                  : AppTheme.whiteColor.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              hintStyle: GoogleFonts.poppins(
                color: isDarkMode ? DarkTheme.secondaryTextColor : AppTheme.secondaryTextColor,
                fontSize: 14,
              ),
              labelStyle: GoogleFonts.poppins(
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                fontSize: 14,
              ),
            ),
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _resetPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? DarkTheme.primaryColor : AppTheme.primaryColor,
                foregroundColor: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Submit',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Navigate back to SignInScreen
            },
            child: Text(
              'Back to Log In',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.accentColor : AppTheme.accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}