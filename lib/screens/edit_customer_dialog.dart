import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';

class EditCustomerDialog extends StatefulWidget {
  final Map<String, String> customer;
  final int index;
  final List<String> customerNames;
  final List<Map<String, String>> customers;
  final Function(Map<String, String>, int) onSave;

  const EditCustomerDialog({
    super.key,
    required this.customer,
    required this.index,
    required this.customerNames,
    required this.customers,
    required this.onSave,
  });

  @override
  _EditCustomerDialogState createState() => _EditCustomerDialogState();
}

class _EditCustomerDialogState extends State<EditCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _customerIdController;
  late TextEditingController _companyController;
  late TextEditingController _phoneController;
  late TextEditingController _alternatePhoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _designationController;
  late TextEditingController _locationController;
  late TextEditingController _typeController;
  late TextEditingController _contactController;
  late TextEditingController _companyEmailController;
  late String _status;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer['name'] ?? 'Dr. John Smith');
    _customerIdController = TextEditingController(text: widget.customer['customerId'] ?? 'CUST-2041');
    _companyController = TextEditingController(text: widget.customer['company'] ?? 'ABCD Company');
    _phoneController = TextEditingController(text: widget.customer['phone'] ?? '+91 9856246854');
    _alternatePhoneController = TextEditingController(text: widget.customer['alternatePhone'] ?? '+91 9854625874');
    _emailController = TextEditingController(text: widget.customer['email'] ?? 'johnsmith@gmail.com');
    _addressController = TextEditingController(text: widget.customer['address'] ?? 'ABCD Company, Vikas Nagar, Street 22, Mumbai, India 624587');
    _designationController = TextEditingController(text: widget.customer['designation'] ?? 'Manager');
    _locationController = TextEditingController(text: widget.customer['location'] ?? 'Mumbai, India');
    _typeController = TextEditingController(text: widget.customer['type'] ?? 'Hospital');
    _contactController = TextEditingController(text: widget.customer['contact'] ?? '+91 98654742956');
    _companyEmailController = TextEditingController(text: widget.customer['companyEmail'] ?? '');
    _status = widget.customer['status'] ?? 'Active';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _customerIdController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    _alternatePhoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _designationController.dispose();
    _locationController.dispose();
    _typeController.dispose();
    _contactController.dispose();
    _companyEmailController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedImage = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 700,
        decoration: BoxDecoration(
          color: isDarkMode ? DarkTheme.backgroundColor : AppTheme.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Update Customer',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 18,
                        color: isDarkMode ? DarkTheme.textColor : Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF5F3FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              label: 'Customer Name*',
                              controller: _nameController,
                              isDarkMode: isDarkMode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a customer name';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              label: 'Company*',
                              controller: _companyController,
                              isDarkMode: isDarkMode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a company name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              label: 'Customer ID*',
                              controller: _customerIdController,
                              isDarkMode: isDarkMode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a customer ID';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              label: 'Designation*',
                              controller: _designationController,
                              isDarkMode: isDarkMode,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF5F3FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile Avatar',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: isDarkMode ? const Color(0xFF333333) : Colors.grey.shade300,
                            backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                            child: _selectedImage == null
                                ? Text(
                              _nameController.text.isNotEmpty ? _nameController.text[0].toUpperCase() : 'A',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: isDarkMode ? DarkTheme.textColor : Colors.black,
                              ),
                            )
                                : null,
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: _pickFile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDarkMode ? const Color(0xFF333333) : Colors.grey.shade300,
                              foregroundColor: isDarkMode ? DarkTheme.textColor : Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            child: Text(
                              'Upload',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: isDarkMode ? DarkTheme.textColor : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF5F3FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Details',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              label: 'Phone*',
                              controller: _phoneController,
                              isDarkMode: isDarkMode,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a phone number';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              label: 'Alternate Number',
                              controller: _alternatePhoneController,
                              isDarkMode: isDarkMode,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Email*',
                        controller: _emailController,
                        isDarkMode: isDarkMode,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if (!emailRegExp.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF5F3FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Company Details',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              label: 'Type',
                              controller: _typeController,
                              isDarkMode: isDarkMode,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              label: 'Contact',
                              controller: _contactController,
                              isDarkMode: isDarkMode,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              label: 'Location*',
                              controller: _locationController,
                              isDarkMode: isDarkMode,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              label: 'Company Email',
                              controller: _companyEmailController,
                              isDarkMode: isDarkMode,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF5F3FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _addressController,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter Address',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isDarkMode ? DarkTheme.textColor.withOpacity(0.6) : Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: isDarkMode ? const Color(0xFF333333) : const Color(0xFFD9D9D9),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF6C5DD3),
                            ),
                          ),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode ? const Color(0xFF333333) : const Color(0xFFE6E0FA),
                        foregroundColor: isDarkMode ? DarkTheme.textColor : const Color(0xFF6C5DD3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : const Color(0xFF6C5DD3),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final updatedCustomer = {
                            'index': widget.customers[widget.index]['index']!,
                            'name': _nameController.text,
                            'customerId': _customerIdController.text,
                            'company': _companyController.text,
                            'phone': _phoneController.text,
                            'alternatePhone': _alternatePhoneController.text,
                            'email': _emailController.text,
                            'address': _addressController.text,
                            'designation': _designationController.text,
                            'location': _locationController.text,
                            'type': _typeController.text,
                            'contact': _contactController.text,
                            'companyEmail': _companyEmailController.text,
                            'status': _status,
                            'imagePath': _selectedImage?.path ?? '',
                          };
                          widget.onSave(updatedCustomer, widget.index);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Customer updated successfully',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                                ),
                              ),
                              backgroundColor: isDarkMode ? DarkTheme.accentColor : Colors.green,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode ? const Color(0xFFBB86FC) : const Color(0xFF6C5DD3),
                        foregroundColor: isDarkMode ? DarkTheme.textColor : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: Text(
                        'Update',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required bool isDarkMode,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: isDarkMode ? DarkTheme.textColor.withOpacity(0.8) : AppTheme.textColor,
        ),
        hintText: 'Enter $label',
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: isDarkMode ? DarkTheme.textColor.withOpacity(0.6) : Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isDarkMode ? const Color(0xFF333333) : const Color(0xFFD9D9D9),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF6C5DD3),
          ),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}