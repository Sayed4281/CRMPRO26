import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:intl/intl.dart';
<<<<<<< HEAD
=======
import 'dart:ui';
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
import 'main_layout.dart';
import 'package:crmpro26/screens/visits_screen.dart';
import 'enquiry_screen.dart';
import 'leads_screen.dart';
import 'calls_screen.dart';
import 'add_edit_visit_dialog.dart';
<<<<<<< HEAD
import 'add_enquiry_dialog.dart';
import 'add_call_dialog.dart';
import 'add_customer_dialog.dart';
import 'reports_screen.dart';
import '../theme/app_theme.dart'; // Import AppTheme
import '../theme/dark_theme.dart'; // Import DarkTheme
=======
<<<<<<< HEAD
import 'add_enquiry_dialog.dart';
import 'add_call_dialog.dart';
import 'add_customer_dialog.dart';
=======
import 'add_enquiry.dart';
import 'add_call.dart';
import 'add_customer.dart';
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
import 'reports_screen.dart';
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedChart = 'Enquiries';
  String selectedRange = 'Daily';
  int chartOffset = 0;
  DateTime? selectedDate;

<<<<<<< HEAD
  // State variables for customerNames, customers, visits, and calls
  List<String> customerNames = [];
  List<Map<String, String>> customers = [];
  List<Map<String, String>> visits = []; // Changed type to List<Map<String, String>>
  List<Map<String, dynamic>> calls = [];

=======
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
  final Map<String, List<String>> chartLabels = {
    'Enquiries': ['Validated', 'Closed'],
    'Visits': [
      'New',
      'FollowUp',
      'Demo',
      'Installation',
      'Training',
      'Service',
      'Payments'
    ],
    'Leads': [
      'Demo Completed',
      'Demo Scheduled',
      'Waiting',
      'Discussion',
      'Quotation',
      'Submitted'
    ],
    'Calls': ['Active', 'Inactive'],
    'Customers': ['Active', 'Inactive'],
    'Product': ['InStock', 'OutOfStock'],
  };

  final List<Color> purpleShades = List.generate(
    7,
<<<<<<< HEAD
        (i) => Colors.deepPurple[(i + 1) * 100]!,
=======
<<<<<<< HEAD
        (i) => Colors.deepPurple[(i + 1) * 100]!,
=======
    (i) => Colors.deepPurple[(i + 1) * 100]!,
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
  );

  final DateFormat _dateFormat = DateFormat("MMM d");

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? DarkTheme.backgroundColor : Colors.deepPurple.shade100,
=======
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
      body: MainLayout(
        currentPage: HomeScreen,
        content: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
<<<<<<< HEAD
                _buildHeader(isDarkMode),
                const SizedBox(height: 32),
                _buildStatsCards(isDarkMode),
                const SizedBox(height: 32),
                _buildQuickActions(context, isDarkMode),
                const SizedBox(height: 32),
                _buildReportRedirect(isDarkMode),
                const SizedBox(height: 32),
                _buildOverviewSection(isDarkMode),
=======
                _buildHeader(),
                const SizedBox(height: 32),
                _buildStatsCards(),
                const SizedBox(height: 32),
                _buildQuickActions(context),
                const SizedBox(height: 32),
                _buildReportRedirect(),
                const SizedBox(height: 32),
                _buildOverviewSection(),
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
              ],
            ),
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildHeader(bool isDarkMode) => Text(
=======
  Widget _buildHeader() => Text(
<<<<<<< HEAD
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
    'Welcome!',
    style: GoogleFonts.poppins(
      fontSize: 36,
      fontWeight: FontWeight.bold,
<<<<<<< HEAD
      color: isDarkMode ? DarkTheme.textColor : Colors.black,
    ),
  );

  Widget _buildStatsCards(bool isDarkMode) {
=======
    ),
  );
