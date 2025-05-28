import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'main_layout.dart';
import 'package:crmpro26/screens/visits_screen.dart';
import 'enquiry_screen.dart';
import 'leads_screen.dart';
import 'calls_screen.dart';
import 'add_edit_visit_dialog.dart';
import 'add_enquiry.dart';
import 'add_call.dart';
import 'add_customer.dart';
import 'reports_screen.dart';

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
    (i) => Colors.deepPurple[(i + 1) * 100]!,
  );

  final DateFormat _dateFormat = DateFormat("MMM d");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: MainLayout(
        currentPage: HomeScreen,
        content: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildStatsCards(),
                const SizedBox(height: 32),
                _buildQuickActions(),
                const SizedBox(height: 32),
                _buildReportRedirect(),
                const SizedBox(height: 32),
                _buildOverviewSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Text(
        'Welcome!',
        style: GoogleFonts.poppins(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _buildStatsCards() {
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
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickActions() {
    List<Map<String, dynamic>> actions = [
      {
        'label': 'Add Customer',
        'icon': Icons.person_add,
        'screen': const AddCustomerScreen(),
      },
      {
        'label': 'Add Enquiry',
        'icon': Icons.question_answer,
        'screen': const AddEnquiryScreen(),
      },
      {
        'label': 'Log Call',
        'icon': Icons.phone,
        'screen': const AddCallScreen(),
      },
      {
        'label': 'Schedule Visit',
        'icon': Icons.event,
        'screen': AddEditVisitDialog(
          customerNames: const [],
          visits: const [],
          onSave: (visit, [index]) {},
        ),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions',
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
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
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => item['screen']),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

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
          .toList(),
    );
  }

  Widget _buildOverviewSection() {
    final chartOptions = chartLabels.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Overview${selectedDate != null ? ' - ${_dateFormat.format(selectedDate!)}' : ''}',
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ]),
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
                  if (picked != null) {
                    setState(() => selectedDate = picked);
                  }
                },
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
        ]),
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
        Row(
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
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.black : Colors.grey,
                    decoration: isSelected ? TextDecoration.underline : null,
                  ),
                ),
              ),
            );
          }).toList(),
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
                      List.generate(chartLabels[selectedChart]!.length, (j) {
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
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
}
