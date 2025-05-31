import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';
import 'main_layout.dart';
import 'home_screen.dart';
import 'add_enquiry_dialog.dart';
import 'enquiry_details_popup.dart';
import 'validate_checklist_dialog.dart';
import 'edit_enquiry_popup.dart';

class EnquiryScreen extends StatefulWidget {
  const EnquiryScreen({super.key});

  // Static list to share enquiries across screens
  static List<Map<String, dynamic>> enquiries = List.generate(30, (index) {
    return {
      'index': (index + 1).toString().padLeft(2, '0'),
      'customer': 'Dr. Patel',
      'enquiryId': 'ENQ-204${index % 10}',
      'product': 'CT Scanner',
      'plan': 'Immediate',
      'demo': 'Yes',
      'status': index % 2 == 0 ? 'Validated' : 'Open',
      'quantity': '100',
      'date': '01/01/2025',
      'notes': 'Sample notes',
    };
  });

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  String selectedStatus = 'All';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  int currentPage = 1;
  final int enquiriesPerPage = 6;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showImportDialog(bool isDarkMode) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            backgroundColor: isDarkMode ? DarkTheme.whiteColor : AppTheme.whiteColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Import New',
                  style: GoogleFonts.poppins(
                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                  ),
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
                      color: isDarkMode ? DarkTheme.backgroundColor : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : Colors.grey.shade300,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload,
                          size: 40,
                          color: isDarkMode ? DarkTheme.accentColor : Colors.blue,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Drag & Drop or choose a file to upload',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Max Size: 150 MiB',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                          ),
                          textAlign: TextAlign.center,
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
                  style: GoogleFonts.poppins(
                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.file_download, color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor),
                label: Text(
                  'Import',
                  style: GoogleFonts.poppins(
                    color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6C5DD3),
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

  void _showAddEditEnquiryDialog({Map<String, dynamic>? enquiry, int? index}) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return enquiry == null
            ? const AddEnquiryDialog()
            : EditEnquiryDialog(enquiry: enquiry);
      },
    ).then((result) {
      if (result != null && result is Map<String, dynamic>) {
        setState(() {
          if (index == null) {
            EnquiryScreen.enquiries.add({
              'index': (EnquiryScreen.enquiries.length + 1).toString().padLeft(2, '0'),
              'customer': result['customer']?.toString() ?? 'Unknown',
              'enquiryId': 'ENQ-204${EnquiryScreen.enquiries.length % 10}',
              'product': result['product']?.toString() ?? 'Unknown',
              'plan': result['plan']?.toString() ?? 'Unknown',
              'demo': result['demo']?.toString() ?? 'No',
              'status': result['status']?.toString() ?? 'Open',
              'quantity': result['quantity']?.toString() ?? '0',
              'date': result['date']?.toString() ?? 'Unknown',
              'notes': result['notes']?.toString() ?? 'No notes',
            });
          } else {
            EnquiryScreen.enquiries[index] = {
              'index': enquiry!['index'],
              'customer': result['customer']?.toString() ?? 'Unknown',
              'enquiryId': enquiry['enquiryId'],
              'product': result['product']?.toString() ?? 'Unknown',
              'plan': result['plan']?.toString() ?? 'Unknown',
              'demo': result['demo']?.toString() ?? 'No',
              'status': result['status']?.toString() ?? 'Open',
              'quantity': result['quantity']?.toString() ?? '0',
              'date': result['date']?.toString() ?? 'Unknown',
              'notes': result['notes']?.toString() ?? 'No notes',
            };
          }
        });
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              index == null ? 'Enquiry added successfully' : 'Enquiry updated successfully',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
              ),
            ),
            backgroundColor: isDarkMode ? DarkTheme.accentColor : Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void _showDeleteConfirmationDialog(int index, bool isDarkMode) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            backgroundColor: isDarkMode ? DarkTheme.whiteColor : AppTheme.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.all(16.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Confirm Delete',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 18,
                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            content: SizedBox(
              width: 300,
              child: Text(
                'Are you sure you want to delete this enquiry? This action cannot be undone.',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: isDarkMode ? DarkTheme.backgroundColor : const Color(0xFFE6E6FA),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _deleteEnquiry(index);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Enquiry deleted successfully',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                        ),
                      ),
                      backgroundColor: isDarkMode ? DarkTheme.accentColor : Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Text(
                  'Delete',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6C5DD3),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showViewEnquiryDialog(Map<String, dynamic> enquiry) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return EnquiryDetailsPopup(enquiry: enquiry);
      },
    ).then((result) {
      if (result != null) {
        _deleteEnquiry(EnquiryScreen.enquiries.indexWhere((e) => e['index'] == result));
      }
    });
  }

  void _validateEnquiry(Map<String, dynamic> enquiry, int index) async {
    final result = await ValidateChecklistDialog.show(context);
    if (result != null) {
      setState(() {
        EnquiryScreen.enquiries[index]['status'] = 'Validated';
        EnquiryScreen.enquiries[index]['checklist'] = result;
      });
      final isDarkMode = Theme.of(context).brightness == Brightness.dark;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Checklist validated successfully',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
            ),
          ),
          backgroundColor: isDarkMode ? DarkTheme.accentColor : Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _deleteEnquiry(int index) {
    setState(() {
      EnquiryScreen.enquiries.removeAt(index);
      for (int i = 0; i < EnquiryScreen.enquiries.length; i++) {
        EnquiryScreen.enquiries[i]['index'] = (i + 1).toString().padLeft(2, '0');
      }
      int totalPages = (EnquiryScreen.enquiries.length / enquiriesPerPage).ceil();
      if (currentPage > totalPages && totalPages > 0) {
        currentPage = totalPages;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return MainLayout(
      currentPage: EnquiryScreen,
      content: Container(
        color: isDarkMode ? DarkTheme.backgroundColor : const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                          );
                        },
                        child: Text(
                          'Dashboard',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isDarkMode ? DarkTheme.textColor : const Color.fromARGB(255, 1, 7, 12),
                          ),
                        ),
                      ),
                      Text(
                        ' > Enquiries',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : const Color.fromARGB(255, 1, 7, 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildSummaryCard('Total', '${EnquiryScreen.enquiries.length} Enquiries', Icons.insert_drive_file, isDarkMode),
                          const SizedBox(width: 8),
                          _buildSummaryCard('New This Month', '11', Icons.new_releases, isDarkMode),
                          const SizedBox(width: 8),
                          _buildSummaryCard('Total Open', '${EnquiryScreen.enquiries.where((e) => e['status'] == 'Open').length}', Icons.pending_actions, isDarkMode),
                          const SizedBox(width: 8),
                          _buildSummaryCard('Total Validated', '${EnquiryScreen.enquiries.where((e) => e['status'] == 'Validated').length}', Icons.verified, isDarkMode),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Enquiries List',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: constraints.maxWidth * 0.6,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search by name, ID',
                            hintStyle: GoogleFonts.poppins(
                              color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xFFD9D9D9),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xFFD9D9D9),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF6C5DD3),
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.search,
                              color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                            ),
                          ),
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.file_download,
                          color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF8C1AFC),
                        ),
                        onPressed: () => _showImportDialog(isDarkMode),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showAddEditEnquiryDialog();
                        },
                        icon: Icon(
                          Icons.add,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                        ),
                        label: Text(
                          'Add Enquiry',
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6C5DD3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      _buildFilterButton('All', isDarkMode),
                      _buildFilterButton('Open', isDarkMode),
                      _buildFilterButton('Validated', isDarkMode),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: constraints.maxWidth),
                        child: Table(
                          border: TableBorder(
                            horizontalInside: BorderSide(
                              color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xFFE8E8E8),
                            ),
                          ),
                          columnWidths: {
                            0: const FixedColumnWidth(60),
                            1: const FixedColumnWidth(120),
                            2: const FixedColumnWidth(200),
                            3: const FixedColumnWidth(180),
                            4: const FixedColumnWidth(180),
                            5: const FixedColumnWidth(180),
                            6: const FixedColumnWidth(180),
                            7: const FixedColumnWidth(200),
                          },
                          children: [
                            TableRow(
                              children: [
                                _buildTableHeader('Sl No', TextAlign.center, isDarkMode),
                                _buildTableHeader('Customer', TextAlign.left, isDarkMode),
                                _buildTableHeader('Enquiry ID', TextAlign.center, isDarkMode),
                                _buildTableHeader('Product', TextAlign.center, isDarkMode),
                                _buildTableHeader('Plan', TextAlign.center, isDarkMode),
                                _buildTableHeader('Demo', TextAlign.center, isDarkMode),
                                _buildTableHeader('Status', TextAlign.center, isDarkMode),
                                _buildTableHeader('', TextAlign.center, isDarkMode),
                              ],
                            ),
                            ..._buildFilteredTableRows(isDarkMode),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: currentPage > 1
                            ? () {
                          setState(() {
                            currentPage--;
                          });
                        }
                            : null,
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_left,
                              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                            ),
                            Text(
                              'Previous',
                              style: GoogleFonts.poppins(
                                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ..._buildPageNumbers(isDarkMode),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: currentPage < (EnquiryScreen.enquiries.length / enquiriesPerPage).ceil()
                            ? () {
                          setState(() {
                            currentPage++;
                          });
                        }
                            : null,
                        child: Row(
                          children: [
                            Text(
                              'Next',
                              style: GoogleFonts.poppins(
                                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                              ),
                            ),
                            Icon(
                              Icons.arrow_right,
                              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, bool isDarkMode) {
    return Card(
      elevation: 2,
      color: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFF7F6FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 140,
        height: 108,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF8C1AFC),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label, bool isDarkMode) {
    return ChoiceChip(
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: isDarkMode
                ? selectedStatus == label
                ? DarkTheme.textColor
                : DarkTheme.textColor.withOpacity(0.7)
                : selectedStatus == label
                ? AppTheme.textColor
                : AppTheme.secondaryTextColor,
          ),
        ),
      ),
      selected: selectedStatus == label,
      selectedColor: isDarkMode ? DarkTheme.primaryColor.withOpacity(0.2) : Colors.transparent,
      backgroundColor: Colors.transparent,
      side: BorderSide(
        color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : Colors.transparent,
      ),
      labelStyle: GoogleFonts.poppins(
        color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
        fontWeight: selectedStatus == label ? FontWeight.w600 : FontWeight.normal,
      ),
      onSelected: (selected) {
        setState(() {
          selectedStatus = label;
          currentPage = 1;
        });
      },
    );
  }

  Widget _buildTableHeader(String title, TextAlign alignment, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
        ),
        textAlign: alignment,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  List<TableRow> _buildFilteredTableRows(bool isDarkMode) {
    List<Map<String, dynamic>> filteredEnquiries = selectedStatus == 'All'
        ? EnquiryScreen.enquiries
        : EnquiryScreen.enquiries.where((enquiry) => enquiry['status'] == selectedStatus).toList();

    if (searchQuery.isNotEmpty) {
      filteredEnquiries = filteredEnquiries.where((enquiry) {
        final customer = enquiry['customer']?.toString().toLowerCase() ?? '';
        final enquiryId = enquiry['enquiryId']?.toString().toLowerCase() ?? '';
        return customer.contains(searchQuery) || enquiryId.contains(searchQuery);
      }).toList();
    }

    final startIndex = (currentPage - 1) * enquiriesPerPage;
    final endIndex = startIndex + enquiriesPerPage;
    final paginatedEnquiries = filteredEnquiries
        .asMap()
        .entries
        .where((entry) => entry.key >= startIndex && entry.key < endIndex)
        .toList();

    return paginatedEnquiries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> enquiry = entry.value;
      return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
            child: Text(
              enquiry['index']?.toString() ?? '',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
            child: Text(
              enquiry['customer']?.toString() ?? '',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
            child: Text(
              enquiry['enquiryId']?.toString() ?? '',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
            child: Text(
              enquiry['product']?.toString() ?? '',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
            child: Text(
              enquiry['plan']?.toString() ?? '',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
            child: Text(
              enquiry['demo']?.toString() ?? '',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
            child: Text(
              enquiry['status']?.toString() ?? '',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: enquiry['status'] == 'Validated'
                    ? Colors.green
                    : enquiry['status'] == 'Open'
                    ? Colors.orange
                    : Colors.red,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
            child: PopupMenuButton<String>(
              tooltip: '',
              icon: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Icon(
                  Icons.more_vert,
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                  size: 20,
                ),
              ),
              color: isDarkMode ? DarkTheme.whiteColor : AppTheme.whiteColor,
              elevation: 0,
              onSelected: (String value) {
                if (value == 'view') {
                  _showViewEnquiryDialog(enquiry);
                } else if (value == 'validate') {
                  _validateEnquiry(enquiry, index);
                } else if (value == 'edit') {
                  _showAddEditEnquiryDialog(enquiry: enquiry, index: index);
                } else if (value == 'delete') {
                  _showDeleteConfirmationDialog(index, isDarkMode);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'view',
                  child: Row(
                    children: [
                      Icon(
                        Icons.visibility,
                        color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'View',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'validate',
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Validate',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Edit',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: isDarkMode ? DarkTheme.errorColor : Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Delete',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.errorColor : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }

  List<Widget> _buildPageNumbers(bool isDarkMode) {
    final totalPages = (EnquiryScreen.enquiries.length / enquiriesPerPage).ceil();
    List<Widget> pageNumbers = [];
    for (int i = 1; i <= totalPages && i <= 3; i++) {
      pageNumbers.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: _buildPageNumber(i, isDarkMode),
        ),
      );
    }
    return pageNumbers;
  }

  Widget _buildPageNumber(int number, bool isDarkMode) {
    bool isSelected = currentPage == number;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentPage = number;
        });
      },
      child: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: isSelected
            ? BoxDecoration(
          color: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6C5DD3),
          borderRadius: BorderRadius.circular(4),
        )
            : null,
        child: Text(
          number.toString(),
          style: GoogleFonts.poppins(
            color: isSelected
                ? (isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor)
                : (isDarkMode ? DarkTheme.textColor : AppTheme.textColor),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}