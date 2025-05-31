import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';

class ValidateChecklistDialog {
  static Future<Map<String, String>?> show(BuildContext context) {
    return showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // 50% blur effect
          child: Dialog(
            backgroundColor: Colors.transparent, // Make dialog background transparent to show blur
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ValidateChecklistForm(),
          ),
        );
      },
    );
  }
}

class ValidateChecklistForm extends StatefulWidget {
  @override
  _ValidateChecklistFormState createState() => _ValidateChecklistFormState();
}

class _ValidateChecklistFormState extends State<ValidateChecklistForm> {
  final Map<String, List<String>> questionOptions = {
    "Will the customer prefer our brand ?": ["Yes", "No"],
    "Reason for purchase": ["New Speciality", "Equipment is damaged", "Additional unit"],
    "Do they have surgeries currently ?": ["Yes", "No"],
    "Will the management invest ?": ["Yes", "No"],
    "Is the doctor new in the hospital ?": ["Yes", "No"],
    "Doctor Experience": ["Senior", "Experienced", "Fresh"],
    "Usage Type": ["Single Dept", "Multiple Dept"],
    "Demo required ?": ["Yes", "No"],
    "Purchase Plan": ["Immediate", "Within 2 Months", "Within 3 months"],
    "Buyer type": ["Individual", "Hospital", "Dealer"],
    "Hospital type": ["Private Single Owner", "Corporate", "Co-operative", "Government"],
  };

  final Map<String, String?> selectedValues = {};
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    for (var label in questionOptions.keys) {
      selectedValues[label] = null;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, selectedValues);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 810,
      height: 800,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: isDarkMode ? DarkTheme.backgroundColor : AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              "Validate Checklist",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: questionOptions.keys.map((label) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: isDarkMode ? DarkTheme.whiteColor.withOpacity(0.2) : const Color(0xFFE5D6FA),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  label,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: DropdownButtonFormField<String>(
                                value: selectedValues[label],
                                items: (questionOptions[label] ?? [])
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
                                onChanged: (val) {
                                  setState(() {
                                    selectedValues[label] = val;
                                  });
                                },
                                validator: (value) => value == null ? 'Please select an option' : null,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                                    color: isDarkMode ? DarkTheme.secondaryTextColor : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                  child: Text('Submit', style: GoogleFonts.poppins()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}