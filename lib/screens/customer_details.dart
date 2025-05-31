import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_layout.dart';
import 'home_screen.dart';
import 'customers_screen.dart';
import 'enquiry_screen.dart';
import 'add_enquiry_dialog.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> customer;

  const CustomerDetailsScreen({
    super.key,
    required this.customer,
  });

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  String enquirySearchQuery = '';
  final TextEditingController _enquirySearchController = TextEditingController();
  int currentPage = 1;
  final int enquiriesPerPage = 5;

  @override
  void initState() {
    super.initState();
    _enquirySearchController.addListener(() {
      setState(() {
        enquirySearchQuery = _enquirySearchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _enquirySearchController.dispose();
    super.dispose();
  }

  void _showAddEnquiryDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return const AddEnquiryDialog();
      },
    ).then((result) {
      if (result != null && result is Map<String, dynamic>) {
        setState(() {
          EnquiryScreen.enquiries.add({
            'index': (EnquiryScreen.enquiries.length + 1).toString().padLeft(2, '0'),
            'customer': widget.customer['name']?.toString() ?? 'Unknown',
            'enquiryId': 'ENQ-204${EnquiryScreen.enquiries.length % 10}',
            'product': result['product']?.toString() ?? 'Unknown',
            'plan': result['plan']?.toString() ?? 'Unknown',
            'demo': result['demo']?.toString() ?? 'No',
            'status': result['status']?.toString() ?? 'Open',
            'quantity': result['quantity']?.toString() ?? '0',
            'date': result['date']?.toString() ?? 'Unknown',
            'notes': result['notes']?.toString() ?? 'No notes',
          });
        });
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Enquiry added successfully',
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

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        color: isDarkMode ? DarkTheme.backgroundColor : AppTheme.whiteColor,
        child: MainLayout(
          currentPage: CustomerDetailsScreen,
          content: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
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
                            color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const CustomersScreen()),
                          );
                        },
                        child: Text(
                          'Customers',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
                      ),
                      Text(
                        'Customer Details',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            _buildProfileCard(context, isDarkMode),
                            const SizedBox(height: 16),
                            _buildContactCard(isDarkMode),
                            const SizedBox(height: 16),
                            _buildAddressCard(isDarkMode),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _buildStatsCard(isDarkMode),
                            const SizedBox(height: 16),
                            _buildCompanyCard(isDarkMode),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 240,
                        child: _buildActivityLog(isDarkMode),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildEnquiriesList(isDarkMode),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFF3EEFB),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: isDarkMode ? DarkTheme.accentColor.withOpacity(0.2) : const Color(0xFFE6E6FA),
                  child: Text(
                    widget.customer['name']?.substring(0, 1).toUpperCase() ?? 'A',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF6C5DD3),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.customer['name'] ?? 'Dr. John Smith',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.customer['customerId'] ?? 'CUST-2041',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : const Color(0xFF7A7A7A),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Designation: ${widget.customer['designation'] ?? 'Manager'}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? DarkTheme.errorColor : const Color(0xFFD32F2F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    minimumSize: const Size(40, 32),
                  ),
                  child: Text(
                    'Delete',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6C5DD3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    minimumSize: const Size(40, 32),
                  ),
                  child: Text(
                    'Update',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(bool isDarkMode) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFF3EEFB),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contact Details',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
              ),
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              'Phone:',
              widget.customer['phone'] ?? '+91 9856246584',
              fontSize: 12,
              isDarkMode: isDarkMode,
            ),
            _buildDetailRow(
              'Email:',
              widget.customer['email'] ?? 'johnsmith@gmail.com',
              fontSize: 12,
              isDarkMode: isDarkMode,
            ),
            _buildDetailRow(
              'Alternate Number:',
              widget.customer['alternateNumber'] ?? '+91 8954652874',
              fontSize: 12,
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {double fontSize = 14, required bool isDarkMode}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: fontSize,
                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : const Color(0xFF7A7A7A),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(bool isDarkMode) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFF3EEFB),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Address',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.customer['address'] ?? 'ABCD Company\nVikas Nagar, Street 22\nMumbai, India\n624587',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
              ),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyCard(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFF3EEFB),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Company Details',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
              ),
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              'Company:',
              widget.customer['company'] ?? 'ABCD Company',
              fontSize: 12,
              isDarkMode: isDarkMode,
            ),
            _buildDetailRow(
              'Type:',
              widget.customer['companyType'] ?? 'Hospital',
              fontSize: 12,
              isDarkMode: isDarkMode,
            ),
            _buildDetailRow(
              'Location:',
              widget.customer['companyLocation'] ?? 'Mumbai, India',
              fontSize: 12,
              isDarkMode: isDarkMode,
            ),
            _buildDetailRow(
              'Contact:',
              widget.customer['companyContact'] ?? '+91 8654742356',
              fontSize: 12,
              isDarkMode: isDarkMode,
            ),
            _buildDetailRow(
              'Email:',
              widget.customer['companyEmail'] ?? '--',
              fontSize: 12,
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(bool isDarkMode) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Status',
                widget.customer['status'] ?? 'Active',
                icon: Icons.check_circle,
                color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF6C5DD3),
                isStatus: true,
                isDarkMode: isDarkMode,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Total Enquiries',
                EnquiryScreen.enquiries
                    .where((enquiry) => enquiry['customer'] == widget.customer['name'])
                    .length
                    .toString(),
                icon: Icons.list,
                isDarkMode: isDarkMode,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'In progress',
                EnquiryScreen.enquiries
                    .where((enquiry) =>
                enquiry['customer'] == widget.customer['name'] && enquiry['status'] == 'Open')
                    .length
                    .toString(),
                icon: Icons.hourglass_empty,
                isDarkMode: isDarkMode,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Demo Shed.',
                EnquiryScreen.enquiries
                    .where((enquiry) =>
                enquiry['customer'] == widget.customer['name'] && enquiry['demo'] == 'Yes')
                    .length
                    .toString(),
                icon: Icons.calendar_today,
                isDarkMode: isDarkMode,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value,
      {IconData? icon, Color? color, bool isStatus = false, required bool isDarkMode}) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFF3EEFB),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null)
              Row(
                children: [
                  Icon(icon, size: 16, color: color ?? (isDarkMode ? DarkTheme.accentColor : const Color(0xFF6C5DD3))),
                  const SizedBox(width: 6),
                ],
              ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : const Color(0xFF7A7A7A),
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            isStatus
                ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDarkMode ? DarkTheme.accentColor.withOpacity(0.2) : const Color(0xFFE6E6FA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF6C5DD3),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )
                : Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityLog(bool isDarkMode) {
    final List<Map<String, String>> activityLogs = EnquiryScreen.enquiries
        .where((enquiry) => enquiry['customer'] == widget.customer['name'])
        .map((enquiry) => {
      'enquiryId': enquiry['enquiryId']?.toString() ?? '',
      'product': enquiry['product']?.toString() ?? '',
      'createdOn': enquiry['date']?.toString() ?? '',
    })
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFF3EEFB),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activity Log',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(
                      children: [
                        _buildTableHeader('ENQUIRY ID', fontSize: 12, isDarkMode: isDarkMode),
                        _buildTableHeader('PRODUCT', fontSize: 12, isDarkMode: isDarkMode),
                        _buildTableHeader('CREATED ON', fontSize: 12, isDarkMode: isDarkMode),
                      ],
                    ),
                    ...activityLogs.map((log) => TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            log['enquiryId']!,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            log['product']!,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            log['createdOn']!,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : const Color(0xFF7A7A7A),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text, {double fontSize = 14, required bool isDarkMode}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : const Color(0xFF7A7A7A),
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildEnquiriesList(bool isDarkMode) {
    List<Map<String, String>> customerEnquiries = EnquiryScreen.enquiries
        .where((enquiry) => enquiry['customer'] == widget.customer['name'])
        .map((enquiry) => {
      'slNo': enquiry['index']?.toString() ?? '',
      'enquiryId': enquiry['enquiryId']?.toString() ?? '',
      'product': enquiry['product']?.toString() ?? '',
      'purchasePlan': enquiry['plan']?.toString() ?? '',
      'demoRequired': enquiry['demo']?.toString() ?? '',
      'status': enquiry['status']?.toString() ?? '',
    })
        .toList();

    if (enquirySearchQuery.isNotEmpty) {
      customerEnquiries = customerEnquiries.where((enquiry) {
        final enquiryId = enquiry['enquiryId']?.toLowerCase() ?? '';
        final product = enquiry['product']?.toLowerCase() ?? '';
        return enquiryId.contains(enquirySearchQuery) || product.contains(enquirySearchQuery);
      }).toList();
    }

    final startIndex = (currentPage - 1) * enquiriesPerPage;
    final endIndex = startIndex + enquiriesPerPage;
    final paginatedEnquiries = customerEnquiries
        .asMap()
        .entries
        .where((entry) => entry.key >= startIndex && entry.key < endIndex)
        .map((entry) => entry.value)
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFF3EEFB),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enquiries List',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showAddEnquiryDialog,
                  icon: Icon(
                    Icons.add,
                    size: 18,
                    color: isDarkMode ? DarkTheme.textColor : Colors.white,
                  ),
                  label: Text(
                    'Add Enquiry',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDarkMode ? DarkTheme.textColor : Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6C5DD3),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(48, 40),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _enquirySearchController,
                decoration: InputDecoration(
                  hintText: 'Search by Enquiry ID, Product',
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
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 40,
                dataRowMinHeight: 50,
                dataRowMaxHeight: 50,
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : const Color(0xFF7A7A7A),
                ),
                dataTextStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
                ),
                columns: const [
                  DataColumn(label: Text('SL. NO')),
                  DataColumn(label: Text('ENQUIRY ID')),
                  DataColumn(label: Text('PRODUCT')),
                  DataColumn(label: Text('PURCHASE PLAN')),
                  DataColumn(label: Text('DEMO REQ.')),
                  DataColumn(label: Text('STATUS')),
                  DataColumn(label: Text('')),
                ],
                rows: paginatedEnquiries.map((enquiry) => DataRow(
                  cells: [
                    DataCell(Text(enquiry['slNo']!)),
                    DataCell(Text(enquiry['enquiryId']!)),
                    DataCell(Text(enquiry['product']!)),
                    DataCell(Text(enquiry['purchasePlan']!)),
                    DataCell(Text(enquiry['demoRequired']!)),
                    DataCell(
                      Text(
                        enquiry['status']!,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: enquiry['status'] == 'Validated'
                              ? Colors.green
                              : enquiry['status'] == 'Open'
                              ? Colors.orange
                              : Colors.red,
                        ),
                      ),
                    ),
                    DataCell(
                      Icon(
                        Icons.more_vert,
                        size: 18,
                        color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : const Color(0xFF7A7A7A),
                      ),
                    ),
                  ],
                )).toList(),
              ),
            ),
            const SizedBox(height: 24),
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
                        color: isDarkMode ? DarkTheme.textColor : const Color(0xFF6C5DD3),
                      ),
                      Text(
                        'Previous',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : const Color(0xFF6C5DD3),
                        ),
                      ),
                    ],
                  ),
                ),
                ..._buildPageNumbers(customerEnquiries.length, isDarkMode),
                TextButton(
                  onPressed: currentPage < (customerEnquiries.length / enquiriesPerPage).ceil()
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
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF6C5DD3),
                        ),
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF6C5DD3),
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageNumbers(int totalEnquiries, bool isDarkMode) {
    final totalPages = (totalEnquiries / enquiriesPerPage).ceil();
    List<Widget> pageNumbers = [];
    for (int i = 1; i <= totalPages && i <= 3; i++) {
      pageNumbers.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: _buildPageNumber(i, i == currentPage, isDarkMode),
        ),
      );
    }
    return pageNumbers;
  }

  Widget _buildPageNumber(int number, bool isSelected, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentPage = number;
        });
      },
      child: Container(
        width: 28,
        height: 28,
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
            fontSize: 14,
            color: isSelected
                ? (isDarkMode ? DarkTheme.textColor : Colors.white)
                : (isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37)),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}