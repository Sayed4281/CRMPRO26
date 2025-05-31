import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _designationController;
  late TextEditingController _locationController;
  late String _status;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer['name']);
    _customerIdController =
        TextEditingController(text: widget.customer['customerId']);
    _companyController = TextEditingController(text: widget.customer['company']);
    _phoneController = TextEditingController(text: widget.customer['phone']);
    _emailController = TextEditingController(text: widget.customer['email']);
    _addressController = TextEditingController(text: widget.customer['address']);
    _designationController =
        TextEditingController(text: widget.customer['designation']);
    _locationController =
        TextEditingController(text: widget.customer['location']);
    _status = widget.customer['status'] ?? 'Active';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _customerIdController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _designationController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit Customer',
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Customer Name',
                      hintText: 'Enter Customer name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF6C5DD3)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a customer name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _customerIdController,
                    decoration: InputDecoration(
                      labelText: 'Customer ID',
                      hintText: 'Enter Customer ID (e.g., CUST-XXXX)',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF6C5DD3)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a customer ID';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _companyController,
                    decoration: InputDecoration(
                      labelText: 'Company',
                      hintText: 'Enter Company name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF6C5DD3)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a company name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            hintText: 'Enter Phone number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: Color(0xFFD9D9D9)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: Color(0xFF6C5DD3)),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: Color(0xFFD9D9D9)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: Color(0xFF6C5DD3)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              final emailRegExp =
                              RegExp(r'^[^@]+@[^@]+\.[^@]+');
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
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      hintText: 'Enter Address',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF6C5DD3)),
                      ),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _designationController,
                          decoration: InputDecoration(
                            labelText: 'Designation',
                            hintText: 'Enter Designation',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: Color(0xFFD9D9D9)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: Color(0xFF6C5DD3)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _locationController,
                          decoration: InputDecoration(
                            labelText: 'Location',
                            hintText: 'Enter Location',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: Color(0xFFD9D9D9)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: Color(0xFF6C5DD3)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _status,
                    decoration: InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF6C5DD3)),
                      ),
                    ),
                    items: ['Active', 'Inactive'].map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status, style: GoogleFonts.poppins()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _status = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF6C5DD3),
                            fontSize: 14,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final updatedCustomer = {
                              'index': widget.customers[widget.index]['index']!,
                              'name': _nameController.text,
                              'customerId': _customerIdController.text,
                              'company': _companyController.text,
                              'phone': _phoneController.text,
                              'email': _emailController.text,
                              'address': _addressController.text,
                              'designation': _designationController.text,
                              'location': _locationController.text,
                              'status': _status,
                            };
                            widget.onSave(updatedCustomer, widget.index);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Customer updated successfully',
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Save',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 14),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C5DD3),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
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
}