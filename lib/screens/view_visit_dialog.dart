import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< HEAD
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';
=======
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0

class ViewVisitDialog extends StatelessWidget {
  final Map<String, String> visit;

  const ViewVisitDialog({super.key, required this.visit});

  bool _shouldShowField(String field, String visitType, String? status) {
    // Always include name, visitId, and type
    if (['name', 'visitId', 'type'].contains(field)) {
      return true;
    }
    switch (visitType) {
      case 'New':
        return [
          'person1',
          'person2',
          'person3',
          'person4',
          'contactNumber',
          'designation',
          'requirements'
        ].contains(field);
      case 'Follow-up':
        return ['lead', 'discussion'].contains(field);
      case 'Demo':
<<<<<<< HEAD
        return ['lead', 'demoGivenTo', 'status', 'completionDate', 'feedback', 'reason']
            .contains(field) &&
            (field != 'reason' || (status == 'In Progress' || status == 'Cancelled'));
=======
        return ['lead', 'demoGivenTo', 'status', 'completionDate', 'feedback'].contains(field);
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
      case 'Installation':
        return ['lead', 'status', 'trainingGivenTo', 'remarks'].contains(field);
      case 'Training':
        return ['lead', 'status', 'reason', 'trainingGivenTo', 'remarks'].contains(field) &&
            (field != 'reason' || (status == 'In Progress' || status == 'Cancelled'));
      case 'Service':
        return ['equipment', 'issueReport', 'status', 'reason', 'remarks'].contains(field) &&
            (field != 'reason' || (status == 'In Progress' || status == 'Cancelled'));
      case 'Payment':
        return ['lead', 'amount', 'paymentCollected', 'remarks'].contains(field);
      default:
        return ['status', 'completionDate', 'feedback', 'trainingGivenTo', 'remarks', 'equipment', 'issueReport', 'reason', 'paymentCollected']
            .contains(field) &&
            (field != 'reason' || (status == 'In Progress' || status == 'Cancelled'));
    }
  }

<<<<<<< HEAD
=======
  // New method to map field names to display labels
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
  String _getDisplayLabel(String field) {
    const fieldToLabelMap = {
      'name': 'Customer Name',
      'type': 'Visit Type',
      'visitId': 'Visit ID',
      'person1': 'Person 1',
      'person2': 'Person 2',
      'person3': 'Person 3',
      'person4': 'Person 4',
      'contactNumber': 'Contact Number',
      'designation': 'Designation',
      'requirements': 'Requirements',
      'lead': 'Lead',
      'discussion': 'Discussion',
      'demoGivenTo': 'Demo Given To',
      'status': 'Status',
      'completionDate': 'Completion Date',
      'feedback': 'Feedback',
      'trainingGivenTo': 'Training Given To',
      'remarks': 'Remarks',
      'equipment': 'Equipment',
      'issueReport': 'Issue Report',
      'reason': 'Reason',
      'amount': 'Amount',
      'paymentCollected': 'Payment Collected',
    };
<<<<<<< HEAD
    return fieldToLabelMap[field] ?? field;
  }

  Widget _buildDetailRow(String label, String value, bool isDarkMode, {int maxLines = 1}) {
=======
    return fieldToLabelMap[field] ?? field; // Fallback to field name if not mapped
  }

  Widget _buildDetailRow(String label, String value, {int maxLines = 1}) {
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
<<<<<<< HEAD
              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
=======
              color: const Color(0xCC000000),
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
            ),
          ),
          const SizedBox(height: 2),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
<<<<<<< HEAD
              color: isDarkMode ? DarkTheme.backgroundColor : Colors.white,
              border: Border.all(
                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xCC000000),
                width: 1,
              ),
=======
              color: Colors.white,
              border: Border.all(color: const Color(0xCC000000), width: 1),
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 12,
<<<<<<< HEAD
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
=======
                color: const Color(0xCC000000),
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
              ),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final String visitType = visit['type'] ?? 'Unknown';
    final String? status = visit['status'];

=======
    final String visitType = visit['type'] ?? 'Unknown';
    final String? status = visit['status'];

    // List of all possible fields
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
    final allFields = [
      'name',
      'type',
      'visitId',
      'person1',
      'person2',
      'person3',
      'person4',
      'contactNumber',
      'designation',
      'requirements',
      'lead',
      'discussion',
      'demoGivenTo',
      'status',
      'completionDate',
      'feedback',
      'trainingGivenTo',
      'remarks',
      'equipment',
      'issueReport',
      'reason',
      'amount',
      'paymentCollected',
    ];

