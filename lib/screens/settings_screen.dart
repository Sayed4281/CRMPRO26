import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker package
import '../main.dart'; // Import ThemeProvider from main.dart
import 'main_layout.dart';
import 'sign_in_screen.dart'; // Import SignInScreen
import 'package:crmpro26/theme/dark_theme.dart'; // Import DarkTheme

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedTab = 0; // 0: Profile, 1: Preferences, 2: Notifications, 3: Security

  // State variables for toggles and dropdowns
  bool _emailAlerts = false;
  bool _pushNotifications = false;
  bool _smsMessages = false;
  bool _twoFactorAuth = false;
  String? _selectedLanguage;
  String? _selectedTimezone;

  // State variables for profile details
  String _displayName = "Example Name";
  String _displayEmail = "example@email.com";
  String _displayPhone = "+1234567890";

  // Text controllers for profile and security fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  // Method to handle file picking for avatar
  Future<void> _pickAvatar() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Restrict to image files
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Avatar selected successfully!",
            style: GoogleFonts.poppins(),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "No file selected.",
            style: GoogleFonts.poppins(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return MainLayout(
      currentPage: SettingsScreen,
      content: Container(
        color: isDarkMode ? null : Colors.white, // Use white in light mode, theme background in dark mode
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Settings",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? DarkTheme.textColor : Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  _buildTabHeader(context, "Profile Settings", 0),
                  _buildTabHeader(context, "Account Preferences", 1),
                  _buildTabHeader(context, "Notifications", 2),
                  _buildTabHeader(context, "Security", 3),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: isDarkMode ? null : Colors.white, // Use white in light mode, theme background in dark mode
                padding: const EdgeInsets.all(16.0),
                child: _buildTabContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabHeader(BuildContext context, String title, int index) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: _selectedTab == index ? FontWeight.w600 : FontWeight.w400,
                color: _selectedTab == index
                    ? (isDarkMode ? DarkTheme.textColor : Colors.black)
                    : (isDarkMode ? DarkTheme.textColor : Colors.grey),
              ),
            ),
            if (_selectedTab == index)
              Container(
                margin: const EdgeInsets.only(top: 4.0),
                height: 2.0,
                width: 20.0,
                color: isDarkMode ? DarkTheme.textColor : Colors.black,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0: // Profile Settings
        return _buildProfileSettings();
      case 1: // Account Preferences
        return _buildAccountPreferences(context);
      case 2: // Notifications
        return _buildNotifications();
      case 3: // Security
        return _buildSecurity();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildProfileSettings() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add the card based on the given design
          Card(
            elevation: 2,
            color: isDarkMode ? null : const Color(0xFFF3EEFB), // Match the background color from the image
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20, // Circular avatar placeholder
                            backgroundColor: isDarkMode ? DarkTheme.whiteColor : Colors.grey[300],
                            child: Icon(
                              Icons.person_outlined,
                              color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 20.0), // Increased gap between icon and profile details
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _displayName, // Use state variable for name
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isDarkMode ? DarkTheme.textColor : Colors.black,
                                ),
                              ),
                              Text(
                                _displayEmail, // Use state variable for email
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                                ),
                              ),
                              Text(
                                _displayPhone, // Use state variable for phone
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Upload Avatar button moved to the right below profile details
                      GestureDetector(
                        onTap: _pickAvatar, // Call file picker on tap
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: isDarkMode ? DarkTheme.primaryColor : Colors.purple[50], // Match the light purple background
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "Upload Avatar",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? DarkTheme.textColor : Colors.purple, // Match the purple text color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  // Description text
                  Text(
                    "Update your personal information and avatar.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDarkMode ? DarkTheme.textColor : Colors.grey[600], // Match the gray color
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          _buildTextField("Name", "Enter your name", _nameController),
          const SizedBox(height: 16.0),
          _buildTextField("Email", "Enter your email", _emailController),
          const SizedBox(height: 16.0),
          _buildTextField("Phone", "Enter your phone", _phoneController),
          const SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _emailController.text.isNotEmpty &&
                    _phoneController.text.isNotEmpty) {
                  setState(() {
                    // Update the displayed profile details
                    _displayName = _nameController.text;
                    _displayEmail = _emailController.text;
                    _displayPhone = _phoneController.text;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Profile updated successfully!", style: GoogleFonts.poppins())),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please fill all fields.", style: GoogleFonts.poppins())),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? DarkTheme.primaryColor : Colors.purple,
                foregroundColor: isDarkMode ? DarkTheme.textColor : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "Save Changes",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? DarkTheme.textColor : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildAccountPreferences(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                color: isDarkMode ? null : const Color(0xFFF3EEFB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            "Preferences",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? DarkTheme.textColor : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Customize your experience.",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 2,
                color: isDarkMode ? null : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.brightness_6_outlined,
                                  color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  "Theme",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: isDarkMode ? DarkTheme.textColor : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              "Light or Dark mode",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Switch(
                              value: themeProvider.themeMode == ThemeMode.dark,
                              onChanged: (value) {
                                themeProvider.toggleTheme(value);
                              },
                              activeColor: isDarkMode ? DarkTheme.primaryColor : Colors.purple,
                              inactiveThumbColor: isDarkMode ? DarkTheme.textColor : Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.language_outlined,
                                  color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  "Language",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: isDarkMode ? DarkTheme.textColor : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              "App language",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            DropdownButton<String>(
                              value: _selectedLanguage,
                              hint: Text(
                                "Select",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                                ),
                              ),
                              items: <String>['English', 'Malayalam', 'Arabic'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.poppins(
                                      color: isDarkMode ? DarkTheme.textColor : Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedLanguage = value;
                                });
                              },
                              dropdownColor: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFF3EEFB),
                              iconEnabledColor: isDarkMode ? DarkTheme.textColor : Colors.black,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  "Timezone",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: isDarkMode ? DarkTheme.textColor : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              "Set your timezone",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            DropdownButton<String>(
                              value: _selectedTimezone,
                              hint: Text(
                                "Select",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                                ),
                              ),
                              items: <String>['UTC', 'PST', 'EST'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.poppins(
                                      color: isDarkMode ? DarkTheme.textColor : Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedTimezone = value;
                                });
                              },
                              dropdownColor: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFF3EEFB),
                              iconEnabledColor: isDarkMode ? DarkTheme.textColor : Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Preferences saved successfully!", style: GoogleFonts.poppins())),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? DarkTheme.primaryColor : Colors.purple,
                    foregroundColor: isDarkMode ? DarkTheme.textColor : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      "Save Changes",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? DarkTheme.textColor : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotifications() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            color: isDarkMode ? null : const Color(0xFFF3EEFB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        "Notification Settings",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? DarkTheme.textColor : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Manage how you receive alerts and updates.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Card(
            elevation: 2,
            color: isDarkMode ? null : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              "Email Alerts",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: isDarkMode ? DarkTheme.textColor : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "Receive alerts via email",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Switch(
                          value: _emailAlerts,
                          onChanged: (value) {
                            setState(() {
                              _emailAlerts = value;
                            });
                          },
                          activeColor: isDarkMode ? DarkTheme.primaryColor : Colors.purple,
                          inactiveThumbColor: isDarkMode ? DarkTheme.textColor : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.notifications_active_outlined,
                              color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              "Push Notifications",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: isDarkMode ? DarkTheme.textColor : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "Get real-time app alerts",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Switch(
                          value: _pushNotifications,
                          onChanged: (value) {
                            setState(() {
                              _pushNotifications = value;
                            });
                          },
                          activeColor: isDarkMode ? DarkTheme.primaryColor : Colors.purple,
                          inactiveThumbColor: isDarkMode ? DarkTheme.textColor : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.sms_outlined,
                              color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              "SMS Messages",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: isDarkMode ? DarkTheme.textColor : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "Text message notifications",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Switch(
                          value: _smsMessages,
                          onChanged: (value) {
                            setState(() {
                              _smsMessages = value;
                            });
                          },
                          activeColor: isDarkMode ? DarkTheme.primaryColor : Colors.purple,
                          inactiveThumbColor: isDarkMode ? DarkTheme.textColor : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Notification settings saved successfully!", style: GoogleFonts.poppins())),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? DarkTheme.primaryColor : Colors.purple,
                foregroundColor: isDarkMode ? DarkTheme.textColor : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "Save Changes",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? DarkTheme.textColor : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurity() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            color: isDarkMode ? null : const Color(0xFFF3EEFB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lock_outlined,
                        color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        "Security",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? DarkTheme.textColor : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Protect your account.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          _buildTextField("Current Password", "Enter current password", _currentPasswordController, isPassword: true),
          const SizedBox(height: 16.0),
          _buildTextField("New Password", "Enter new password", _newPasswordController, isPassword: true),
          const SizedBox(height: 16.0),
          _buildTextField("Confirm New Password", "Confirm new password", _confirmPasswordController, isPassword: true),
          const SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPasswordController.text.isNotEmpty &&
                    _newPasswordController.text.isNotEmpty &&
                    _confirmPasswordController.text.isNotEmpty) {
                  if (_newPasswordController.text == _confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password updated successfully!", style: GoogleFonts.poppins())),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("New passwords do not match.", style: GoogleFonts.poppins())),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please fill all fields.", style: GoogleFonts.poppins())),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? DarkTheme.primaryColor : Colors.purple,
                foregroundColor: isDarkMode ? DarkTheme.textColor : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "Save Changes",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? DarkTheme.textColor : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Card(
            elevation: 2,
            color: isDarkMode ? null : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.security_outlined,
                            color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                          ),
                          const SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Two-Factor Authentication",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: isDarkMode ? DarkTheme.textColor : Colors.black,
                                ),
                              ),
                              Text(
                                "Add extra security",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Switch(
                        value: _twoFactorAuth,
                        onChanged: (value) {
                          setState(() {
                            _twoFactorAuth = value;
                          });
                        },
                        activeColor: isDarkMode ? DarkTheme.primaryColor : Colors.purple,
                        inactiveThumbColor: isDarkMode ? DarkTheme.textColor : Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.transparent, // Allow blur effect to show through
                        builder: (context) => BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // 40% blur effect
                          child: Dialog(
                            backgroundColor: isDarkMode ? DarkTheme.whiteColor : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7, // Reduced width
                              constraints: const BoxConstraints(maxHeight: 400), // Reduced height
                              padding: const EdgeInsets.all(12.0), // Reduced padding
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Terms and Conditions",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16, // Slightly smaller font
                                      fontWeight: FontWeight.w600,
                                      color: isDarkMode ? DarkTheme.textColor : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          _buildTermsSection(
                                            "1. Acceptance of Terms",
                                            "By accessing or using [CRM Software Name] (\"Service\"), you agree to be bound by these Terms and Conditions (\"Terms\"). If you do not agree to these Terms, do not use the Service.",
                                          ),
                                          _buildTermsSection(
                                            "2. Use of the Service",
                                            "You may use the Service only in accordance with these Terms and applicable laws. You are responsible for maintaining the confidentiality of your account and credentials.",
                                          ),
                                          _buildTermsSection(
                                            "3. User Data",
                                            "You retain ownership of the data you upload or input into the CRM. You grant [Your Company Name] a limited license to use your data to provide and improve the Service.",
                                          ),
                                          _buildTermsSection(
                                            "4. Subscription and Payment",
                                            "If the Service is offered under a subscription model, you agree to pay all fees as outlined. Non-payment may result in suspension or termination of access.",
                                          ),
                                          _buildTermsSection(
                                            "5. Intellectual Property",
                                            "All content, features, and functionality of the Service are the exclusive property of [Your Company Name]. You may not reproduce or modify any part without permission.",
                                          ),
                                          _buildTermsSection(
                                            "6. Termination",
                                            "We may suspend or terminate your access to the Service at our discretion if you violate these Terms or misuse the Service.",
                                          ),
                                          _buildTermsSection(
                                            "7. Limitation of Liability",
                                            "The Service is provided \"as is\" without warranties. [Your Company Name] is not liable for any indirect or consequential damages.",
                                          ),
                                          _buildTermsSection(
                                            "8. Privacy",
                                            "Your use of the Service is also governed by our Privacy Policy, which explains how we collect, store, and use your data.",
                                          ),
                                          _buildTermsSection(
                                            "9. Modifications",
                                            "We may modify these Terms at any time. Continued use of the Service after updates indicates your acceptance of the revised Terms.",
                                          ),
                                          _buildTermsSection(
                                            "10. Governing Law",
                                            "These Terms shall be governed by the laws of [Insert Jurisdiction]. Disputes shall be resolved in the courts of [Insert Jurisdiction].",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Close",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: isDarkMode ? DarkTheme.primaryColor : Colors.purple,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_outlined,
                          color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          "Terms and Conditions",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: isDarkMode ? DarkTheme.textColor : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "View our Terms and Conditions",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, {bool isPassword = false}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? DarkTheme.textColor : Colors.black,
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: TextStyle(
            color: isDarkMode ? DarkTheme.textColor : Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: isDarkMode ? DarkTheme.textColor : Colors.grey[600],
            ),
            filled: true,
            fillColor: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFF3EEFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsSection(String title, String content) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0), // Reduced padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14, // Smaller font size
              fontWeight: FontWeight.w600,
              color: isDarkMode ? DarkTheme.textColor : Colors.black,
            ),
          ),
          const SizedBox(height: 2.0), // Reduced spacing
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 12, // Smaller font size
              color: isDarkMode ? DarkTheme.textColor : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}