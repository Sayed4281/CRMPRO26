import 'package:flutter/material.dart';
import 'main_layout.dart';
void main() {
  runApp(MyApp());
}

// Root widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'leads',
      home: LeadsScreen(),
    );
  }
}

  // Search bar
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search by name or ID',
        suffixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
// Stateful widget to manage selected filter
class LeadsScreen extends StatefulWidget {
  @override
  _LeadsScreenState createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  // List of all leads
  List<Map<String, String>> allLeads = List.generate(10, (index) {
    return {
      'slNo': (index + 1).toString().padLeft(2, '0'),
      'name': 'Dr. Patel',
      'leadID': 'LID-204${index + 1}',
      'product': 'CT Scanner',
      'leadStatus': index % 3 == 0 ? 'Bad Lead' : 'Discussion',
      'status': index % 2 == 0 ? 'Demo Completed' : 'Demo Scheduled',
      'expectedClosingDate': '2024-07-21',
    };
  });

  // Filter options
  List<String> filters = ['All', 'Discussion', 'Quotation Submitted', 'Waiting for Demo', 'Demo Scheduled', 'Demo Completed'];

  // Currently selected filter
  String selectedFilter = 'All';

  // This function returns only the leads matching the selected filter
  List<Map<String, String>> get filteredLeads {
    if (selectedFilter == 'All') {
      return allLeads;
    } else {
      return allLeads.where((lead) =>
      lead['leadStatus'] == selectedFilter || lead['status'] == selectedFilter
      ).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F6FC),
      body: Row(
        children: [

          // Main content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dashboard > Leads', style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 20),
                    _buildSummaryCards(),
                    SizedBox(height: 20),
                    _buildFilterChips(),
                    SizedBox(height: 10),
                    _buildSearchBar(),
                    SizedBox(height: 10),
                    _buildTableHeader(),
                    _buildLeadsTable(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Summary cards (Total, Bad, Good, etc.)
  Widget _buildSummaryCards() {
    return Row(
      children: [
        _summaryCard('Total', '${allLeads.length} Leads'),
        SizedBox(width: 10),
        _summaryCard('Won', '${allLeads.where((l) => l['leadStatus'] == 'Bad Lead').length}'),
        _summaryCard('Lost', '${allLeads.length} Leads'),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _summaryCard(String title, String count) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            Text(count, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
  

  // Horizontal filter chips
  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final bool isSelected = selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  selectedFilter = filter;
                });
              },
              selectedColor: Colors.deepPurple,
              labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          );
        }).toList(),
      ),
    );
  }


  // Table headers
  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[200],
      child: Row(
        children: [
          _tableHeader('SL.NO'),
          _tableHeader('Name'),
          _tableHeader('Lead ID'),
          _tableHeader('Status'),
          _tableHeader('Lead Status'),
        ],
      ),
    );
  }

  Widget _tableHeader(String title) {
    return Expanded(
      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  // Table rows based on filtered leads
  Widget _buildLeadsTable() {
    if (filteredLeads.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('No leads found.'),
      );
    }

    return Column(
      children: filteredLeads.map((lead) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              _tableCell(lead['slNo']!),
              _tableCell(lead['name']!),
              _tableCell(lead['leadID']!),
              _tableCell(lead['status']!),
              _tableCell(lead['leadStatus']!),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _tableCell(String value) {
    return Expanded(child: Text(value));
  }
}