=======
        'Welcome!',
        style: GoogleFonts.poppins(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      );
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0

  Widget _buildStatsCards() {
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
    List<Map<String, dynamic>> stats = [
      {
        'title': 'Enquiries',
        'value': '678',
        'icon': Icons.question_answer,
        'screen': const EnquiryScreen(),
      },
      {
        'title': 'Leads',
        'value': '347',
        'icon': Icons.leaderboard,
        'screen': const LeadsScreen(),
      },
      {
        'title': 'Visits',
        'value': '650',
        'icon': Icons.event,
        'screen': const VisitsScreen(),
      },
      {
        'title': 'Calls',
        'value': '478',
        'icon': Icons.phone,
        'screen': const CallsScreen(),
      },
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: stats.map((item) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => item['screen']),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 250,
              height: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
<<<<<<< HEAD
                color: isDarkMode ? DarkTheme.whiteColor : const Color.fromARGB(255, 247, 243, 252),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode ? DarkTheme.textColor.withOpacity(0.1) : Colors.deepPurple.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item['icon'], size: 24, color: isDarkMode ? DarkTheme.accentColor : Colors.deepPurple),
                  const SizedBox(height: 8),
                  Text(
                    item['title'],
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? DarkTheme.textColor : Colors.black,
                    ),
                  ),
                  Text(
                    item['value'],
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? DarkTheme.textColor : Colors.black,
                    ),
                  ),
                  Text(
                    'Total',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickActions(BuildContext context, bool isDarkMode) {
    List<Map<String, dynamic>> actions = [
      {
        'label': 'Add Customer',
        'icon': Icons.person_add,
      },
      {
        'label': 'Add Enquiry',
        'icon': Icons.question_answer,
      },
      {
        'label': 'Log Call',
        'icon': Icons.phone,
      },
      {
        'label': 'Schedule Visit',
        'icon': Icons.event,
      },
    ];

    void _showScheduleVisitDialog() {
      showDialog(
        context: context,
        barrierColor: Colors.black54, // Solid semi-transparent background
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent, // Removed white background
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8, // Responsive width
                maxHeight: 600,
              ),
              child: AddEditVisitDialog(
                customerNames: customerNames,
                visits: visits,
                onSave: (visit, [index]) {
                  // Convert visit (Map<String, dynamic>) to Map<String, String>
                  final Map<String, String> visitStringMap = visit.map(
                        (key, value) => MapEntry(key, value.toString()),
                  );
                  setState(() {
                    if (index != null) {
                      visits[index] = visitStringMap;
                    } else {
                      visits.add(visitStringMap);
                    }
                  });
                },
              ),
            ),
          );
        },
      );
    }

    void _showAddCustomerDialog() {
      showDialog(
        context: context,
        barrierColor: Colors.black54, // Solid semi-transparent background
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent, // Removed white background
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8, // Responsive width
                maxHeight: 600,
              ),
              child: AddCustomerDialog(
                customerNames: customerNames,
                customers: customers,
                onSave: (customer) {
                  setState(() {
                    customers.add(customer);
                    customerNames.add(customer['name']!);
                  });
                },
              ),
            ),
          );
        },
      );
    }

    void _showAddEnquiryDialog() {
      showDialog(
        context: context,
        barrierColor: Colors.black54, // Solid semi-transparent background
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent, // Removed white background
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8, // Responsive width
                maxHeight: 600,
              ),
              child: const AddEnquiryDialog(),
            ),
          );
        },
      );
    }

    void _showAddCallDialog() {
      showDialog(
        context: context,
        barrierColor: Colors.black54, // Solid semi-transparent background
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent, // Removed white background
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8, // Responsive width
                maxHeight: 600,
              ),
              child: AddCallDialog(
                onSave: (call) {
                  setState(() {
                    calls.add(call);
                  });
                },
              ),
            ),
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? DarkTheme.textColor : Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: actions.map((item) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ElevatedButton.icon(
                icon: Icon(item['icon'], color: isDarkMode ? DarkTheme.textColor : Colors.white),
                label: Text(
                  item['label'],
                  style: GoogleFonts.poppins(color: isDarkMode ? DarkTheme.textColor : Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF7B1FA2),
                  foregroundColor: isDarkMode ? DarkTheme.textColor : Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
                onPressed: () {
                  if (item['label'] == 'Schedule Visit') {
                    _showScheduleVisitDialog();
                  } else if (item['label'] == 'Add Customer') {
                    _showAddCustomerDialog();
                  } else if (item['label'] == 'Add Enquiry') {
                    _showAddEnquiryDialog();
                  } else if (item['label'] == 'Log Call') {
                    _showAddCallDialog();
                  }
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildReportRedirect(bool isDarkMode) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReportsScreen()),
          );
        },
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.bar_chart,
                      size: 28,
                      color: isDarkMode ? DarkTheme.accentColor : Colors.black,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Report Summary',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: isDarkMode ? DarkTheme.textColor : Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isDarkMode ? DarkTheme.textColor : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewTile(String title, String value, bool isDarkMode) {
    return SizedBox(
      width: 180,
      child: Card(
        color: isDarkMode ? DarkTheme.whiteColor : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? DarkTheme.textColor : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? DarkTheme.textColor : Colors.black,
                ),
              ),
            ],
