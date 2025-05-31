import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';

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
        return ['lead', 'demoGivenTo', 'status', 'completionDate', 'feedback', 'reason']
            .contains(field) &&
            (field != 'reason' || (status == 'In Progress' || status == 'Cancelled'));
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
    return fieldToLabelMap[field] ?? field;
  }

  Widget _buildDetailRow(String label, String value, bool isDarkMode, {int maxLines = 1}) {
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
              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isDarkMode ? DarkTheme.backgroundColor : Colors.white,
              border: Border.all(
                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xCC000000),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final String visitType = visit['type'] ?? 'Unknown';
    final String? status = visit['status'];

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

    final visibleFields = allFields.where((field) => _shouldShowField(field, visitType, status)).toList();

    final Map<String, String> displayVisit = Map.from(visit);
    displayVisit['name'] ??= 'N/A';
    displayVisit['type'] ??= 'Unknown';
    displayVisit['visitId'] ??= 'N/A';

    final fullWidthFields = [
      'requirements',
      'discussion',
      'feedback',
      'remarks',
      'issueReport',
      'reason'
    ];

    final fullWidth = visibleFields.where((field) => fullWidthFields.contains(field) && displayVisit[field] != null).toList();
    final toPair = visibleFields.where((field) => !fullWidthFields.contains(field) && displayVisit[field] != null).toList();

    final orderedToPair = ['name', 'type', 'visitId']
        .where((field) => toPair.contains(field))
        .toList()
      ..addAll(toPair.where((field) => !['name', 'type', 'visitId'].contains(field)));

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
                _getDisplayLabel(field1),
                field1 == 'completionDate'
                    ? DateTime.parse(displayVisit[field1]!).toString().split(' ')[0]
                    : displayVisit[field1]!,
                isDarkMode,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: field2 != null
                  ? _buildDetailRow(
                _getDisplayLabel(field2),
                field2 == 'completionDate'
                    ? DateTime.parse(displayVisit[field2]!).toString().split(' ')[0]
                    : displayVisit[field2]!,
                isDarkMode,
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    }

    for (final field in fullWidth) {
      rows.add(
        _buildDetailRow(
          _getDisplayLabel(field),
          field == 'completionDate'
              ? DateTime.parse(displayVisit[field]!).toString().split(' ')[0]
              : displayVisit[field]!,
          isDarkMode,
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
        backgroundColor: isDarkMode ? DarkTheme.whiteColor : Colors.white,
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
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                size: 20,
              ),
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
                    side: BorderSide(
                      color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xCC000000),
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  'Close',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
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
}