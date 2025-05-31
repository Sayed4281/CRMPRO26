import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sign_in_screen.dart';
import 'customers_screen.dart';
import 'products_screen.dart';
import 'enquiry_screen.dart';
import 'qualified_leads_screen.dart';
import 'bad_leads_screen.dart';
import 'visits_screen.dart';
import 'calls_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';
import 'home_screen.dart';
import 'leads_screen.dart';
import '../theme/app_theme.dart'; // Import AppTheme
import '../theme/dark_theme.dart'; // Import DarkTheme

class MainLayout extends StatelessWidget {
  final Widget content;
  final Type currentPage;

  const MainLayout({super.key, required this.content, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Row(
        children: [
          // Sidebar (persistent navigation bar)
          Container(
            width: 250, // Fixed width for the sidebar
            color: isDarkMode ? DarkTheme.backgroundColor : const Color(0xFFF7F3FC), // Light purple for light mode, DarkTheme for dark mode
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 30,
                        color: isDarkMode ? DarkTheme.textColor : Colors.black,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'CRM',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
<<<<<<< HEAD
                          color: isDarkMode ? DarkTheme.textColor : Colors.black, // Text color adapts to theme
=======
                          color: Colors.black, // CRM text remains black
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
                        ),
                      ),
                    ],
                  ),
                ),
                _buildNavItem(context, 'Dashboard', Icons.dashboard, const HomeScreen(), currentPage == HomeScreen, isDarkMode),
                _buildNavItem(context, 'Customers', Icons.people, const CustomersScreen(), currentPage == CustomersScreen, isDarkMode),
                _buildNavItem(context, 'Products', Icons.shopping_cart, const ProductsScreen(), currentPage == ProductsScreen, isDarkMode),
                _buildNavItem(context, 'Enquiry', Icons.question_answer, const EnquiryScreen(), currentPage == EnquiryScreen, isDarkMode),
                ExpansionTile(
<<<<<<< HEAD
                  leading: Icon(
                    Icons.leaderboard,
                    color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                  ),
=======
                  leading: const Icon(Icons.leaderboard, color: Colors.grey),
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
                  title: Text(
                    'Leads',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
<<<<<<< HEAD
                      color: isDarkMode ? DarkTheme.textColor : const Color(0xFF49454F),
                      backgroundColor: (currentPage == LeadsScreen || currentPage == QualifiedLeadsScreen || currentPage == BadLeadsScreen)
                          ? (isDarkMode ? DarkTheme.primaryColor.withOpacity(0.2) : const Color(0xFFE8DEF8))
=======
                      color: const Color(0xFF49454F), // Leads text color
                      backgroundColor: (currentPage == LeadsScreen || currentPage == QualifiedLeadsScreen || currentPage == BadLeadsScreen)
                          ? const Color(0xFFE8DEF8)
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
                          : null, // Background for selected Leads
                    ),
                  ),
                  onExpansionChanged: (expanded) {
                    if (!expanded) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LeadsScreen()),
                      );
                    }
                  },
                  children: [
                    _buildSubNavItem(context, 'Qualified Leads', const QualifiedLeadsScreen(), currentPage == QualifiedLeadsScreen, isDarkMode),
                    _buildSubNavItem(context, 'Bad Leads', const BadLeadsScreen(), currentPage == BadLeadsScreen, isDarkMode),
                  ],
                ),
                _buildNavItem(context, 'Visits', Icons.event, const VisitsScreen(), currentPage == VisitsScreen, isDarkMode),
                _buildNavItem(context, 'Calls', Icons.phone, const CallsScreen(), currentPage == CallsScreen, isDarkMode),
                _buildNavItem(context, 'Reports', Icons.description, const ReportsScreen(), currentPage == ReportsScreen, isDarkMode),
                _buildNavItem(context, 'Settings', Icons.settings, const SettingsScreen(), currentPage == SettingsScreen, isDarkMode),
                Divider(
                  color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xFFE8E8E8),
                ),
                _buildNavItem(context, 'Logout', Icons.logout, const SignInScreen(), false, isDarkMode), // Logout doesn't need highlighting
              ],
            ),
          ),
          // Main content area
          Expanded(
            child: Container(
              color: isDarkMode ? DarkTheme.backgroundColor : AppTheme.whiteColor, // Background adapts to theme
              child: content,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, IconData icon, Widget destination, bool isActive, bool isDarkMode) {
    return ListTile(
<<<<<<< HEAD
      leading: Icon(
        icon,
        color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
      ),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        color: isActive ? (isDarkMode ? DarkTheme.primaryColor.withOpacity(0.2) : const Color(0xFFE8DEF8)) : null, // Background for selected item
=======
      leading: Icon(icon, color: Colors.grey), // Use the passed icon parameter
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        color: isActive ? const Color(0xFFE8DEF8) : null, // Background for selected item
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
<<<<<<< HEAD
            color: isDarkMode ? DarkTheme.textColor : const Color(0xFF49454F),
=======
            color: const Color(0xFF49454F), // Text color for all nav items
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
          ),
        ),
      ),
      onTap: () {
        if (title == 'Logout') {
          // Show confirmation dialog for logout
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Confirm Logout',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? DarkTheme.textColor : const Color(0xFF49454F),
                  ),
                ),
                content: Text(
                  'Are you sure you want to logout?',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: isDarkMode ? DarkTheme.textColor : const Color(0xFF49454F),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: isDarkMode ? DarkTheme.primaryColor : AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => destination),
                      );
                    },
                    child: Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.red, // Red color for logout action
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          // Navigate to other pages without confirmation
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => destination),
          );
        }
      },
    );
  }

  Widget _buildSubNavItem(BuildContext context, String title, Widget destination, bool isActive, bool isDarkMode) {
    return ListTile(
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
<<<<<<< HEAD
        color: isActive ? (isDarkMode ? DarkTheme.primaryColor.withOpacity(0.2) : const Color(0xFFE8DEF8)) : null, // Background for selected sub-item
=======
        color: isActive ? const Color(0xFFE8DEF8) : null, // Background for selected sub-item
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
<<<<<<< HEAD
            color: isDarkMode ? DarkTheme.textColor : const Color(0xFF49454F),
=======
            color: const Color(0xFF49454F), // Text color for sub-nav items
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
          ),
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => destination),
        );
      },
    );
  }
}
