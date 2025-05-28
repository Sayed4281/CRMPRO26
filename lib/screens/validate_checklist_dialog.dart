import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ValidateChecklistDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ValidateChecklistForm(),
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
    "Reason for purchase": [
      "New Speciality",
      "Equipment is damaged",
      "Additional unit"
    ],
    "Do they have surgeries currently ?": ["Yes", "No"],
    "Will the management invest ?": ["Yes", "No"],
    "Is the doctor new in the hospital ?": ["Yes", "No"],
    "Doctor Experience": ["Senior", "Experienced", "Fresh"],
    "Usage Type": ["Single Dept", "Multiple Dept"],
    "Demo required ?": ["Yes", "No"],
    "Purchase Plan": ["Immediate", "Within 2 Months", "Within 3 months"],
    "Buyer type": ["Individual", "Hospital", "Dealer"],
    "Hospital type": [
      "Private Single Owner",
      "Corperate",
      "Co-operative",
      "Government"
    ],
  };

  Map<String, String?> selectedValues = {};

  @override
  void initState() {
    super.initState();
    for (var label in questionOptions.keys) {
      selectedValues[label] = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 810,
      height: 800,
      padding: EdgeInsets.all(40),
      child: Column(
        children: [
          Text(
            "Validate Checklist",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppTheme.textColor,
            ),
          ),
          SizedBox(height: 10),
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
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Color(0xFFE5D6FA),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                label,
                                style: TextStyle(fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: DropdownButtonFormField<String>(
                              value: selectedValues[label],
                              items: (questionOptions[label] ?? [])
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  selectedValues[label] = val;
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
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
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD9C9F4),
                  foregroundColor: AppTheme.textColor,
                ),
                child: Text('Cancel', style: GoogleFonts.poppins()),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: AppTheme.whiteColor,
                ),
                child: Text('Add Enquiry', style: GoogleFonts.poppins()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
