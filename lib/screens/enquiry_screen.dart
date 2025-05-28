import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'main_layout.dart';
import '../theme/app_theme.dart';
import 'add_enquiry_dialog.dart';
import 'enquiry_details_popup.dart';
import 'validate_checklist_dialog.dart';
import 'edit_enquiry_popup.dart';
import 'home_screen.dart';

class EnquiryScreen extends StatefulWidget {
  const EnquiryScreen({super.key});

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  final int rowsPerPage = 5;
  int currentPage = 0;

  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  String filter = 'All';
  List<String> filters = ['All', 'Open', 'Validated'];

  final List<Map<String, dynamic>> allEnquiries = List.generate(30, (index) {
    return {
      "slno": (index + 1).toString().padLeft(2, '0'),
      "customer": "Dr. Patel",
      "enquiryId": "ENQ-204${index % 10}",
      "product": "CT Scanner",
      "plan": "Immediate",
      "demo": "Yes",
      "status": index % 2 == 0 ? "Validated" : "Open",
    };
  });

  List<Map<String, dynamic>> get filteredEnquiries {
    final byStatus = filter == 'All'
        ? allEnquiries
        : allEnquiries.where((e) => e['status'] == filter).toList();

    if (searchQuery.isEmpty) return byStatus;

    return byStatus.where((e) {
      final name = e['customer'].toString().toLowerCase();
      final id = e['enquiryId'].toString().toLowerCase();
      final query = searchQuery.toLowerCase();
      return name.contains(query) || id.contains(query);
    }).toList();
  }

  List<Map<String, dynamic>> get paginatedEnquiries {
    final start = currentPage * rowsPerPage;
    final end = (start + rowsPerPage) > filteredEnquiries.length
        ? filteredEnquiries.length
        : (start + rowsPerPage);
    return filteredEnquiries.sublist(start, end);
  }

  int get totalRows => filteredEnquiries.length;

  void nextPage() {
    setState(() {
      if ((currentPage + 1) * rowsPerPage < totalRows) currentPage++;
    });
  }

  void prevPage() {
    setState(() {
      if (currentPage > 0) currentPage--;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void deleteEnquiry(String slno) {
    setState(() {
      allEnquiries.removeWhere((e) => e['slno'] == slno);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentPage: EnquiryScreen,
      content: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumb navigation
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  child: Text(
                    'Dashboard',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 1, 7, 12),
                    ),
                  ),
                ),
                Text(
                  ' > Enquiries',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 1, 7, 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Enquiry summary title
            Text(
              "Enquiries Summary",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppTheme.textColor,
              ),
            ),
            const SizedBox(height: 16),
            const EnquirySummaryCards(),

            const SizedBox(height: 32),
            Text(
              "Enquiries List",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textColor,
              ),
            ),
            const SizedBox(height: 16),

            // Search and filter
            SearchAndFilter(
              width: 710,
              height: 35,
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  currentPage = 0;
                });
              },
            ),
            const SizedBox(height: 12),

            // Status filter chips
            Row(
              children: filters.map((f) {
                final isSelected = filter == f;
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        filter = f;
                        currentPage = 0;
                      });
                    },
                    child: Text(
                      f,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? AppTheme.textColor : Colors.grey,
                        decoration:
                            isSelected ? TextDecoration.underline : null,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            EnquiriesTable(
              enquiries: paginatedEnquiries,
              currentPage: currentPage,
              rowsPerPage: rowsPerPage,
              width: double.infinity,
              rowHeight: 36,
            ),
            const SizedBox(height: 8),
            PaginationControls(
              currentPage: currentPage,
              rowsPerPage: rowsPerPage,
              totalRows: totalRows,
              onNext: nextPage,
              onPrev: prevPage,
            ),
          ],
        ),
      ),
    );
  }
}

class EnquirySummaryCards extends StatelessWidget {
  const EnquirySummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        summaryCard('Total\n1,245 Enquiries', Icons.insert_drive_file),
        summaryCard('New This Month\n11', Icons.new_releases),
        summaryCard('Total Open Enquiries\n147', Icons.pending_actions),
        summaryCard('Total Validated Enquiries\n526', Icons.verified),
      ],
    );
  }

  Widget summaryCard(String title, IconData icon) {
    return Expanded(
      child: SizedBox(
        height: 120,
        child: Card(
          color: AppTheme.whiteColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.2)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(icon, color: AppTheme.primaryColor, size: 36),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchAndFilter extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchAndFilter({
    super.key,
    required this.width,
    required this.height,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width,
          height: height,
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'Search by name/ID',
              prefixIcon:
                  const Icon(Icons.search, color: AppTheme.secondaryTextColor),
              filled: true,
              fillColor: AppTheme.whiteColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppTheme.textColor,
                  width: 1,
                ),
              ),
              hintStyle: GoogleFonts.poppins(
                fontSize: 10,
                color: AppTheme.secondaryTextColor,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            ),
            style: GoogleFonts.poppins(fontSize: 10),
          ),
        ),
        const SizedBox(width: 200),
        Tooltip(
          message: 'Import Enquiries',
          child: InkWell(
            onTap: () {
              _showImportDialog(context);
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: const Icon(
                Icons.upload_file,
                size: 20,
                color: AppTheme.textColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 136,
          height: 40,
          child: ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddEnquiryDialog(),
              );
            },
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Add Enquiry', style: TextStyle(fontSize: 10)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: AppTheme.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        )
      ],
    );
  }
}