=======
                color: const Color.fromARGB(255, 247, 243, 252),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.deepPurple.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item['icon'], size: 24, color: Colors.deepPurple),
                  const SizedBox(height: 8),
                  Text(item['title'],
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(item['value'],
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('Total', style: GoogleFonts.poppins(fontSize: 12)),
                ],
              ),
            ),
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
          ),
        );
      }).toList(),
    );
  }

<<<<<<< HEAD
  Widget _buildLegend(List<String> labels, List<Color> colors, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: labels.asMap().entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                color: colors[entry.key % colors.length],
              ),
              const SizedBox(width: 4),
              Text(
                entry.value,
                style: GoogleFonts.poppins(
                  color: isDarkMode ? DarkTheme.textColor : Colors.black,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildOverviewSection(bool isDarkMode) {
    final chartOptions = chartLabels.keys.toList();
=======
  Widget _buildQuickActions(BuildContext context) {
    List<Map<String, dynamic>> actions = [
      {
        'label': 'Add Customer',
        'icon': Icons.person_add,
<<<<<<< HEAD
        // No screen for this — handled with a dialog
=======
        'screen': const AddCustomerScreen(),
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
      },
      {
        'label': 'Add Enquiry',
        'icon': Icons.question_answer,
<<<<<<< HEAD
        // No screen for this — handled with a dialog
=======
        'screen': const AddEnquiryScreen(),
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
      },
      {
        'label': 'Log Call',
        'icon': Icons.phone,
<<<<<<< HEAD
        // No screen for this — handled with a dialog
=======
        'screen': const AddCallScreen(),
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
      },
      {
        'label': 'Schedule Visit',
        'icon': Icons.event,
        // No screen for this — handled with a dialog
      },
    ];

    void _showScheduleVisitDialog() {
      showDialog(
        context: context,
        barrierColor: Colors.transparent, // Glass effect
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor:
<<<<<<< HEAD
              Colors.white.withOpacity(0.9), // Glass-like dialog
=======
                  Colors.white.withOpacity(0.9), // Glass-like dialog
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                  maxHeight: 600,
                ),
                child: AddEditVisitDialog(
                  customerNames: const [], // Replace with actual list
                  visits: const [], // Replace with actual data
                  onSave: (visit, [index]) {
                    // Handle save logic
                  },
                ),
              ),
            ),
          );
        },
      );
    }
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
<<<<<<< HEAD
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview${selectedDate != null ? ' - ${_dateFormat.format(selectedDate!)}' : ''}',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? DarkTheme.textColor : Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.fromSeed(
                              seedColor: isDarkMode ? DarkTheme.primaryColor : Colors.deepPurple.shade400,
                              brightness: isDarkMode ? Brightness.dark : Brightness.light,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      setState(() => selectedDate = picked);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? DarkTheme.primaryColor : Colors.deepPurple.shade400,
                    foregroundColor: isDarkMode ? DarkTheme.textColor : Colors.white,
                  ),
                  child: Text(
                    'Select Date',
                    style: GoogleFonts.poppins(
                      color: isDarkMode ? DarkTheme.textColor : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: selectedRange,
                  items: ['Daily', 'Monthly', 'Yearly'].map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? DarkTheme.textColor : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => selectedRange = val ?? 'Daily'),
                  style: GoogleFonts.poppins(
                    color: isDarkMode ? DarkTheme.textColor : Colors.black,
                  ),
                  dropdownColor: isDarkMode ? DarkTheme.whiteColor : Colors.white,
                ),
              ],
            ),
          ],
        ),
        _buildLegend(chartLabels[selectedChart]!, purpleShades, isDarkMode),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildOverviewTile('Enquiries Today', '62', isDarkMode),
            _buildOverviewTile('Visits Today', '12', isDarkMode),
            _buildOverviewTile('Leads Today', '30', isDarkMode),
            _buildOverviewTile('Calls Today', '30', isDarkMode),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: chartOptions.map((option) {
              final isSelected = selectedChart == option;

              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedChart = option;
                    });
                  },
                  child: Text(
                    option,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isDarkMode
                          ? (isSelected ? DarkTheme.accentColor : DarkTheme.textColor.withOpacity(0.7))
                          : (isSelected ? Colors.black : Colors.grey),
                      decoration: isSelected ? TextDecoration.underline : null,
                      decorationColor: isDarkMode ? DarkTheme.accentColor : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                if (chartOffset > 0) setState(() => chartOffset--);
              },
              icon: Icon(
                Icons.arrow_back,
                color: isDarkMode ? DarkTheme.textColor : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () => setState(() => chartOffset++),
              icon: Icon(
                Icons.arrow_forward,
                color: isDarkMode ? DarkTheme.textColor : Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 320,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 30,
              barGroups: List.generate(10, (i) {
                final isDense = chartLabels[selectedChart]!.length > 5;
                return BarChartGroupData(
                  x: i,
                  barRods: List.generate(chartLabels[selectedChart]!.length, (j) {
                    return BarChartRodData(
                      toY: Random().nextInt(30).toDouble(),
                      color: purpleShades[j % purpleShades.length],
                      width: isDense ? 10 : 24,
                      borderRadius: BorderRadius.circular(6),
                    );
                  }),
                  showingTooltipIndicators: [],
                );
              }),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      int intVal = value.toInt();
                      if (selectedRange == 'Yearly') {
                        return Text(
                          '${2020 + intVal + chartOffset}',
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? DarkTheme.textColor : Colors.black,
                          ),
                        );
                      } else if (selectedRange == 'Monthly') {
                        const months = [
                          'Jan',
                          'Feb',
                          'Mar',
                          'Apr',
                          'May',
                          'Jun',
                          'Jul',
                          'Aug',
                          'Sep',
                          'Oct',
                          'Nov',
                          'Dec'
                        ];
                        return Text(
                          months[(intVal + chartOffset) % 12],
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? DarkTheme.textColor : Colors.black,
                          ),
                        );
                      }
                      return Text(
                        _dateFormat.format(DateTime(2025, 4, intVal + 1 + chartOffset * 10)),
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? DarkTheme.textColor : Colors.black,
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) => Text(
                      '${value.toInt()}',
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? DarkTheme.textColor : Colors.black,
                      ),
                    ),
                  ),
                ),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(
                show: false,
                drawVerticalLine: false,
                horizontalInterval: 5,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: isDarkMode ? DarkTheme.textColor.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipPadding: const EdgeInsets.all(8),
                  tooltipRoundedRadius: 8,
                  getTooltipColor: (_) => isDarkMode ? DarkTheme.whiteColor : Colors.white,
                  tooltipBorder: BorderSide.none,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final label = chartLabels[selectedChart]![rodIndex];
                    return BarTooltipItem(
                      '$label: ${rod.toY.toStringAsFixed(1)}',
                      GoogleFonts.poppins(
                        color: isDarkMode ? DarkTheme.textColor : Colors.black,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
=======
        Text(
          'Quick Actions',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: actions.map((item) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ElevatedButton.icon(
                icon: Icon(item['icon']),
                label: Text(item['label']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B1FA2),
                  foregroundColor: Colors.white,
                  padding:
<<<<<<< HEAD
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
=======
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
                ),
                onPressed: () {
                  if (item['label'] == 'Schedule Visit') {
                    _showScheduleVisitDialog();
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => item['screen']),
                    );
                  }
                },
              ),
            );
          }).toList(),
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
        ),
      ],
    );
  }
