import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_layout.dart';
import 'home_screen.dart';
import 'edit_Lead_Dialog.dart';
import 'View_Lead_Dialog.dart';

class BadLeadsScreen extends StatefulWidget {
  const BadLeadsScreen({super.key});

  @override
  _BadLeadsScreenState createState() => _BadLeadsScreenState();
}

class _BadLeadsScreenState extends State<BadLeadsScreen> {
  String selectedLeadStatus = 'All';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  int currentPage = 1;
  final int leadsPerPage = 3;
  List<Map<String, String>> leads = [
    // [Previous leads data remains unchanged]
    {
      'index': '01',
      'name': 'Dr. Patel',
      'leadId': 'LID-2041',
      'product': 'CT Scanner',
      'leadStatus': 'Bad Lead',
      'status': 'Demo Completed',
      'closingDate': '2024-07-21',
      'quantity': '3',
      'priority': 'High',
      'demoSuccess': 'Won The Order',
      'activities': 'In-person Conference on 2024-05-01 (Virtual)',
    },
    {
      'index': '02',
      'name': 'Dr. Sharma',
      'leadId': 'LID-2042',
      'product': 'MRI Machine',
      'leadStatus': 'Bad Lead',
      'status': 'Quotation Submitted',
      'closingDate': '2024-08-15',
      'quantity': '',
      'priority': '',
      'demoSuccess': '',
      'activities': '',
    },
    {
      'index': '03',
      'name': 'Dr. Gupta',
      'leadId': 'LID-2043',
      'product': 'X-Ray Machine',
      'leadStatus': 'Bad Lead',
      'status': 'Waiting for Demo',
      'closingDate': '2024-09-10',
      'quantity': '',
      'priority': '',
      'demoSuccess': '',
      'activities': '',
    },
    {
      'index': '04',
      'name': 'Dr. Singh',
      'leadId': 'LID-2044',
      'product': 'Ultrasound',
      'leadStatus': 'Bad Lead',
      'status': 'Demo Scheduled',
      'closingDate': '2024-10-05',
      'quantity': '',
      'priority': '',
      'demoSuccess': '',
      'activities': '',
    },
    {
      'index': '05',
      'name': 'Dr. Kumar',
      'leadId': 'LID-2045',
      'product': 'CT Scanner',
      'leadStatus': 'Bad Lead',
      'status': 'Demo Completed',
      'closingDate': '2024-11-01',
      'quantity': '',
      'priority': '',
      'demoSuccess': '',
      'activities': '',
    },
    {
      'index': '06',
      'name': 'Dr. Reddy',
      'leadId': 'LID-2046',
      'product': 'MRI Machine',
      'leadStatus': 'Bad Lead',
      'status': 'Demo Scheduled',
      'closingDate': '2024-12-15',
      'quantity': '',
      'priority': '',
      'demoSuccess': '',
      'activities': '',
    },
    {
      'index': '07',
      'name': 'Dr. Patel',
      'leadId': 'LID-2047',
      'product': 'X-Ray Machine',
      'leadStatus': 'Bad Lead',
      'status': 'Demo Completed',
      'closingDate': '2025-01-20',
      'quantity': '',
      'priority': '',
      'demoSuccess': '',
      'activities': '',
    },
    {
      'index': '08',
      'name': 'Dr. Sharma',
      'leadId': 'LID-2048',
      'product': 'Ultrasound',
      'leadStatus': 'Bad Lead',
      'status': 'Demo Scheduled',
      'closingDate': '2025-02-10',
      'quantity': '',
      'priority': '',
      'demoSuccess': '',
      'activities': '',
    },
    {
      'index': '09',
      'name': 'Dr. Gupta',
      'leadId': 'LID-2049',
      'product': 'CT Scanner',
      'leadStatus': 'Bad Lead',
      'status': 'Demo Scheduled',
      'closingDate': '2025-03-05',
      'quantity': '',
      'priority': '',
      'demoSuccess': '',
      'activities': '',
    },
    {
      'index': '10',
      'name': 'Dr. Singh',
      'leadId': 'LID-2050',
      'product': 'MRI Machine',
      'leadStatus': 'Bad Lead',
      'status': 'Demo Scheduled',
      'closingDate': '2025-04-01',
      'quantity': '',
      'priority': '',
      'demoSuccess': '',
      'activities': '',
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

  void _showEditLeadDialog({required Map<String, String> lead, required int index}) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return EditLeadDialog(
          lead: lead,
          index: index,
          customerNames: leads.map((lead) => lead['name']!).toSet().toList(),
          leads: leads,
          onSave: (updatedLead, leadIndex) {
            setState(() {
              leads[leadIndex!] = updatedLead;
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
                'Are you sure you want to delete this lead? This action cannot be undone.',
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
                  _deleteLead(index);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Lead deleted successfully',
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

  void _showViewLeadDialog(Map<String, String> lead) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return ViewLeadDialog(
          lead: lead,
          onEdit: () {
            Navigator.pop(context); // Close ViewLeadDialog
            _showEditLeadDialog(lead: lead, index: int.parse(lead['index']!) - 1);
          },
        );
      },
    );
  }

  void _deleteLead(int index) {
    setState(() {
      leads.removeAt(index);
      for (int i = 0; i < leads.length; i++) {
        leads[i]['index'] = (i + 1).toString().padLeft(2, '0');
      }
      int totalPages = (leads.length / leadsPerPage).ceil();
      if (currentPage > totalPages && totalPages > 0) {
        currentPage = totalPages;
      } else if (leads.isEmpty) {
        currentPage = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentPage: BadLeadsScreen,
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
                    ' > Leads',
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
                      _buildSummaryCard('Total', '19 Leads', Icons.people),
                      const SizedBox(width: 8),
                      _buildSummaryCard('Won', '7', Icons.check_circle),
                      const SizedBox(width: 8),
                      _buildSummaryCard('Lost', '3', Icons.cancel),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Leads List',
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
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  _buildFilterButton('All'),
                  _buildFilterButton('Discussion'),
                  _buildFilterButton('Quotation Submitted'),
                  _buildFilterButton('Waiting for Demo'),
                  _buildFilterButton('Demo Scheduled'),
                  _buildFilterButton('Demo Completed'),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: leads.isEmpty
                      ? const Center(
                    child: Text(
                      'No leads available.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                      : Table(
                    border: const TableBorder(
                      horizontalInside: BorderSide(color: Color(0xFFE8E8E8)),
                    ),
                    defaultColumnWidth: const FixedColumnWidth(180), // Reduced from 240 to 180
                    children: [
                      TableRow(
                        children: [
                          _buildTableHeader('Sl No', TextAlign.center),
                          _buildTableHeader('Name', TextAlign.left),
                          _buildTableHeader('Lead ID', TextAlign.center),
                          _buildTableHeader('Product', TextAlign.center),
                          _buildTableHeader('Lead Status', TextAlign.center),
                          _buildTableHeader('Status', TextAlign.center),
                          _buildTableHeader('Expected Closing Date', TextAlign.center),
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
                    onPressed: currentPage < (leads.length / leadsPerPage).ceil()
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
      selected: selectedLeadStatus == label,
      selectedColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      side: const BorderSide(color: Colors.transparent),
      labelStyle: GoogleFonts.poppins(
        color: Colors.black,
        fontWeight: selectedLeadStatus == label ? FontWeight.w600 : FontWeight.normal,
      ),
      onSelected: (selected) {
        setState(() {
          selectedLeadStatus = label;
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
    List<Map<String, String>> filteredLeads = selectedLeadStatus == 'All'
        ? leads
        : leads.where((lead) => lead['status'] == selectedLeadStatus).toList();

    if (searchQuery.isNotEmpty) {
      filteredLeads = filteredLeads.where((lead) {
        final name = lead['name']!.toLowerCase();
        final leadId = lead['leadId']!.toLowerCase();
        return name.contains(searchQuery) || leadId.contains(searchQuery);
      }).toList();
    }

    final startIndex = (currentPage - 1) * leadsPerPage;
    final endIndex = (startIndex + leadsPerPage).clamp(0, filteredLeads.length);
    final paginatedLeads = filteredLeads
        .asMap()
        .entries
        .where((entry) => entry.key >= startIndex && entry.key < endIndex)
        .toList();

    return paginatedLeads.map((entry) {
      int index = entry.key;
      Map<String, String> lead = entry.value;
      return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              lead['index']!,
              style: GoogleFonts.poppins(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              lead['name']!,
              style: GoogleFonts.poppins(fontSize: 14),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              lead['leadId']!,
              style: GoogleFonts.poppins(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              lead['product']!,
              style: GoogleFonts.poppins(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              lead['leadStatus']!,
              style: GoogleFonts.poppins(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              lead['status']!,
              style: GoogleFonts.poppins(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              lead['closingDate']!,
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
                  _showEditLeadDialog(lead: lead, index: index);
                } else if (value == 'delete') {
                  _showDeleteConfirmationDialog(index);
                } else if (value == 'view') {
                  _showViewLeadDialog(lead);
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
    final totalPages = (leads.length / leadsPerPage).ceil();
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
