
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VisitsScreen extends StatelessWidget {
  const VisitsScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentPage: VisitsScreen,
      content: Center(
        child: Text(
          'Visits Screen',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