class EnquiriesTable extends StatelessWidget {
  final List<Map<String, dynamic>> enquiries;
  final int currentPage;
  final int rowsPerPage;
  final double width;
  final double rowHeight;

  const EnquiriesTable({
    super.key,
    required this.enquiries,
    required this.currentPage,
    required this.rowsPerPage,
    required this.width,
    required this.rowHeight,
  });

  @override
  Widget build(BuildContext context) {
    final rows = enquiries.map((item) {
      return DataRow(
        color: MaterialStateProperty.all(Colors.white),
        cells: [
          DataCell(
              Text(item["slno"], style: GoogleFonts.poppins(fontSize: 10))),
          DataCell(
              Text(item["customer"], style: GoogleFonts.poppins(fontSize: 10))),
          DataCell(Text(item["enquiryId"],
              style: GoogleFonts.poppins(fontSize: 10))),
          DataCell(
              Text(item["product"], style: GoogleFonts.poppins(fontSize: 10))),
          DataCell(
              Text(item["plan"], style: GoogleFonts.poppins(fontSize: 10))),
          DataCell(
              Text(item["demo"], style: GoogleFonts.poppins(fontSize: 10))),
          DataCell(
              Text(item["status"], style: GoogleFonts.poppins(fontSize: 10))),
          DataCell(
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'view') {
                  showDialog(
                    context: context,
                    builder: (_) => const EnquiryDetailsPopup(),
                  );
                } else if (value == 'validate') {
                  ValidateChecklistDialog.show(context);
                } else if (value == 'edit') {
                  showDialog(
                    context: context,
                    builder: (context) => EditEnquiryDialog(),
                  );
                } else if (value == 'delete') {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirm Delete'),
                        content: Text(
                          'Are you sure you want to delete enquiry ${item["slno"]}?',
                          style: GoogleFonts.poppins(),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel', style: GoogleFonts.poppins()),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                              final state = context.findAncestorStateOfType<
                                  _EnquiryScreenState>();
                              state?.deleteEnquiry(item["slno"]);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Enquiry ${item["slno"]} deleted'),
                                ),
                              );
                            },
                            child: Text('Delete',
                                style:
                                    GoogleFonts.poppins(color: Colors.white)),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'view', child: Text('View')),
                const PopupMenuItem(value: 'validate', child: Text('Validate')),
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
              icon: const Icon(Icons.more_vert,
                  color: AppTheme.textColor, size: 18),
            ),
          ),
        ],
      );
    }).toList();

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
      ),
      child: DataTable(
        headingRowColor:
            MaterialStateProperty.all(AppTheme.primaryColor.withOpacity(0.1)),
        headingTextStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: AppTheme.primaryColor,
        ),
        dataTextStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.normal,
          fontSize: 10,
          color: AppTheme.textColor,
        ),
        columnSpacing: 20,
        horizontalMargin: 12,
        dataRowHeight: rowHeight,
        columns: const [
          DataColumn(label: Text('Sl.No.')),
          DataColumn(label: Text('Customer')),
          DataColumn(label: Text('Enquiry ID')),
          DataColumn(label: Text('Product')),
          DataColumn(label: Text('Plan')),
          DataColumn(label: Text('Demo')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Actions')),
        ],
        rows: rows,
      ),
    );
  }
}

void _showImportDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black54,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Import New', style: GoogleFonts.poppins()),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 300,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.shade300, style: BorderStyle.solid),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cloud_upload,
                        size: 40,
                        color: AppTheme.primaryColor,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Drag & Drop or choose a file to upload',
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Max Size: 150 MiB',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.file_download, color: Colors.white),
              label: Text(
                'Import',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int rowsPerPage;
  final int totalRows;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.rowsPerPage,
    required this.totalRows,
    required this.onNext,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    final totalPages = (totalRows / rowsPerPage).ceil();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: currentPage > 0 ? onPrev : null,
          icon: Icon(
            Icons.arrow_back,
            color: currentPage > 0 ? AppTheme.primaryColor : Colors.grey,
          ),
          label: Text(
            "Previous",
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: currentPage > 0 ? AppTheme.primaryColor : Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 8),
        ...List.generate(totalPages, (index) {
          final bool isSelected = index == currentPage;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: InkWell(
              onTap: () {
                if (index != currentPage) {
                  // Optional: Add a callback here if needed
                }
              },
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color:
                      isSelected ? AppTheme.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "${index + 1}",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
        const SizedBox(width: 8),
        TextButton.icon(
          onPressed: (currentPage + 1) < totalPages ? onNext : null,
          label: Text(
            "Next",
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: (currentPage + 1) < totalPages
                  ? AppTheme.primaryColor
                  : Colors.grey,
            ),
          ),
          icon: Icon(
            Icons.arrow_forward,
            color: (currentPage + 1) < totalPages
                ? AppTheme.primaryColor
                : Colors.grey,
          ),
        ),
      ],
    );
  }
}
