import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';
import 'validate_checklist_dialog.dart';
import 'edit_enquiry_popup.dart';

class EnquiryDetailsPopup extends StatelessWidget {
  final Map<String, dynamic> enquiry;

  const EnquiryDetailsPopup({super.key, required this.enquiry});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Dynamically calculate height based on screen size, with a max limit
            final maxHeight = MediaQuery.of(context).size.height * 0.9; // 90% of screen height
            final maxWidth = MediaQuery.of(context).size.width * 0.9; // 90% of screen width

            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: maxHeight,
                maxWidth: maxWidth.clamp(0, 900), // Ensure width doesn't exceed 900
              ),
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      color: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFF7F3FC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // Allow the column to shrink to content size
                      children: [
                        Text(
                          'Enquiry Details',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Use Flexible to allow the Row to take only the space it needs
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // LEFT COLUMN (Scrollable)
                              SizedBox(
                                width: 380,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildSectionBox(
                                        [
                                          _buildDetailText('Product Name: ${enquiry['product'] ?? 'N/A'}', isDarkMode),
                                          _buildDetailText('Enquiry ID: ${enquiry['enquiryId'] ?? 'N/A'}', isDarkMode),
                                          _buildDetailText('Created on: ${enquiry['date'] ?? 'N/A'}', isDarkMode),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              _buildActionButton(
                                                'Validate',
                                                isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6E48AB),
                                                isDarkMode: isDarkMode,
                                                onPressed: () {
                                                  ValidateChecklistDialog.show(context).then((result) {
                                                    if (result != null) {
                                                      Navigator.of(context).pop(result);
                                                    }
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 10),
                                              _buildActionButton(
                                                'Update',
                                                isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6E48AB),
                                                isDarkMode: isDarkMode,
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) => EditEnquiryDialog(enquiry: enquiry),
                                                  ).then((result) {
                                                    if (result != null) {
                                                      Navigator.of(context).pop(result);
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                        isDarkMode,
                                      ),
                                      const SizedBox(height: 16),
                                      _buildSectionBox(
                                        [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: isDarkMode ? DarkTheme.textColor : Colors.black,
                                                child: Text(
                                                  enquiry['customer']?.toString()[0] ?? 'A',
                                                  style: TextStyle(
                                                    color: isDarkMode ? DarkTheme.backgroundColor : Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    _buildDetailText('Phone: ${enquiry['phone'] ?? '+91 9856246584'}', isDarkMode),
                                                    _buildDetailText('Email: ${enquiry['email'] ?? 'johnsmith@gmail.com'}', isDarkMode),
                                                    _buildDetailText('Company: ${enquiry['company'] ?? 'ABCD Company'}', isDarkMode),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                        isDarkMode,
                                      ),
                                      const SizedBox(height: 16),
                                      _buildSectionBox(
                                        [
                                          _buildDetailText('Product Type: ${enquiry['productType'] ?? 'New'}', isDarkMode),
                                          _buildDetailText('Product Name: ${enquiry['product'] ?? 'N/A'}', isDarkMode),
                                          _buildDetailText('Quantity: ${enquiry['quantity'] ?? 'N/A'}', isDarkMode),
                                          _buildDetailText('Purchase Plan: ${enquiry['plan'] ?? 'N/A'}', isDarkMode),
                                          _buildDetailText('Demo Required: ${enquiry['demo'] ?? 'N/A'}', isDarkMode),
                                          _buildDetailText('Demo Date: ${enquiry['demoDate'] ?? 'N/A'}', isDarkMode),
                                          _buildDetailText('Notes: "${enquiry['notes'] ?? 'N/A'}"', isDarkMode),
                                        ],
                                        isDarkMode,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              // RIGHT COLUMN (Non-scrollable except for Activity Log)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildInfoCard(
                                            icon: Icons.info,
                                            label: 'Status',
                                            value: enquiry['status'] ?? 'N/A',
                                            iconColor: isDarkMode ? DarkTheme.accentColor : AppTheme.primaryColor,
                                            isDarkMode: isDarkMode,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: _buildInfoCard(
                                            icon: Icons.update,
                                            label: 'Last Update on',
                                            value: enquiry['date'] ?? 'N/A',
                                            iconColor: isDarkMode ? DarkTheme.accentColor : AppTheme.primaryColor,
                                            isDarkMode: isDarkMode,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Activity Log',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: 420,
                                      height: 200, // Fixed height for activity log
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: isDarkMode ? DarkTheme.backgroundColor : AppTheme.backgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Scrollbar(
                                        thumbVisibility: true,
                                        child: SingleChildScrollView(
                                          child: DataTable(
                                            columnSpacing: 16,
                                            dataRowMinHeight: 40,
                                            dataRowMaxHeight: 40,
                                            columns: [
                                              DataColumn(
                                                label: Text(
                                                  'SINo',
                                                  style: GoogleFonts.poppins(
                                                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Time',
                                                  style: GoogleFonts.poppins(
                                                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Date',
                                                  style: GoogleFonts.poppins(
                                                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Action',
                                                  style: GoogleFonts.poppins(
                                                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                            rows: _buildActivityLogRows(isDarkMode),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: isDarkMode ? DarkTheme.errorColor : const Color(0xFF8C1D18),
                                            foregroundColor: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                backgroundColor: isDarkMode ? DarkTheme.whiteColor : AppTheme.whiteColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                title: Text(
                                                  'Confirm Deletion',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                                                  ),
                                                ),
                                                content: Text(
                                                  'Are you sure you want to delete this enquiry?',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : AppTheme.textColor,
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.of(context).pop(),
                                                    child: Text(
                                                      'Cancel',
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop(enquiry['index']);
                                                    },
                                                    child: Text(
                                                      'Delete',
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        color: isDarkMode ? DarkTheme.errorColor : Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                                          ),
                                          label: Text(
                                            'Delete Enquiry',
                                            style: GoogleFonts.poppins(
                                              color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Cross button in top-right corner
                  Positioned(
                    right: 16,
                    top: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.close,
                        size: 24,
                        color: isDarkMode ? DarkTheme.textColor : Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<DataRow> _buildActivityLogRows(bool isDarkMode) {
    // Check if activity log exists in enquiry, otherwise provide default data
    final List<Map<String, dynamic>> activities = enquiry['activityLog'] != null
        ? List<Map<String, dynamic>>.from(enquiry['activityLog'])
        : [
      {
        'index': enquiry['index'] ?? '01',
        'time': '08:00 am',
        'date': enquiry['date'] ?? '01/01/2025',
        'action': 'Enquiry Created',
      },
      {
        'index': '02',
        'time': '08:10 am',
        'date': enquiry['date'] ?? '01/01/2025',
        'action': 'Edited Checklist',
      },
      {
        'index': '03',
        'time': '08:15 am',
        'date': enquiry['date'] ?? '01/01/2025',
        'action': 'Updated',
      },
    ];

    return activities.asMap().entries.map((entry) {
      final index = entry.key;
      final activity = entry.value;
      return DataRow(cells: [
        DataCell(Text(
          activity['index'] ?? (index + 1).toString().padLeft(2, '0'),
          style: GoogleFonts.poppins(
            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
          ),
        )),
        DataCell(Text(
          activity['time'] ?? 'N/A',
          style: GoogleFonts.poppins(
            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
          ),
        )),
        DataCell(Text(
          activity['date'] ?? 'N/A',
          style: GoogleFonts.poppins(
            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
          ),
        )),
        DataCell(Text(
          activity['action'] ?? 'N/A',
          style: GoogleFonts.poppins(
            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
          ),
        )),
      ]);
    }).toList();
  }

  Widget _buildSectionBox(List<Widget> children, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? DarkTheme.backgroundColor : const Color(0xFFE8DEF8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildDetailText(String text, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
        ),
      ),
    );
  }

  Widget _buildActionButton(
      String label,
      Color color, {
        required bool isDarkMode,
        required VoidCallback onPressed,
      }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
    required bool isDarkMode,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? DarkTheme.backgroundColor : const Color(0xFFE8DEF8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 30),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}