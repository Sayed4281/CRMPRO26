import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';

class AddCustomerDialog extends StatefulWidget {
  final List<String> customerNames;
  final List<Map<String, String>> customers;
  final Function(Map<String, String>) onSave;

  const AddCustomerDialog({
    super.key,
    required this.customerNames,
    required this.customers,
    required this.onSave,
  });

  @override
  _AddCustomerDialogState createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _companyController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _designationController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _companyController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _designationController = TextEditingController();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _designationController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  String _generateCustomerId() {
    int nextId = widget.customers.length + 1;
    String customerId = 'CUST-${nextId.toString().padLeft(4, '0')}';
    while (widget.customers.any((customer) => customer['customerId'] == customerId)) {
      nextId++;
      customerId = 'CUST-${nextId.toString().padLeft(4, '0')}';
    }
    return customerId;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.transparent,
        child: Container(
          width: 700,
          height: 680, // Reduced height since we removed the status field
          decoration: BoxDecoration(
            color: isDarkMode ? DarkTheme.backgroundColor : AppTheme.whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(60),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Customer',
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
                    const SizedBox(height: 24),

                    _buildLabeledTextField('Customer Name', _nameController, isDarkMode, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Customer Name is required';
                      }
                      return null;
                    }),

                    const SizedBox(height: 16),

                    _buildLabeledTextField('Company', _companyController, isDarkMode, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Company is required';
                      }
                      return null;
                    }),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _buildLabeledTextField(
                            'Phone Number',
                            _phoneController,
                            isDarkMode,
                            isNumber: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone Number is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildLabeledTextField(
                            'Email',
                            _emailController,
                            isDarkMode,
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
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 90,
                          child: TextFormField(
                            controller: _addressController,
                            minLines: 3,
                            maxLines: 3,
                            decoration: _inputDecoration('Enter Address', isDarkMode),
                            style: GoogleFonts.poppins(
                              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _buildLabeledTextField('Designation', _designationController, isDarkMode),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildLabeledTextField('Location', _locationController, isDarkMode),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDarkMode ? DarkTheme.whiteColor.withOpacity(0.2) : const Color(0xFFD9C9F4),
                            foregroundColor: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final newCustomer = {
                                'sino': (widget.customers.length + 1).toString().padLeft(2, '0'),
                                'name': _nameController.text,
                                'customerId': _generateCustomerId(),
                                'company': _companyController.text,
                                'phone': _phoneController.text,
                                'email': _emailController.text,
                                'address': _addressController.text,
                                'designation': _designationController.text,
                                'location': _locationController.text,
                                // Removed the status field
                              };
                              widget.onSave(newCustomer);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Customer added successfully',
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
                            backgroundColor: isDarkMode ? DarkTheme.primaryColor : AppTheme.primaryColor,
                            foregroundColor: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: Text(
                            'Add Customer',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, bool isDarkMode) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: isDarkMode ? DarkTheme.whiteColor.withOpacity(0.2) : Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : AppTheme.textColor.withOpacity(0.3),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : AppTheme.textColor.withOpacity(0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: isDarkMode ? DarkTheme.accentColor : AppTheme.primaryColor,
        ),
      ),
      hintStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: isDarkMode ? DarkTheme.secondaryTextColor : Colors.grey,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  Widget _buildLabeledTextField(
      String label,
      TextEditingController controller,
      bool isDarkMode, {
        bool isNumber = false,
        String? Function(String?)? validator,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: controller,
            decoration: _inputDecoration('Enter $label', isDarkMode),
            style: GoogleFonts.poppins(
              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
            ),
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            validator: validator,
          ),
        ),
      ],
    );
  }
}