import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCustomerScreen extends StatelessWidget {
  const AddCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Customer')),
      body: Center(
        child: Text('Customer form goes here', style: GoogleFonts.poppins()),
      ),
    );
  }
}
