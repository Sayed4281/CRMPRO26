import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                      border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.cloud_upload,
                          size: 40,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Drag & Drop or choose a file to upload',
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Max Size: 150 MiB',
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
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
                  backgroundColor: const Color(0xFF6C5DD3),
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
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
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
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            content: SizedBox(
              width: 300,
              child: Text(
                'Are you sure you want to delete this visit? This action cannot be undone.',
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFE6E6FA),
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
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Text(
                  'Delete',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5DD3),
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
    return MainLayout(
      currentPage: VisitsScreen,
      content: Container(
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                        color: const Color.fromARGB(255, 1, 7, 12),
                      ),
                    ),
                  ),
                  Text(
                    ' > Visits',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 1, 7, 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 32),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildSummaryCard('Total', '28 Visits', Icons.event),
                      const SizedBox(width: 8),
                      _buildSummaryCard('Completed', '19', Icons.check_circle),
                      const SizedBox(width: 8),
                      _buildSummaryCard('Pending', '6', Icons.hourglass_empty),
                      const SizedBox(width: 8),
                      _buildSummaryCard('Service', '3', Icons.build),
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
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: 800,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by name, ID',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Color(0xFF6C5DD3)),
                        ),
                        suffixIcon: const Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.file_download, color: Color(0xFF8C1AFC)),
                    onPressed: _showImportDialog,
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showAddEditVisitDialog();
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: Text(
                      'Add Visit',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C5DD3),
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
                  _buildFilterButton('All'),
                  _buildFilterButton('New'),
                  _buildFilterButton('Follow-up'),
                  _buildFilterButton('Demo'),
                  _buildFilterButton('Installation'),
                  _buildFilterButton('Service'),
                  _buildFilterButton('Payment'),
                  _buildFilterButton('Training'),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    border: const TableBorder(
                      horizontalInside: BorderSide(color: Color(0xFFE8E8E8)),
                    ),
                    defaultColumnWidth: const FixedColumnWidth(240),
                    children: [
                      TableRow(
                        children: [
                          _buildTableHeader('Sl No', TextAlign.center),
                          _buildTableHeader('Name', TextAlign.left),
                          _buildTableHeader('Visit ID', TextAlign.center),
                          _buildTableHeader('Visit Type', TextAlign.center),
                          _buildTableHeader('', TextAlign.center),
                        ],
                      ),
                      ..._buildFilteredTableRows(),
                    ],
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
                        const Icon(Icons.arrow_left, color: Colors.black),
                        Text(
                          'Previous',
                          style: GoogleFonts.poppins(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ..._buildPageNumbers(),
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
                          style: GoogleFonts.poppins(color: Colors.black),
                        ),
                        const Icon(Icons.arrow_right, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      color: const Color(0xFFF7F6FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 140,
        height: 108,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF8C1AFC), size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    return ChoiceChip(
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(label, style: GoogleFonts.poppins()),
      ),
      selected: selectedVisitType == label,
      selectedColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      side: const BorderSide(color: Colors.transparent),
      labelStyle: GoogleFonts.poppins(
        color: Colors.black,
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

  Widget _buildTableHeader(String title, TextAlign alignment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black87,
        ),
        textAlign: alignment,
      ),
    );
  }

  List<TableRow> _buildFilteredTableRows() {
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
              style: GoogleFonts.poppins(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              visit['name']!,
              style: GoogleFonts.poppins(fontSize: 14),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              visit['visitId']!,
              style: GoogleFonts.poppins(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              visit['type']!,
              style: GoogleFonts.poppins(fontSize: 14),
              textAlign: TextAlign.center,
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
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              color: Colors.transparent,
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
                      const Icon(Icons.visibility, color: Colors.black, size: 20),
                      const SizedBox(width: 8),
                      Text('View', style: GoogleFonts.poppins(fontSize: 14)),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    children: [
                      const Icon(Icons.edit, color: Colors.black, size: 20),
                      const SizedBox(width: 8),
                      Text('Edit', style: GoogleFonts.poppins(fontSize: 14)),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(Icons.delete, color: Colors.red, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Delete',
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.red),
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

  List<Widget> _buildPageNumbers() {
    final totalPages = (visits.length / visitsPerPage).ceil();
    List<Widget> pageNumbers = [];
    for (int i = 1; i <= totalPages && i <= 3; i++) {
      pageNumbers.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: _buildPageNumber(i),
        ),
      );
    }
    return pageNumbers;
  }

  Widget _buildPageNumber(int number) {
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
          color: const Color(0xFF6C5DD3),
          borderRadius: BorderRadius.circular(4),
        )
            : null,
        child: Text(
          number.toString(),
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
