import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';

class AddCallDialog extends StatefulWidget {
  final Function(Map<String, String>) onSave;

  const AddCallDialog({super.key, required this.onSave});

  @override
  _AddCallDialogState createState() => _AddCallDialogState();
}

class _AddCallDialogState extends State<AddCallDialog> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    companyController.dispose();
    durationController.dispose();
    super.dispose();
  }

  Widget _buildTextField(String label, TextEditingController controller, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            hintStyle: GoogleFonts.poppins(
              color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xFFD9D9D9),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xFFD9D9D9),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF6C5DD3),
              ),
            ),
          ),
          style: GoogleFonts.poppins(
            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        backgroundColor: isDarkMode ? DarkTheme.whiteColor : AppTheme.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add Call',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                size: 18,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 500, // Increased width for the dialog content
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField('Phone Number', phoneController, isDarkMode),
                const SizedBox(height: 10),
                _buildTextField('Name', nameController, isDarkMode),
                const SizedBox(height: 10),
                _buildTextField('Email', emailController, isDarkMode),
                const SizedBox(height: 10),
                _buildTextField('Address', addressController, isDarkMode),
                const SizedBox(height: 10),
                _buildTextField('Company', companyController, isDarkMode),
                const SizedBox(height: 10),
                _buildTextField('Call Duration', durationController, isDarkMode),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(fontSize: 12, color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor),
            ),
            style: TextButton.styleFrom(
              backgroundColor: isDarkMode ? DarkTheme.backgroundColor : const Color(0xFFE6E6FA),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              final newCall = {
                'name': nameController.text,
                'location': addressController.text,
                'company': companyController.text,
                'phoneNumber': phoneController.text,
                'callDuration': durationController.text,
              };
              widget.onSave(newCall);
              Navigator.pop(context);
            },
            child: Text(
              'Add Call',
              style: GoogleFonts.poppins(fontSize: 12, color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor),
            ),
            style: TextButton.styleFrom(
              backgroundColor: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6C5DD3),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}