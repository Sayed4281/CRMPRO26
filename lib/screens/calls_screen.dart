import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';
import 'main_layout.dart';
import 'home_screen.dart';
import 'add_call_dialog.dart';
import 'edit_call_dialog.dart';
import 'view_call_dialog.dart'; // Added import for ViewCallDialog

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  _CallsScreenState createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  String selectedCallStatus = 'All';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  int currentPage = 1;
  final int callsPerPage = 3;
  List<Map<String, String>> calls = [
    {
      'index': '01',
      'name': 'Dr. Rana',
      'callId': 'CALL-2001',
      'location': 'Mumbai',
      'company': 'pro26@abc',
      'phoneNumber': '+91 98951 45673',
      'callDuration': '02:00',
      'email': 'dr.rana@example.com',
    },
    {
      'index': '02',
      'name': 'Dr. Rana',
      'callId': 'CALL-2002',
      'location': 'Mumbai',
      'company': 'pro26@abc',
      'phoneNumber': '+91 98951 45673',
      'callDuration': '02:00',
      'email': 'dr.rana2@example.com',
    },
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

  void _showAddCallDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return AddCallDialog(
          onSave: (newCall) {
            setState(() {
              calls.add({
                'index': (calls.length + 1).toString().padLeft(2, '0'),
                'callId': 'CALL-${2000 + calls.length + 1}',
                ...newCall,
              });
            });
          },
        );
      },
    );
  }

  void _showEditCallDialog(Map<String, String> call, int index) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return EditCallDialog(
          call: call,
          index: index,
          onSave: (updatedCall, index) {
            setState(() {
              calls[index] = {
                'index': calls[index]['index']!,
                'callId': calls[index]['callId']!,
                ...updatedCall,
              };
            });
          },
        );
      },
    );
  }

  void _showViewCallDialog(Map<String, String> call) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return ViewCallDialog(call: call);
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
                'Are you sure you want to delete this call? This action cannot be undone and will remove all associated leads, enquiries, and interaction logs.',
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
                  _deleteCall(index);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Call deleted successfully',
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

  void _deleteCall(int index) {
    setState(() {
      calls.removeAt(index);
      for (int i = 0; i < calls.length; i++) {
        calls[i]['index'] = (i + 1).toString().padLeft(2, '0');
      }
      int totalPages = (calls.length / callsPerPage).ceil();
      if (currentPage > totalPages && totalPages > 0) {
        currentPage = totalPages;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return MainLayout(
      currentPage: CallsScreen,
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
                        ' > Calls',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : const Color.fromARGB(255, 1, 7, 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Calls Summary',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildSummaryCard('Total', '1,245 Calls', Icons.call, isDarkMode),
                          const SizedBox(width: 8),
                          _buildSummaryCard('New This Month', '11', Icons.fiber_new, isDarkMode),
                          const SizedBox(width: 8),
                          _buildSummaryCard('Top Rated', 'Dr. Rana', Icons.star, isDarkMode),
                          const SizedBox(width: 8),
                          _buildSummaryCard('Active Calls', '526', Icons.call_end, isDarkMode),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Calls List',
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
                        onPressed: _showImportDialog,
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: _showAddCallDialog,
                        icon: Icon(
                          Icons.add,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                        ),
                        label: Text(
                          'Add Call',
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
                      _buildFilterButton('Active', isDarkMode),
                      _buildFilterButton('Inactive', isDarkMode),
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
                            1: const FixedColumnWidth(150), // Name
                            2: const FixedColumnWidth(150), // Call ID
                            3: const FixedColumnWidth(150), // Company
                            4: const FixedColumnWidth(150), // Phone Number
                            5: const FixedColumnWidth(80), // Actions
                          },
                          children: [
                            TableRow(
                              children: [
                                _buildTableHeader('Sl No', TextAlign.center, isDarkMode),
                                _buildTableHeader('Name', TextAlign.left, isDarkMode),
                                _buildTableHeader('Call ID', TextAlign.center, isDarkMode),
                                _buildTableHeader('Company', TextAlign.center, isDarkMode),
                                _buildTableHeader('Phone Number', TextAlign.center, isDarkMode),
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
                        onPressed: currentPage < (calls.length / callsPerPage).ceil()
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
                ? selectedCallStatus == label
                ? DarkTheme.textColor
                : DarkTheme.textColor.withOpacity(0.7)
                : selectedCallStatus == label
                ? AppTheme.textColor
                : AppTheme.secondaryTextColor,
          ),
        ),
      ),
      selected: selectedCallStatus == label,
      selectedColor: isDarkMode ? DarkTheme.primaryColor.withOpacity(0.2) : Colors.transparent,
      backgroundColor: Colors.transparent,
      side: BorderSide(
        color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : Colors.transparent,
      ),
      labelStyle: GoogleFonts.poppins(
        color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
        fontWeight: selectedCallStatus == label ? FontWeight.w600 : FontWeight.normal,
      ),
      onSelected: (selected) {
        setState(() {
          selectedCallStatus = label;
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
    List<Map<String, String>> filteredCalls = selectedCallStatus == 'All'
        ? calls
        : calls.where((call) => call['status'] == selectedCallStatus).toList();

    if (searchQuery.isNotEmpty) {
      filteredCalls = filteredCalls.where((call) {
        final name = call['name']!.toLowerCase();
        final callId = call['callId']!.toLowerCase();
        return name.contains(searchQuery) || callId.contains(searchQuery);
      }).toList();
    }

    final startIndex = (currentPage - 1) * callsPerPage;
    final endIndex = startIndex + callsPerPage;
    final paginatedCalls = filteredCalls
        .asMap()
        .entries
        .where((entry) => entry.key >= startIndex && entry.key < endIndex)
        .toList();

    return paginatedCalls.map((entry) {
      int index = entry.key;
      Map<String, String> call = entry.value;
      return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              call['index']!,
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
              call['name']!,
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
              call['callId']!,
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
              call['company']!,
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
              call['phoneNumber']!,
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
                if (value == 'view') {
                  _showViewCallDialog(call);
                } else if (value == 'edit') {
                  _showEditCallDialog(call, index);
                } else if (value == 'delete') {
                  _showDeleteConfirmationDialog(index);
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
    final totalPages = (calls.length / callsPerPage).ceil();
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