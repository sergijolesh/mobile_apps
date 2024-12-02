import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/home_page.dart';
import 'package:money_tracker/profile_page.dart';

class StatisticsPage extends StatefulWidget 
{
  final List<Map<String, String>> expenses;
  const StatisticsPage({required this.expenses, super.key});

  @override
  StatisticsPageState createState() => StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage> 
{
  DateTime selectedDate = DateTime.now();

  List<Map<String, String>> getFilteredExpenses() 
  {
    final dateFormat = DateFormat('dd.MM.yy');
    return widget.expenses.where((expense) 
    {
      return dateFormat.format(DateTime.now()) ==
          dateFormat.format(selectedDate) &&
          expense['date']!.startsWith(dateFormat.format(selectedDate));
    }).toList();
  }

  int getTotalExpenses() 
  {
    return getFilteredExpenses().fold(0, (sum, expense) 
    {
      return sum + int.parse(expense['cost']!);
    });
  }

  Map<String, List<Map<String, String>>> getCategoryExpenses() 
  {
    final filtered = getFilteredExpenses();
    final Map<String, List<Map<String, String>>> categoryDetails = {};

    for (var expense in filtered) 
    {
      final String category = expense['category']!;
      if (!categoryDetails.containsKey(category)) 
      {
        categoryDetails[category] = [];
      }
      categoryDetails[category]!.add(expense);
    }

    return categoryDetails;
  }

  @override
  Widget build(BuildContext context) 
  {
    final categoryExpenses = getCategoryExpenses();

    return Scaffold
    (
      backgroundColor: Colors.white,
      body: SafeArea
      (
        child: Padding
        (
          padding: const EdgeInsets.all(16),
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              ElevatedButton
              (
                style: ElevatedButton.styleFrom
                (
                  backgroundColor: Colors.blue[200],
                  foregroundColor: Colors.black,
                ),
                onPressed: () async 
                {
                  final DateTime? picked = await showDatePicker
                  (
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) 
                  {
                    setState(() 
                    {
                      selectedDate = picked;
                    });
                  }
                },
                child: Text(DateFormat('dd.MM.yyyy').format(selectedDate)),
              ),

              const SizedBox(height: 15),

              Container
              (
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration
                (
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column
                (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Row
                    (
                      children:
                      [
                        Text
                        (
                          'Total Expenses: ${getTotalExpenses()} UAH',
                          style: const TextStyle
                          (
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

              Expanded
              (
                child: ListView
                (
                  children: categoryExpenses.entries.map((entry)
                  {
                    final category = entry.key;
                    final expenses = entry.value;
                    final totalCost = expenses.fold
                    (
                      0,
                      (sum, item) => sum + int.parse(item['cost']!),
                    );

                    return Card
                    (
                      shape: RoundedRectangleBorder
                      (
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ExpansionTile
                      (
                        shape: const RoundedRectangleBorder
                        (
                          side: BorderSide.none,
                        ),
                        title: Text
                        (
                          '$category - $totalCost UAH',
                          style: const TextStyle
                          (
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: expenses.map((expense) 
                        {
                          return ListTile
                          (
                            title: Text(expense['description'] ?? ''),
                            subtitle: Text('Cost: ${expense['cost']} UAH'),
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
      bottomNavigationBar: BottomNavigationBar
      (
        items: const 
        [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem
          (
            icon: Icon(Icons.bar_chart), label: 'Statistics'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (index) 
        {
          if (index == 0) 
          {
            Navigator.push
            (
              context,
              MaterialPageRoute
              (
                builder: (context) => const HomePage(),
              ),
            );
          }
          else if (index == 2) 
          {
            Navigator.push
            (
              context,
              MaterialPageRoute
              (
                builder: (context) => const ProfilePage(),
              ),
            );
          }
        },
      ),
    );
  }
}
