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

class MainLayout extends StatelessWidget {
  final Widget content;
  final Type currentPage;

  const MainLayout({super.key, required this.content, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar (persistent navigation bar)
          Container(
            width: 250, // Fixed width for the sidebar
            color: const Color(0xFFF7F3FC), // Updated light purple background
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'CRM',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black, // CRM text remains black
                        ),
                      ),
                    ],
                  ),
                ),
                _buildNavItem(context, 'Dashboard', Icons.dashboard, const HomeScreen(), currentPage == HomeScreen),
                _buildNavItem(context, 'Customers', Icons.people, const CustomersScreen(), currentPage == CustomersScreen),
                _buildNavItem(context, 'Products', Icons.shopping_cart, const ProductsScreen(), currentPage == ProductsScreen),
                _buildNavItem(context, 'Enquiry', Icons.question_answer, const EnquiryScreen(), currentPage == EnquiryScreen),
                ExpansionTile(
                  leading: const Icon(Icons.leaderboard, color: Colors.grey),
                  title: Text(
                    'Leads',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF49454F), // Leads text color
                      backgroundColor: (currentPage == LeadsScreen || currentPage == QualifiedLeadsScreen || currentPage == BadLeadsScreen)
                          ? const Color(0xFFE8DEF8)
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
                    _buildSubNavItem(context, 'Qualified Leads', const QualifiedLeadsScreen(), currentPage == QualifiedLeadsScreen),
                    _buildSubNavItem(context, 'Bad Leads', const BadLeadsScreen(), currentPage == BadLeadsScreen),
                  ],
                ),
                _buildNavItem(context, 'Visits', Icons.event, const VisitsScreen(), currentPage == VisitsScreen),
                _buildNavItem(context, 'Calls', Icons.phone, const CallsScreen(), currentPage == CallsScreen),
                _buildNavItem(context, 'Reports', Icons.description, const ReportsScreen(), currentPage == ReportsScreen),
                _buildNavItem(context, 'Settings', Icons.settings, const SettingsScreen(), currentPage == SettingsScreen),
                const Divider(),
                _buildNavItem(context, 'Logout', Icons.logout, const SignInScreen(), false), // Logout doesn't need highlighting
              ],
            ),
          ),
          // Main content area
          Expanded(
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, IconData icon, Widget destination, bool isActive) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey), // Use the passed icon parameter
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        color: isActive ? const Color(0xFFE8DEF8) : null, // Background for selected item
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF49454F), // Text color for all nav items
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

  Widget _buildSubNavItem(BuildContext context, String title, Widget destination, bool isActive) {
    return ListTile(
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        color: isActive ? const Color(0xFFE8DEF8) : null, // Background for selected sub-item
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF49454F), // Text color for sub-nav items
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
