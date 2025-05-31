import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart'; // Import DarkTheme
import 'sign_up_screen.dart';
import 'home_screen.dart';
import 'forgot_password_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  Future<void> _launchGoogle() async {
    final Uri url = Uri.parse('https://www.google.com');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not launch Google.',
            style: GoogleFonts.poppins(
              color: Theme.of(context).brightness == Brightness.dark
                  ? DarkTheme.textColor
                  : AppTheme.whiteColor,
            ),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? DarkTheme.errorColor
              : AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? DarkTheme.backgroundColor : AppTheme.whiteColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return SingleChildScrollView(
              child: _buildForm(context, constraints.maxWidth, isDarkMode),
            );
          } else {
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: isDarkMode ? DarkTheme.backgroundColor : AppTheme.backgroundColor,
                    child: Center(
                      child: SizedBox(
                        width: 450,
                        height: 450,
                        child: Image.asset(
                          'assets/images/signin_image.jpg',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.error,
                            color: isDarkMode ? DarkTheme.errorColor : AppTheme.errorColor,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: isDarkMode ? DarkTheme.whiteColor : AppTheme.whiteColor,
                    child: SingleChildScrollView(
                      child: _buildForm(context, 350, isDarkMode),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context, double maxWidth, bool isDarkMode) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sign In',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'New user? ',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode
                            ? DarkTheme.secondaryTextColor
                            : AppTheme.secondaryTextColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      ),
                      child: Text(
                        'create an account',
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? DarkTheme.accentColor : AppTheme.accentColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Email ',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: isDarkMode ? DarkTheme.errorColor : AppTheme.errorColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter email',
                        hintStyle: GoogleFonts.poppins(
                          color: isDarkMode
                              ? DarkTheme.secondaryTextColor
                              : AppTheme.secondaryTextColor,
                        ),
                        filled: true,
                        fillColor: isDarkMode
                            ? DarkTheme.whiteColor.withOpacity(0.1)
                            : AppTheme.whiteColor.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Enter an email';
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: 'Password ',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: isDarkMode ? DarkTheme.errorColor : AppTheme.errorColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Enter password',
                        hintStyle: GoogleFonts.poppins(
                          color: isDarkMode
                              ? DarkTheme.secondaryTextColor
                              : AppTheme.secondaryTextColor,
                        ),
                        filled: true,
                        fillColor: isDarkMode
                            ? DarkTheme.whiteColor.withOpacity(0.1)
                            : AppTheme.whiteColor.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                      ),
                      obscureText: true,
                      validator: (value) =>
                      value == null || value.isEmpty ? 'Enter a password' : null,
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                        ),
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? DarkTheme.accentColor : AppTheme.accentColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _signIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode
                              ? DarkTheme.primaryColor
                              : AppTheme.primaryColor,
                          foregroundColor: isDarkMode
                              ? DarkTheme.textColor
                              : AppTheme.whiteColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: isDarkMode
                                ? DarkTheme.secondaryTextColor
                                : AppTheme.secondaryTextColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'or',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: isDarkMode
                                  ? DarkTheme.secondaryTextColor
                                  : AppTheme.secondaryTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: isDarkMode
                                ? DarkTheme.secondaryTextColor
                                : AppTheme.secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _launchGoogle,
                        icon: Image.asset(
                          'assets/images/google_logo2.png',
                          width: 24,
                          height: 24,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.error,
                            color: isDarkMode ? DarkTheme.errorColor : AppTheme.errorColor,
                            size: 24,
                          ),
                        ),
                        label: Text(
                          'Sign in with Google',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: isDarkMode
                              ? DarkTheme.textColor
                              : AppTheme.textColor,
                          side: BorderSide(
                            color: isDarkMode
                                ? DarkTheme.secondaryTextColor
                                : AppTheme.secondaryTextColor,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}