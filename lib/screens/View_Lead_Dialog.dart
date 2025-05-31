
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';

class ViewLeadDialog extends StatelessWidget {
final Map<String, String> lead;
final VoidCallback onEdit;

const ViewLeadDialog({super.key, required this.lead, required this.onEdit});

@override
Widget build(BuildContext context) {
final isDarkMode = Theme.of(context).brightness == Brightness.dark;
return BackdropFilter(
filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
child: AlertDialog(
backgroundColor: isDarkMode ? DarkTheme.backgroundColor : AppTheme.whiteColor,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
contentPadding: const EdgeInsets.all(5.0),
title: Text(
'View Lead',
style: GoogleFonts.poppins(
fontSize: 20,
fontWeight: FontWeight.w600,
color: isDarkMode ? DarkTheme.textColor : Colors.black,
),
),
content: SingleChildScrollView(
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Expanded(
child: _buildDetailField('Lead ID', lead['leadId'] ?? '', isDarkMode),
),
const SizedBox(width: 16),
Expanded(
child: _buildDetailField('Product Name', lead['product'] ?? '', isDarkMode),
),
],
),
const SizedBox(height: 16),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Expanded(
child: _buildDetailField('Customer Name', lead['name'] ?? '', isDarkMode),
),
const SizedBox(width: 16),
Expanded(
child: _buildDetailField('Quantity', lead['quantity'] ?? '', isDarkMode),
),
],
),
const SizedBox(height: 16),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Expanded(
child: _buildDetailField('Priority', lead['priority'] ?? '', isDarkMode),
),
const SizedBox(width: 16),
Expanded(
child: _buildDetailField('Expected Closing Date', lead['closingDate'] ?? '', isDarkMode),
),
],
),
const SizedBox(height: 16),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Expanded(
child: _buildDetailField('Status', lead['status'] ?? '', isDarkMode),
),
const SizedBox(width: 16),
Expanded(
child: _buildDetailField('If Status is Demo Completed', lead['demoSuccess'] ?? '', isDarkMode),
),
],
),
const SizedBox(height: 16),
_buildDetailField('Activities', lead['activities'] ?? '', isDarkMode),
],
),
),
actions: [
ElevatedButton(
onPressed: onEdit,
child: Text(
'Edit',
style: GoogleFonts.poppins(
color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
),
),
style: ElevatedButton.styleFrom(
backgroundColor: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6C5DD3),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
),
),
TextButton(
onPressed: () => Navigator.pop(context),
child: Text(
'Cancel',
style: GoogleFonts.poppins(
color: isDarkMode ? DarkTheme.textColor : Colors.black,
),
),
style: TextButton.styleFrom(
backgroundColor: isDarkMode ? DarkTheme.whiteColor.withOpacity(0.3) : const Color(0xFFE6E6FA),
padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
),
),
],
),
);
}

Widget _buildDetailField(String label, String value, bool isDarkMode) {
return Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
label,
style: GoogleFonts.poppins(
fontSize: 12,
color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey[800],
),
),
const SizedBox(height: 4),
Container(
width: double.infinity,
padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
decoration: BoxDecoration(
border: Border.all(
color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xFFD9D9D9),
),
borderRadius: BorderRadius.circular(8),
color: isDarkMode ? DarkTheme.whiteColor.withOpacity(0.2) : Colors.white.withOpacity(0.9),
),
child: Text(
value,
style: GoogleFonts.poppins(
fontSize: 14,
color: isDarkMode ? DarkTheme.textColor : Colors.black,
),
),
),
],
);
}
}