<<<<<<< HEAD
}
=======

  Widget _buildReportRedirect() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReportsScreen()),
          );
        },
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: const Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Left section (icon + title)
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.bar_chart, size: 28),
                    const SizedBox(width: 12),

                    /// Make text wrap or ellipsize if needed
                    Expanded(
                      child: Text(
                        'Report Summary',
                        style: GoogleFonts.poppins(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              /// Right chevron icon
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewTile(String title, String value) {
    return SizedBox(
      width: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Text(value,
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(List<String> labels, List<Color> colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: labels
          .asMap()
          .entries
          .map((entry) => Padding(
<<<<<<< HEAD
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              color: colors[entry.key % colors.length],
            ),
            const SizedBox(width: 4),
            Text(entry.value),
          ],
        ),
      ))
=======
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      color: colors[entry.key % colors.length],
                    ),
                    const SizedBox(width: 4),
                    Text(entry.value),
                  ],
                ),
              ))
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
          .toList(),
    );
  }

  Widget _buildOverviewSection() {
    final chartOptions = chartLabels.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview${selectedDate != null ? ' - ${_dateFormat.format(selectedDate!)}' : ''}',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis, // Shrink long text
                  ),
                ],
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
<<<<<<< HEAD
                    if (picked != null) {
                      setState(() => selectedDate = picked);
                    }
                  },
