import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class EditEnquiryDialog extends StatefulWidget {
  const EditEnquiryDialog({super.key});

  @override
  State<EditEnquiryDialog> createState() => _EditEnquiryDialogState();
}

class _EditEnquiryDialogState extends State<EditEnquiryDialog> {
  String _productType = 'New';
  String _demoRequired = 'Yes';
  DateTime? _selectedDate = DateTime(2025, 1, 7);
  final TextEditingController _dateController =
      TextEditingController(text: '7/1/2025');

  final TextEditingController _customerNameController =
      TextEditingController(text: 'Dr. John Smith');
  final TextEditingController _productNameController =
      TextEditingController(text: 'CT Scanner');
  final TextEditingController _quantityController =
      TextEditingController(text: '100');
  final TextEditingController _notesController =
      TextEditingController(text: 'Looking for fast delivery');
  String _purchasePlan = 'Immediate';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: const Color(0xFFF7F3FC),
      child: SizedBox(
        width: 700,
        height: 740,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Enquiry',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 24),

              // First Row
              Row(
                children: [
                  Expanded(
                      child: _buildLabeledTextField(
                          'Customer Name', _customerNameController)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: _buildLabeledTextField(
                          'Product Name', _productNameController)),
                ],
              ),
              const SizedBox(height: 16),

              // Second Row
              Row(
                children: [
                  Expanded(
                      child: _buildLabeledTextField(
                          'Quantity', _quantityController)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildLabeledDropdown(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Product Type
              Text('Product Type', style: GoogleFonts.poppins()),
              Row(
                children: [
                  Radio<String>(
                    value: 'New',
                    groupValue: _productType,
                    onChanged: (value) => setState(() => _productType = value!),
                  ),
                  const Text('New'),
                  const SizedBox(width: 16),
                  Radio<String>(
                    value: 'Follow up',
                    groupValue: _productType,
                    onChanged: (value) => setState(() => _productType = value!),
                  ),
                  const Text('Follow up'),
                ],
              ),
              const SizedBox(height: 8),

              // Demo Required
              Text('Demo Required', style: GoogleFonts.poppins()),
              Row(
                children: [
                  Radio<String>(
                    value: 'Yes',
                    groupValue: _demoRequired,
                    onChanged: (value) =>
                        setState(() => _demoRequired = value!),
                  ),
                  const Text('Yes'),
                  const SizedBox(width: 20),
                  Radio<String>(
                    value: 'No',
                    groupValue: _demoRequired,
                    onChanged: (value) =>
                        setState(() => _demoRequired = value!),
                  ),
                  const Text('No'),
                ],
              ),
              const SizedBox(height: 16),

              // Date Picker
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date', style: GoogleFonts.poppins(fontSize: 14)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _dateController,
                      readOnly: true,
                      decoration: _inputDecoration('DD/MM/YYYY').copyWith(
                        suffixIcon: const Icon(Icons.calendar_today, size: 16),
                      ),
                      onTap: () => _selectDate(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Notes
              // Notes
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notes', style: GoogleFonts.poppins(fontSize: 14)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 90,
                    child: TextField(
                      controller: _notesController,
                      minLines: 3,
                      maxLines: 3,
                      decoration: _inputDecoration('Enter Notes').copyWith(
                        suffixIcon: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.black,
                        ),
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
                      backgroundColor: const Color(0xFFD9C9F4),
                      foregroundColor: AppTheme.textColor,
                    ),
                    child: Text('Cancel', style: GoogleFonts.poppins()),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Save update logic
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: AppTheme.whiteColor,
                    ),
                    child: Text('Update Enquiry', style: GoogleFonts.poppins()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  Widget _buildLabeledTextField(
      String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 14)),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
            decoration: _inputDecoration('Enter $label').copyWith(
              suffixIcon: const Icon(
                Icons.edit,
                size: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabeledDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Purchase Plan', style: GoogleFonts.poppins(fontSize: 14)),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: DropdownButtonFormField<String>(
            value: _purchasePlan,
            decoration: _inputDecoration('Choose Purchase Plan'),
            items: ['Immediate', 'Within 2 months', 'Within 3 months']
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: GoogleFonts.poppins()),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _purchasePlan = value);
            },
          ),
        ),
      ],
    );
  }
}
