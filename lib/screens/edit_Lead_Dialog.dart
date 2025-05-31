
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';

class EditLeadDialog extends StatefulWidget {
final Map<String, String> lead;
final int index;
final List<String> customerNames;
final List<Map<String, String>> leads;
final Function(Map<String, String>, int?) onSave;

const EditLeadDialog({
super.key,
required this.lead,
required this.index,
required this.customerNames,
required this.leads,
required this.onSave,
});

@override
_EditLeadDialogState createState() => _EditLeadDialogState();
}

class _EditLeadDialogState extends State<EditLeadDialog> {
final _formKey = GlobalKey<FormState>();
late TextEditingController _leadNameController;
late TextEditingController _productController;
late TextEditingController _customerNameController;
late TextEditingController _quantityController;
late TextEditingController _closingDateController;
late TextEditingController _activitiesController;
late String _priority;
late String _status;
late String _demoSuccess;

@override
void initState() {
super.initState();
_leadNameController = TextEditingController(text: widget.lead['leadId'] ?? '');
_productController = TextEditingController(text: widget.lead['product'] ?? '');
_customerNameController = TextEditingController(text: widget.lead['name'] ?? '');
_quantityController = TextEditingController(text: widget.lead['quantity'] ?? '');
_closingDateController = TextEditingController(text: widget.lead['closingDate'] ?? '');
_activitiesController = TextEditingController(text: widget.lead['activities'] ?? '');
_priority = widget.lead['priority'] ?? 'High';
_status = widget.lead['status'] ?? 'Demo Scheduled';
_demoSuccess = widget.lead['demoSuccess'] ?? '';
}

@override
void dispose() {
_leadNameController.dispose();
_productController.dispose();
_customerNameController.dispose();
_quantityController.dispose();
_closingDateController.dispose();
_activitiesController.dispose();
super.dispose();
}

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
contentPadding: const EdgeInsets.all(16.0),
title: Text(
'Edit Lead',
style: GoogleFonts.poppins(
fontSize: 20,
fontWeight: FontWeight.w600,
color: isDarkMode ? DarkTheme.textColor : Colors.black,
),
),
content: SingleChildScrollView(
child: Form(
key: _formKey,
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Expanded(
child: _buildTextField('Lead Name', _leadNameController, isDarkMode),
),
const SizedBox(width: 16),
Expanded(
child: _buildTextField('Product', _productController, isDarkMode),
),
],
),
const SizedBox(height: 16),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Expanded(
child: _buildDropdownField(
'Customer Name',
_customerNameController,
widget.customerNames,
isDarkMode,
),
),
const SizedBox(width: 16),
Expanded(
child: _buildTextField('Quantity', _quantityController, isDarkMode),
),
],
),
const SizedBox(height: 16),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Expanded(
child: _buildDropdownField(
'Priority',
TextEditingController(text: _priority),
['High', 'Medium', 'Low'],
isDarkMode,
onChanged: (value) {
setState(() {
_priority = value!;
});
},
),
),
const SizedBox(width: 16),
Expanded(
child: _buildTextField('Expected Closing Date', _closingDateController, isDarkMode),
),
],
),
const SizedBox(height: 16),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Expanded(
child: _buildDropdownField(
'Status',
TextEditingController(text: _status),
[
'Discussion',
'Quotation Submitted',
'Waiting for Demo',
'Demo Scheduled',
'Demo Completed',
'Quotation Rejected',
'Demo Cancelled',
'Closed',
],
isDarkMode,
onChanged: (value) {
setState(() {
_status = value!;
});
},
),
),
const SizedBox(width: 16),
Expanded(
child: _buildDropdownField(
'If Status is Demo Completed',
TextEditingController(text: _demoSuccess),
['Success', 'Won The Order', ''],
isDarkMode,
onChanged: (value) {
setState(() {
_demoSuccess = value!;
});
},
),
),
],
),
const SizedBox(height: 16),
_buildTextField('Activities', _activitiesController, isDarkMode),
],
),
),
),
actions: [
ElevatedButton(
onPressed: () {
if (_formKey.currentState!.validate()) {
final updatedLead = {
'index': widget.lead['index'] ?? '',
'name': _customerNameController.text,
'leadId': _leadNameController.text,
'product': _productController.text,
'leadStatus': widget.lead['leadStatus'] ?? 'Bad Lead',
'status': _status,
'closingDate': _closingDateController.text,
'quantity': _quantityController.text,
'priority': _priority,
'demoSuccess': _demoSuccess,
'activities': _activitiesController.text,
};
widget.onSave(updatedLead, widget.index);
Navigator.pop(context);
}
},
child: Text(
'Update',
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

Widget _buildTextField(String label, TextEditingController controller, bool isDarkMode) {
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
TextFormField(
controller: controller,
decoration: InputDecoration(
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
filled: true,
fillColor: isDarkMode ? DarkTheme.whiteColor.withOpacity(0.2) : Colors.white.withOpacity(0.9),
errorStyle: GoogleFonts.poppins(
color: isDarkMode ? DarkTheme.errorColor : Colors.red,
),
),
style: GoogleFonts.poppins(
fontSize: 14,
color: isDarkMode ? DarkTheme.textColor : Colors.black,
),
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please enter $label';
}
return null;
},
),
],
);
}

Widget _buildDropdownField(
String label,
TextEditingController controller,
List<String> items,
bool isDarkMode, {
Function(String?)? onChanged,
}) {
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
DropdownButtonFormField<String>(
value: controller.text.isNotEmpty ? controller.text : null,
items: items.map((String item) {
return DropdownMenuItem<String>(
value: item,
child: Text(
item,
style: GoogleFonts.poppins(
fontSize: 14,
color: isDarkMode ? DarkTheme.textColor : Colors.black,
),
),
);
}).toList(),
onChanged: onChanged ?? (value) => controller.text = value!,
decoration: InputDecoration(
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
filled: true,
fillColor: isDarkMode ? DarkTheme.whiteColor.withOpacity(0.2) : Colors.white.withOpacity(0.9),
errorStyle: GoogleFonts.poppins(
color: isDarkMode ? DarkTheme.errorColor : Colors.red,
),
),
style: GoogleFonts.poppins(
fontSize: 14,
color: isDarkMode ? DarkTheme.textColor : Colors.black,
),
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please select $label';
}
return null;
},
),
],
);
}
}