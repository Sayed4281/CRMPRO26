import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';
import 'main_layout.dart';
import 'home_screen.dart';
import 'add_edit_visit_dialog.dart'; // Ensure this file exists and is correctly implemented
import 'view_visit_dialog.dart'; // Import the new ViewVisitDialog file

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({super.key});

  @override
  _VisitsScreenState createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> {
  String selectedVisitType = 'All';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  int currentPage = 1;
  final int visitsPerPage = 3;
  List<Map<String, String>> visits = [
    {
      'index': '01',
      'name': 'Dr. Patel',
      'visitId': 'VIS-2041',
      'type': 'New',
      'person1': 'John Doe',
      'person2': 'Jane Smith',
      'contactNumber': '1234567890',
      'designation': 'Manager',
      'requirements': 'Need a demo setup'
    },
    {'index': '02', 'name': 'Dr. Sharma', 'visitId': 'VIS-2042', 'type': 'Demo', 'lead': 'Alice Brown', 'demoGivenTo': 'Tech Team'},
    {'index': '03', 'name': 'Dr. Patel', 'visitId': 'VIS-2043', 'type': 'Installation'},
    {'index': '04', 'name': 'Dr. Gupta', 'visitId': 'VIS-2044', 'type': 'Demo'},
    {'index': '05', 'name': 'Dr. Patel', 'visitId': 'VIS-2045', 'type': 'New'},
    {'index': '06', 'name': 'Dr. Singh', 'visitId': 'VIS-2046', 'type': 'Follow-up'},
    {'index': '07', 'name': 'Dr. Patel', 'visitId': 'VIS-2047', 'type': 'Service'},
    {'index': '08', 'name': 'Dr. Kumar', 'visitId': 'VIS-2048', 'type': 'Payment'},
    {'index': '09', 'name': 'Dr. Patel', 'visitId': 'VIS-2049', 'type': 'Service'},
    {'index': '10', 'name': 'Dr. Reddy', 'visitId': 'VIS-2050', 'type': 'Training'},
  ];

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

  void _showImportDialog() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Max Size: 150 MiB',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                          ),
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

  void _showAddEditVisitDialog({Map<String, String>? visit, int? index}) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return AddEditVisitDialog(
          visit: visit,
          index: index,
          customerNames: visits.map((visit) => visit['name']!).toSet().toList(),
          visits: visits,
          onSave: (newVisit, visitIndex) {
            setState(() {
              if (visitIndex == null) {
                visits.add(newVisit);
              } else {
                visits[visitIndex] = newVisit;
              }
            });
          },
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                'Are you sure you want to delete this visit? This action cannot be undone.',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.black87,
                ),
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
                  _deleteVisit(index);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Visit deleted successfully',
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

  void _showViewVisitDialog(Map<String, String> visit) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return ViewVisitDialog(visit: visit);
      },
    );
  }

  void _deleteVisit(int index) {
    setState(() {
      visits.removeAt(index);
      for (int i = 0; i < visits.length; i++) {
        visits[i]['index'] = (i + 1).toString().padLeft(2, '0');
      }
      int totalPages = (visits.length / visitsPerPage).ceil();
      if (currentPage > totalPages && totalPages > 0) {
        currentPage = totalPages;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return MainLayout(
      currentPage: VisitsScreen,
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
                        ' > Visits',
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
                          _buildSummaryCard('Total', '28 Visits', Icons.event, isDarkMode),
                          const SizedBox(width: 8),
                          _buildSummaryCard('Completed', '19', Icons.check_circle, isDarkMode),
                          const SizedBox(width: 8),
                          _buildSummaryCard('Pending', '6', Icons.hourglass_empty, isDarkMode),
                          const SizedBox(width: 8),
                          _buildSummaryCard('Service', '3', Icons.build, isDarkMode),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Visits List',
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
                        width: constraints.maxWidth * 0.6, // Responsive search bar width
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
                        onPressed: _showImportDialog,
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showAddEditVisitDialog();
                        },
                        icon: Icon(
                          Icons.add,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                        ),
                        label: Text(
                          'Add Visit',
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
                      _buildFilterButton('New', isDarkMode),
                      _buildFilterButton('Follow-up', isDarkMode),
                      _buildFilterButton('Demo', isDarkMode),
                      _buildFilterButton('Installation', isDarkMode),
                      _buildFilterButton('Service', isDarkMode),
                      _buildFilterButton('Payment', isDarkMode),
                      _buildFilterButton('Training', isDarkMode),
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
                            0: const FixedColumnWidth(88), // Sl No
                            1: const FixedColumnWidth(150), // Name (230 + 16 + 80)
                            2: const FixedColumnWidth(272), // Visit ID (230 + 16 + 230 + 16 + 80)
                            3: const FixedColumnWidth(238), // Visit Type (230 + 16 + 230 + 16 + 230 + 16 + 80)
                            4: const FixedColumnWidth(230),// Actions
                          },
                          children: [
                            TableRow(
                              children: [
                                _buildTableHeader('Sl No', TextAlign.center, isDarkMode),
                                _buildTableHeader('Name', TextAlign.left, isDarkMode),
                                _buildTableHeader('Visit ID', TextAlign.center, isDarkMode),
                                _buildTableHeader('Visit Type', TextAlign.center, isDarkMode),
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
                        onPressed: currentPage < (visits.length / visitsPerPage).ceil()
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
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
              ),
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
                ? selectedVisitType == label
                ? DarkTheme.textColor
                : DarkTheme.textColor.withOpacity(0.7)
                : selectedVisitType == label
                ? AppTheme.textColor
                : AppTheme.secondaryTextColor,
          ),
        ),
      ),
      selected: selectedVisitType == label,
      selectedColor: isDarkMode ? DarkTheme.primaryColor.withOpacity(0.2) : Colors.transparent,
      backgroundColor: Colors.transparent,
      side: BorderSide(
        color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : Colors.transparent,
      ),
      labelStyle: GoogleFonts.poppins(
        color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
        fontWeight: selectedVisitType == label ? FontWeight.w600 : FontWeight.normal,
      ),
      onSelected: (selected) {
        setState(() {
          selectedVisitType = label;
          currentPage = 1;
        });
      },
    );
  }

  Widget _buildTableHeader(String title, TextAlign alignment, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
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
    List<Map<String, String>> filteredVisits = selectedVisitType == 'All'
        ? visits
        : visits.where((visit) => visit['type'] == selectedVisitType).toList();

    if (searchQuery.isNotEmpty) {
      filteredVisits = filteredVisits.where((visit) {
        final name = visit['name']!.toLowerCase();
        final visitId = visit['visitId']!.toLowerCase();
        return name.contains(searchQuery) || visitId.contains(searchQuery);
      }).toList();
    }

    final startIndex = (currentPage - 1) * visitsPerPage;
    final endIndex = startIndex + visitsPerPage;
    final paginatedVisits = filteredVisits
        .asMap()
        .entries
        .where((entry) => entry.key >= startIndex && entry.key < endIndex)
        .toList();

    return paginatedVisits.map((entry) {
      int index = entry.key;
      Map<String, String> visit = entry.value;
      return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              visit['index']!,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              visit['name']!,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              visit['visitId']!,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              visit['type']!,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
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
                if (value == 'edit') {
                  _showAddEditVisitDialog(visit: visit, index: index);
                } else if (value == 'delete') {
                  _showDeleteConfirmationDialog(index);
                } else if (value == 'view') {
                  _showViewVisitDialog(visit);
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
    final totalPages = (visits.length / visitsPerPage).ceil();
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