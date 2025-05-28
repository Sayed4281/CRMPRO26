import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'validate_checklist_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_enquiry_popup.dart';

class EnquiryDetailsPopup extends StatelessWidget {
  const EnquiryDetailsPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Container(
            width: 900,
            height: 700,
            padding: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F3FC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enquiry Details',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textColor,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT COLUMN
                      SizedBox(
                        width: 380,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionBox([
                              _buildDetailText('Product Name : CT Scanner'),
                              _buildDetailText('Enquiry ID : ENQ-2041'),
                              _buildDetailText('Created on : 01/01/2025'),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  _buildActionButton(
                                    'Validate',
                                    const Color(0xFF6E48AB),
                                    onPressed: () {
                                      ValidateChecklistDialog.show(context);
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  _buildActionButton(
                                    'Update',
                                    const Color(0xFF6E48AB),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            EditEnquiryDialog(),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ]),
                            const SizedBox(height: 16),
                            _buildSectionBox([
                              Row(
                                children: const [
                                  CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Text(
                                      'A',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Phone: +91 9856246584'),
                                        Text('Email: johnsmith@gmail.com'),
                                        Text('Company : ABCD Company'),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ]),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: 380,
                              child: _buildSectionBox([
                                _buildDetailText('Product Type: New'),
                                _buildDetailText('Product name : CT Scanner'),
                                _buildDetailText('Quantity : 100'),
                                _buildDetailText(
                                    'Purchase Plan : Within 3 months'),
                                _buildDetailText('Demo Required: Yes'),
                                _buildDetailText('Demo Date : 01/01/2025'),
                                _buildDetailText(
                                    'Notes : "Looking for fast delivery"'),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      // RIGHT COLUMN
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildInfoCard(
                                    icon: Icons.info,
                                    label: 'Status',
                                    value: 'Open',
                                    iconColor: AppTheme.primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: _buildInfoCard(
                                    icon: Icons.update,
                                    label: 'Last Update on',
                                    value: '01/01/2025',
                                    iconColor: AppTheme.primaryColor,
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
                                color: AppTheme.textColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 420,
                              height: 320,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppTheme.backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Scrollbar(
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  child: DataTable(
                                    columnSpacing: 16,
                                    dataRowMinHeight: 40,
                                    dataRowMaxHeight: 40,
                                    columns: const [
                                      DataColumn(label: Text('SINo')),
                                      DataColumn(label: Text('Time')),
                                      DataColumn(label: Text('Date')),
                                      DataColumn(label: Text('Action')),
                                    ],
                                    rows: const [
                                      DataRow(cells: [
                                        DataCell(Text('01')),
                                        DataCell(Text('08:00 am')),
                                        DataCell(Text('01/01/2025')),
                                        DataCell(Text('Enquiry Created')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('02')),
                                        DataCell(Text('08:10 am')),
                                        DataCell(Text('01/01/2025')),
                                        DataCell(Text('Edited Checklist')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('03')),
                                        DataCell(Text('08:15 am')),
                                        DataCell(Text('01/01/2025')),
                                        DataCell(Text('Updated')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('04')),
                                        DataCell(Text('08:20 am')),
                                        DataCell(Text('01/01/2025')),
                                        DataCell(Text('Updated')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('05')),
                                        DataCell(Text('08:30 am')),
                                        DataCell(Text('01/01/2025')),
                                        DataCell(Text('Demo Scheduled')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('06')),
                                        DataCell(Text('09:00 am')),
                                        DataCell(Text('01/01/2025')),
                                        DataCell(Text('Updated')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('07')),
                                        DataCell(Text('09:15 am')),
                                        DataCell(Text('01/01/2025')),
                                        DataCell(Text('Updated')),
                                      ]),
                                    ],
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
                                    backgroundColor: const Color(0xFF8C1D18),
                                    foregroundColor: AppTheme.whiteColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Confirm Deletion'),
                                        content: const Text(
                                            'Are you sure you want to delete this enquiry?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              // Add your deletion logic here
                                            },
                                            child: const Text('Delete',
                                                style: TextStyle(
                                                    color: Colors.red)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete),
                                  label: const Text('Delete Enquiry'),
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
              child: const Icon(
                Icons.close,
                size: 24,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionBox(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8DEF8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildDetailText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: AppTheme.textColor),
      ),
    );
  }

  Widget _buildActionButton(String label, Color color,
      {required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: AppTheme.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(label),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8DEF8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 30),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 6),
              Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }
}