<<<<<<< HEAD
    final visibleFields = allFields.where((field) => _shouldShowField(field, visitType, status)).toList();

=======
    // Filter fields that should be shown and handle nulls
    final visibleFields = allFields.where((field) => _shouldShowField(field, visitType, status)).toList();

    // Ensure name, type, and visitId are included
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
    final Map<String, String> displayVisit = Map.from(visit);
    displayVisit['name'] ??= 'N/A';
    displayVisit['type'] ??= 'Unknown';
    displayVisit['visitId'] ??= 'N/A';

<<<<<<< HEAD
=======
    // Fields that can take a full row
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
    final fullWidthFields = [
      'requirements',
      'discussion',
      'feedback',
      'remarks',
      'issueReport',
      'reason'
    ];

<<<<<<< HEAD
    final fullWidth = visibleFields.where((field) => fullWidthFields.contains(field) && displayVisit[field] != null).toList();
    final toPair = visibleFields.where((field) => !fullWidthFields.contains(field) && displayVisit[field] != null).toList();

=======
    // Separate fields into full-width and those needing pairing
    final fullWidth = visibleFields.where((field) => fullWidthFields.contains(field) && displayVisit[field] != null).toList();
    final toPair = visibleFields.where((field) => !fullWidthFields.contains(field) && displayVisit[field] != null).toList();

    // Prioritize name, type, and visitId at the start
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
    final orderedToPair = ['name', 'type', 'visitId']
        .where((field) => toPair.contains(field))
        .toList()
      ..addAll(toPair.where((field) => !['name', 'type', 'visitId'].contains(field)));

<<<<<<< HEAD
=======
    // Build rows for paired fields
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
    final List<Widget> rows = [];
    for (int i = 0; i < orderedToPair.length; i += 2) {
      final field1 = orderedToPair[i];
      final field2 = i + 1 < orderedToPair.length ? orderedToPair[i + 1] : null;
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildDetailRow(
<<<<<<< HEAD
                _getDisplayLabel(field1),
                field1 == 'completionDate'
                    ? DateTime.parse(displayVisit[field1]!).toString().split(' ')[0]
                    : displayVisit[field1]!,
                isDarkMode,
=======
                _getDisplayLabel(field1), // Use the mapped label
                field1 == 'completionDate'
                    ? DateTime.parse(displayVisit[field1]!).toString().split(' ')[0]
                    : displayVisit[field1]!,
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: field2 != null
                  ? _buildDetailRow(
<<<<<<< HEAD
                _getDisplayLabel(field2),
                field2 == 'completionDate'
                    ? DateTime.parse(displayVisit[field2]!).toString().split(' ')[0]
                    : displayVisit[field2]!,
                isDarkMode,
=======
                _getDisplayLabel(field2), // Use the mapped label
                field2 == 'completionDate'
                    ? DateTime.parse(displayVisit[field2]!).toString().split(' ')[0]
                    : displayVisit[field2]!,
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    }

<<<<<<< HEAD
    for (final field in fullWidth) {
      rows.add(
        _buildDetailRow(
          _getDisplayLabel(field),
          field == 'completionDate'
              ? DateTime.parse(displayVisit[field]!).toString().split(' ')[0]
              : displayVisit[field]!,
          isDarkMode,
=======
    // Add full-width fields
    for (final field in fullWidth) {
      rows.add(
        _buildDetailRow(
          _getDisplayLabel(field), // Use the mapped label
          field == 'completionDate'
              ? DateTime.parse(displayVisit[field]!).toString().split(' ')[0]
              : displayVisit[field]!,
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
          maxLines: 3,
        ),
      );
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
<<<<<<< HEAD
        backgroundColor: isDarkMode ? DarkTheme.whiteColor : Colors.white,
=======
        backgroundColor: Colors.white,
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
        elevation: 8,
        contentPadding: const EdgeInsets.all(12),
        titlePadding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Visit Details',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
<<<<<<< HEAD
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                size: 20,
              ),
=======
                color: const Color(0xCC000000),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.grey, size: 20),
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
              padding: const EdgeInsets.all(0),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 650,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rows,
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
<<<<<<< HEAD
                    side: BorderSide(
                      color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xCC000000),
                      width: 1,
                    ),
=======
                    side: const BorderSide(color: Color(0xCC000000), width: 1),
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
                  ),
                ),
                child: Text(
                  'Close',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
<<<<<<< HEAD
                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
=======
                    color: const Color(0xCC000000),
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
                  ),
                ),
              ),
            ],
          ),
        ],
        actionsPadding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
