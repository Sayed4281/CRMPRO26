import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';

class EditEnquiryDialog extends StatefulWidget {
  final Map<String, dynamic>? enquiry; // Optional: Pass existing enquiry data
  const EditEnquiryDialog({super.key, this.enquiry});

  @override
  State<EditEnquiryDialog> createState() => _EditEnquiryDialogState();
}

class _EditEnquiryDialogState extends State<EditEnquiryDialog> {
  String _productType = 'New';
  String _demoRequired = 'Yes';
  String _purchasePlan = 'Immediate';
  DateTime? _selectedDate = DateTime(2025, 1, 7);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _customerNameController = TextEditingController(text: 'Dr. John Smith');
  final TextEditingController _productNameController = TextEditingController(text: 'CT Scanner');
  final TextEditingController _quantityController = TextEditingController(text: '100');
  final TextEditingController _notesController = TextEditingController(text: 'Looking for fast delivery');
  final TextEditingController _dateController = TextEditingController(text: '7/1/2025');

  @override
  void initState() {
    super.initState();
    if (widget.enquiry != null) {
      _customerNameController.text = widget.enquiry!['customer'] ?? '';
      _productNameController.text = widget.enquiry!['product'] ?? '';
      _quantityController.text = widget.enquiry!['quantity']?.toString() ?? '';
      _notesController.text = widget.enquiry!['notes'] ?? '';
      _dateController.text = widget.enquiry!['date'] ?? '';
      _productType = widget.enquiry!['status'] == 'Open' ? 'New' : 'Follow up';
      _demoRequired = widget.enquiry!['demo'] ?? 'Yes';
      _purchasePlan = widget.enquiry!['plan'] ?? 'Immediate';
      if (widget.enquiry!['date'] != null) {
        final parts = widget.enquiry!['date'].split('/');
        if (parts.length == 3) {
          _selectedDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
        }
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: isDarkMode
              ? ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: DarkTheme.primaryColor,
              onPrimary: DarkTheme.textColor,
              surface: DarkTheme.backgroundColor,
              onSurface: DarkTheme.textColor,
            ),
            dialogBackgroundColor: DarkTheme.backgroundColor,
            textTheme: GoogleFonts.poppinsTextTheme(),
          )
              : ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppTheme.primaryColor,
              onPrimary: AppTheme.textColor,
              surface: AppTheme.whiteColor,
              onSurface: AppTheme.textColor,
            ),
            dialogBackgroundColor: AppTheme.whiteColor,
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _productNameController.dispose();
    _quantityController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'customer': _customerNameController.text,
        'product': _productNameController.text,
        'quantity': _quantityController.text,
        'plan': _purchasePlan,
        'demo': _demoRequired,
        'status': _productType == 'New' ? 'Open' : 'Validated',
        'date': _dateController.text,
        'notes': _notesController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // 50% blur effect
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.transparent, // Make dialog background transparent to show blur
        child: Container(
          width: 700,
          height: 740,
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
                  Text(
                    'Edit Enquiry',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // First Row
                  Row(
                    children: [
                      Expanded(child: _buildLabeledTextField('Customer Name', _customerNameController, isDarkMode)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildLabeledTextField('Product Name', _productNameController, isDarkMode)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Second Row
                  Row(
                    children: [
                      Expanded(child: _buildLabeledTextField('Quantity', _quantityController, isDarkMode, isNumber: true)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildLabeledDropdown(isDarkMode)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Product Type
                  Text(
                    'Product Type',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                    ),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'New',
                        groupValue: _productType,
                        onChanged: (value) => setState(() => _productType = value!),
                        activeColor: isDarkMode ? DarkTheme.accentColor : AppTheme.primaryColor,
                      ),
                      Text(
                        'New',
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Radio<String>(
                        value: 'Follow up',
                        groupValue: _productType,
                        onChanged: (value) => setState(() => _productType = value!),
                        activeColor: isDarkMode ? DarkTheme.accentColor : AppTheme.primaryColor,
                      ),
                      Text(
                        'Follow up',
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Demo Required
                  Text(
                    'Demo Required',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                    ),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Yes',
                        groupValue: _demoRequired,
                        onChanged: (value) => setState(() => _demoRequired = value!),
                        activeColor: isDarkMode ? DarkTheme.accentColor : AppTheme.primaryColor,
                      ),
                      Text(
                        'Yes',
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Radio<String>(
                        value: 'No',
                        groupValue: _demoRequired,
                        onChanged: (value) => setState(() => _demoRequired = value!),
                        activeColor: isDarkMode ? DarkTheme.accentColor : AppTheme.primaryColor,
                      ),
                      Text(
                        'No',
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Date Picker
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _dateController,
                          readOnly: true,
                          decoration: _inputDecoration('DD/MM/YYYY', isDarkMode).copyWith(
                            suffixIcon: Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: isDarkMode ? DarkTheme.secondaryTextColor : AppTheme.secondaryTextColor,
                              semanticLabel: 'Select date',
                            ),
                          ),
                          onTap: () => _selectDate(context),
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Notes
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notes',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 90,
                        child: TextField(
                          controller: _notesController,
                          minLines: 3,
                          maxLines: 3,
                          decoration: _inputDecoration('Enter Notes', isDarkMode),
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode ? DarkTheme.whiteColor.withOpacity(0.2) : const Color(0xFFD9C9F4),
                          foregroundColor: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('Cancel', style: GoogleFonts.poppins()),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode ? DarkTheme.primaryColor : AppTheme.primaryColor,
                          foregroundColor: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('Update Enquiry', style: GoogleFonts.poppins()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
      String label, TextEditingController controller, bool isDarkMode, {bool isNumber = false}) {
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
            decoration: _inputDecoration('Enter $label', isDarkMode).copyWith(
              suffixIcon: Icon(
                Icons.edit,
                size: 18,
                color: isDarkMode ? DarkTheme.secondaryTextColor : AppTheme.secondaryTextColor,
                semanticLabel: 'Edit $label',
              ),
            ),
            style: GoogleFonts.poppins(
              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
            ),
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            validator: (value) => value!.isEmpty ? '$label is required' : null,
          ),
        ),
      ],
    );
  }

  Widget _buildLabeledDropdown(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Purchase Plan',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: DropdownButtonFormField<String>(
            value: _purchasePlan,
            decoration: _inputDecoration('Choose Purchase Plan', isDarkMode),
            items: ['Immediate', 'Within 2 months', 'Within 3 months']
                .map((e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: GoogleFonts.poppins(
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                ),
              ),
            ))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _purchasePlan = value);
            },
            validator: (value) => value == null ? 'Purchase Plan is required' : null,
          ),
        ),
      ],
    );
  }
}