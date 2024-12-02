import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:money_tracker/home_page.dart';
import 'package:money_tracker/profile_page.dart';

class StatisticsPage extends StatefulWidget {
  final String apiBaseUrl;
  const StatisticsPage({required this.apiBaseUrl, super.key});

  @override
  StatisticsPageState createState() => StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage> {
  DateTime selectedDate = DateTime.now();
  List<Map<String, dynamic>> categoryData = [];
  int totalExpenses = 0;

  Future<void> fetchExpenseData() async {
    final date = DateFormat('yyyy-MM-dd').format(selectedDate);
    final url = Uri.parse('${widget.apiBaseUrl}/api/get-expenses?date=$date');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          totalExpenses = data['total'] as int;
          categoryData = (data['categories'] as List)
              .map((category) => category as Map<String, dynamic>)
              .toList();
        });
      } else {
        throw Exception('Failed to load expense data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchExpenseData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[200],
                  foregroundColor: Colors.black,
                ),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                    await fetchExpenseData();
                  }
                },
                child: Text(DateFormat('dd.MM.yyyy').format(selectedDate)),
              ),

              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total Expenses: $totalExpenses UAH',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Expanded(
                child: categoryData.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : PieChart(
                        PieChartData(
                          sections: categoryData.map((category) {
                            final totalCost = category['data'].fold(0, (sum, item) => sum + item['cost']);
                            final percentage = (totalCost / totalExpenses) * 100;
                            return PieChartSectionData(
                              title:
                                  '${category['category']} (${percentage.toStringAsFixed(1)}%)',
                              value: totalCost.toDouble(),
                              color: Colors.primaries[
                                  categoryData.indexOf(category) %
                                      Colors.primaries.length],
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
              ),

              const SizedBox(height: 15),

              Expanded(
                child: ListView(
                  children: categoryData.map((category) {
                    final categoryName = category['category'];
                    final totalCost = category['data']
                        .fold(0, (sum, item) => sum + item['cost']);
                    final percentage =
                        (totalCost / totalExpenses) * 100;

                    return Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ExpansionTile(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        title: Text(
                          '$categoryName - $totalCost UAH',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: (category['data'] as List).map<Widget>((item) {
                          return ListTile(
                            title: Text(item['description']),
                            subtitle: Text('Cost: ${item['cost'].toString()} UAH'),
                          );
                        }).toList(),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Statistics'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          }
        },
      ),
    );
  }
}