=======
                    setState(() => selectedDate = picked);
                                    },
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade400,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Select Date'),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: selectedRange,
                  items: ['Daily', 'Monthly', 'Yearly']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => selectedRange = val ?? 'Daily'),
                ),
              ],
            ),
          ],
        ),
        _buildLegend(chartLabels[selectedChart]!, purpleShades),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildOverviewTile('Enquiries Today', '62'),
            _buildOverviewTile('Visits Today', '12'),
            _buildOverviewTile('Leads Today', '30'),
            _buildOverviewTile('Calls Today', '30'),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: chartOptions.map((option) {
              final isSelected = selectedChart == option;

              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedChart = option;
                    });
                  },
                  child: Text(
                    option,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight:
<<<<<<< HEAD
                      isSelected ? FontWeight.w600 : FontWeight.normal,
=======
                          isSelected ? FontWeight.w600 : FontWeight.normal,
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
                      color: isSelected ? Colors.black : Colors.grey,
                      decoration: isSelected ? TextDecoration.underline : null,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  if (chartOffset > 0) setState(() => chartOffset--);
                },
                icon: const Icon(Icons.arrow_back)),
            IconButton(
                onPressed: () => setState(() => chartOffset++),
                icon: const Icon(Icons.arrow_forward)),
          ],
        ),
        SizedBox(
          height: 320,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 30,
              barGroups: List.generate(10, (i) {
                final isDense = chartLabels[selectedChart]!.length > 5;
                return BarChartGroupData(
                  x: i,
                  barRods:
<<<<<<< HEAD
                  List.generate(chartLabels[selectedChart]!.length, (j) {
=======
                      List.generate(chartLabels[selectedChart]!.length, (j) {
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
                    return BarChartRodData(
                      toY: Random().nextInt(30).toDouble(),
                      color: purpleShades[j % purpleShades.length],
                      width: isDense ? 10 : 24,
                      borderRadius: BorderRadius.circular(6),
                    );
                  }),
                  showingTooltipIndicators: [],
                );
              }),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      int intVal = value.toInt();
                      if (selectedRange == 'Yearly') {
                        return Text('${2020 + intVal + chartOffset}');
                      } else if (selectedRange == 'Monthly') {
                        const months = [
                          'Jan',
                          'Feb',
                          'Mar',
                          'Apr',
                          'May',
                          'Jun',
                          'Jul',
                          'Aug',
                          'Sep',
                          'Oct',
                          'Nov',
                          'Dec'
                        ];
                        return Text(months[(intVal + chartOffset) % 12]);
                      }
                      return Text(_dateFormat.format(
                          DateTime(2025, 4, intVal + 1 + chartOffset * 10)));
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) => Text('${value.toInt()}')),
                ),
                topTitles:
<<<<<<< HEAD
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
=======
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipPadding: const EdgeInsets.all(8),
                  tooltipRoundedRadius: 8,
                  tooltipBorder: BorderSide.none,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final label = chartLabels[selectedChart]![rodIndex];
                    return BarTooltipItem(
                      '$label: ${rod.toY.toStringAsFixed(1)}',
                      const TextStyle(color: Colors.black),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 6af909091caab2da233caa92503efed2312d79b0
>>>>>>> ff54e8a0f15e609eeda25e26cac90c1024284bff
