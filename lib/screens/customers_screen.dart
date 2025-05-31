import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_layout.dart';
import 'home_screen.dart';
import 'add_customer_dialog.dart';
import 'edit_customer_dialog.dart';
import 'customer_details.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  String selectedCustomerStatus = 'All';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  int currentPage = 1;
  final int customersPerPage = 3;

  List<Map<String, String>> customers = [
    {
      'sino': '01',
      'name': 'John Doe',
      'customerId': 'C001',
      'location': 'New York',
      'company': 'ABC Corp',
      'phone': '123-456-7890',
      'status': 'Active',
    },
    {
      'sino': '02',
      'name': 'Jane Smith',
      'customerId': 'C002',
      'location': 'London',
      'company': 'XYZ Ltd',
      'phone': '987-654-3210',
      'status': 'Inactive',
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
        return AlertDialog(
          backgroundColor: isDarkMode ? DarkTheme.backgroundColor : AppTheme.whiteColor,
          title: Row(
            children: [
              Text(
                'Import Customers',
                style: GoogleFonts.poppins(
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: isDarkMode ? DarkTheme.textColor : Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  color: isDarkMode ? DarkTheme.whiteColor : Colors.grey.shade100,
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
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  color: isDarkMode ? DarkTheme.textColor : Colors.black,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.file_download,
                color: isDarkMode ? DarkTheme.textColor : Colors.white,
              ),
              label: Text(
                'Import',
                style: GoogleFonts.poppins(
                  color: isDarkMode ? DarkTheme.textColor : Colors.white,
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
        );
      },
    );
  }

  void _showAddCustomerDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return AddCustomerDialog(
          customerNames: customers.map((customer) => customer['name']!).toSet().toList(),
          customers: customers,
          onSave: (newCustomer) {
            setState(() {
              customers.add(newCustomer);
              for (int i = 0; i < customers.length; i++) {
                customers[i]['sino'] = (i + 1).toString().padLeft(2, '0');
              }
              int totalPages = (customers.length / customersPerPage).ceil();
              if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
              }
            });
          },
        );
      },
    );
  }

  void _showEditCustomerDialog(Map<String, String> customer, int index) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return EditCustomerDialog(
          customer: customer,
          index: index,
          customerNames: customers.map((customer) => customer['name']!).toSet().toList(),
          customers: customers,
          onSave: (updatedCustomer, customerIndex) {
            setState(() {
              customers[customerIndex] = updatedCustomer;
              for (int i = 0; i < customers.length; i++) {
                customers[i]['sino'] = (i + 1).toString().padLeft(2, '0');
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
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: isDarkMode ? DarkTheme.backgroundColor : AppTheme.whiteColor,
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
                  color: isDarkMode ? DarkTheme.textColor : Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          content: SizedBox(
            width: 300,
            child: Text(
              'Are you sure you want to delete this customer? This action cannot be undone.',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
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
                backgroundColor: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFE6E6FA),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            TextButton(
              onPressed: () {
                _deleteCustomer(index);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Customer deleted successfully',
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
                  color: isDarkMode ? DarkTheme.errorColor : Colors.white,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6C5DD3),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteCustomer(int index) {
    setState(() {
      customers.removeAt(index);
      for (int i = 0; i < customers.length; i++) {
        customers[i]['sino'] = (i + 1).toString().padLeft(2, '0');
      }
      int totalPages = (customers.length / customersPerPage).ceil();
      if (currentPage > totalPages && totalPages > 0) {
        currentPage = totalPages;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return MainLayout(
      currentPage: CustomersScreen,
      content: Container(
        color: isDarkMode ? DarkTheme.backgroundColor : AppTheme.whiteColor,
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
                        color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
                      ),
                    ),
                  ),
                  Text(
                    ' > Customers',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDarkMode ? DarkTheme.textColor : const Color(0xFF1A1F37),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildSummaryCard(
                      'Total Customers',
                      '${customers.length} Customers',
                      Icons.group,
                      isDarkMode,
                    ),
                    const SizedBox(width: 8),
                    _buildSummaryCard(
                      'New This Month',
                      '0',
                      Icons.fiber_new,
                      isDarkMode,
                    ),
                    const SizedBox(width: 8),
                    _buildSummaryCard(
                      'Top Rated',
                      'None',
                      Icons.star,
                      isDarkMode,
                    ),
                    const SizedBox(width: 8),
                    _buildSummaryCard(
                      'Active',
                      '${customers.where((c) => c['status'] == 'Active').length}',
                      Icons.check_circle,
                      isDarkMode,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Customers List',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
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
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                      Icons.file_download,
                      color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF8C1AFC),
                    ),
                    onPressed: _showImportDialog,
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: _showAddCustomerDialog,
                    icon: Icon(
                      Icons.add,
                      color: isDarkMode ? DarkTheme.textColor : Colors.white,
                    ),
                    label: Text(
                      'Add Customer',
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? DarkTheme.textColor : Colors.white,
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
                  child: Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(
                        color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xFFE8E8E8),
                      ),
                    ),
                    defaultColumnWidth: const FixedColumnWidth(150),
                    children: [
                      TableRow(
                        children: [
                          _buildTableHeader('Sl No', TextAlign.center, isDarkMode),
                          _buildTableHeader('Name', TextAlign.left, isDarkMode),
                          _buildTableHeader('Customer ID', TextAlign.center, isDarkMode),
                          _buildTableHeader('Location', TextAlign.center, isDarkMode),
                          _buildTableHeader('Company', TextAlign.center, isDarkMode),
                          _buildTableHeader('Phone', TextAlign.center, isDarkMode),
                          _buildTableHeader('Status', TextAlign.center, isDarkMode),
                          _buildTableHeader('Actions', TextAlign.center, isDarkMode),
                        ],
                      ),
                      ..._buildFilteredTableRows(isDarkMode),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildPaginationControls(isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader(String title, TextAlign alignment, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
        ),
        textAlign: alignment,
      ),
    );
  }

  List<TableRow> _buildFilteredTableRows(bool isDarkMode) {
    List<Map<String, String>> filteredCustomers = selectedCustomerStatus == 'All'
        ? customers
        : customers.where((c) => c['status'] == selectedCustomerStatus).toList();

    if (searchQuery.isNotEmpty) {
      filteredCustomers = filteredCustomers.where((customer) {
        final name = customer['name']?.toLowerCase() ?? '';
        final customerId = customer['customerId']?.toLowerCase() ?? '';
        return name.contains(searchQuery) || customerId.contains(searchQuery);
      }).toList();
    }

    final startIndex = (currentPage - 1) * customersPerPage;
    final endIndex = startIndex + customersPerPage;
    final paginatedCustomers = filteredCustomers
        .asMap()
        .entries
        .where((entry) => entry.key >= startIndex && entry.key < endIndex)
        .toList();

    return paginatedCustomers.map((entry) {
      int filteredIndex = entry.key;
      Map<String, String> customer = entry.value;
      int originalIndex = customers.indexWhere((c) => c['customerId'] == customer['customerId']);

      return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              customer['sino'] ?? '',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              customer['name'] ?? '',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              customer['customerId'] ?? '',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              customer['location'] ?? '',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              customer['company'] ?? '',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              customer['phone'] ?? '',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  customers[originalIndex]['status'] =
                  customer['status'] == 'Active' ? 'Inactive' : 'Active';
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: customer['status'] == 'Active' ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  customer['status'] ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: isDarkMode ? DarkTheme.textColor : Colors.black,
              ),
              onSelected: (value) {
                if (value == 'view') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerDetailsScreen(customer: customer),
                    ),
                  );
                } else if (value == 'edit') {
                  _showEditCustomerDialog(customer, originalIndex);
                } else if (value == 'delete') {
                  _showDeleteConfirmationDialog(originalIndex);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'view',
                  child: Row(
                    children: [
                      Icon(
                        Icons.visibility,
                        color: isDarkMode ? DarkTheme.textColor : Colors.black,
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
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: isDarkMode ? DarkTheme.textColor : Colors.black,
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
                PopupMenuItem(
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

  Widget _buildPaginationControls(bool isDarkMode) {
    final totalPages = (customers.length / customersPerPage).ceil();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: currentPage > 1 ? () => setState(() => currentPage--) : null,
          child: Row(
            children: [
              Icon(
                Icons.arrow_left,
                color: isDarkMode ? DarkTheme.textColor : Colors.black,
              ),
              Text(
                'Previous',
                style: GoogleFonts.poppins(
                  color: isDarkMode ? DarkTheme.textColor : Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        ...List.generate(totalPages, (index) {
          final pageNumber = index + 1;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () => setState(() => currentPage = pageNumber),
              child: Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: currentPage == pageNumber
                    ? BoxDecoration(
                  color: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6C5DD3),
                  borderRadius: BorderRadius.circular(4),
                )
                    : null,
                child: Text(
                  pageNumber.toString(),
                  style: GoogleFonts.poppins(
                    color: currentPage == pageNumber
                        ? (isDarkMode ? DarkTheme.textColor : Colors.white)
                        : (isDarkMode ? DarkTheme.textColor : Colors.black),
                    fontWeight: currentPage == pageNumber ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
        const SizedBox(width: 8),
        TextButton(
          onPressed: currentPage < totalPages ? () => setState(() => currentPage++) : null,
          child: Row(
            children: [
              Text(
                'Next',
                style: GoogleFonts.poppins(
                  color: isDarkMode ? DarkTheme.textColor : Colors.black,
                ),
              ),
              Icon(
                Icons.arrow_right,
                color: isDarkMode ? DarkTheme.textColor : Colors.black,
              ),
            ],
          ),
        ),
      ],
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
                ? selectedCustomerStatus == label
                ? DarkTheme.textColor
                : DarkTheme.textColor.withOpacity(0.7)
                : selectedCustomerStatus == label
                ? AppTheme.textColor
                : AppTheme.secondaryTextColor,
            fontWeight: selectedCustomerStatus == label ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
      selected: selectedCustomerStatus == label,
      selectedColor: isDarkMode ? DarkTheme.primaryColor.withOpacity(0.2) : Colors.transparent,
      backgroundColor: Colors.transparent,
      side: BorderSide(
        color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : Colors.transparent,
      ),
      onSelected: (selected) {
        setState(() {
          selectedCustomerStatus = label;
          currentPage = 1;
        });
      },
    );
  }
}