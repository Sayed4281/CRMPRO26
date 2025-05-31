import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';

class ViewCallDialog extends StatelessWidget {
  final Map<String, String> call;

  const ViewCallDialog({super.key, required this.call});

  Widget _buildDetailRow(String label, String value, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'N/A' : value,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
            ),
          ),
        ],
      ),
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
              'View Call Details',
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
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Serial No', call['index'] ?? '', isDarkMode),
                _buildDetailRow('Name', call['name'] ?? '', isDarkMode),
                _buildDetailRow('Call ID', call['callId'] ?? '', isDarkMode),
                _buildDetailRow('Company', call['company'] ?? '', isDarkMode),
                _buildDetailRow('Phone Number', call['phoneNumber'] ?? '', isDarkMode),
                _buildDetailRow('Location', call['location'] ?? '', isDarkMode),
                _buildDetailRow('Call Duration', call['callDuration'] ?? '', isDarkMode),
                _buildDetailRow('Email', call['email'] ?? '', isDarkMode),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: isDarkMode ? DarkTheme.backgroundColor : const Color(0xFFE6E6FA),
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