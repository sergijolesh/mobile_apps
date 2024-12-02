import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/profile_page.dart';
import 'package:money_tracker/stat_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class HomePage extends StatefulWidget 
{
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> 
{
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  bool _isConnected = true;
  bool _isDialogOpen = false;
  bool isDisabled = false;
  @override
  void initState() 
  {
    super.initState();
    isConnected();
    _getUserName();
    _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (results.contains(ConnectivityResult.none)) {
        if (!_isDialogOpen) {
          _isDialogOpen = true;
          print('no conction (())');
        
          _isDialogOpen = false;
        }
        else
        {
          print('conection (())');
        }
        _isConnected = false;
      } else {
        print('conection (())');
        if (!_isConnected) {
          print('conection (())');
          _isConnected = true;
         
        }
      }
    });
  }

  Future<bool> isConnected() async 
  {
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult[0] == ConnectivityResult.none) 
    {
      ScaffoldMessenger.of(context).showSnackBar
      (
        const SnackBar
        (
          duration: Duration(seconds: 60),
          content: Text
          (
            'No connection', 
            style: TextStyle(color: Color.fromARGB(255, 255, 190, 70))
          )
        ),
      );
    }
    return connectivityResult != ConnectivityResult.none;
  }

  final List<Map<String, String>> expenses = [];
  final List<Color> colors = [];
  int totalExpenses = 0;

  final List<Color> colorsList = [
    const Color.fromARGB(255, 246, 149, 142),
    const Color.fromARGB(255, 246, 180, 142),
    const Color.fromARGB(255, 246, 227, 242),
    const Color.fromARGB(255, 187, 223, 246),
    const Color.fromARGB(255, 205, 141, 242),
    const Color.fromARGB(255, 255, 225, 185),
  ];

  final List<String> categories = ['Food', 'Transport', 'Groceries'];

  void _showExpenseDialog({int? index}) 
  {
    final TextEditingController costController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    String selectedCategory = categories[0];

    if (index != null) 
    {
      costController.text = expenses[index]['cost'] ?? '';
      descriptionController.text = expenses[index]['description'] ?? '';
      selectedCategory = expenses[index]['category'] ?? categories[0];
    }

    showDialog
    (
      context: context,
      builder: (BuildContext context) 
      {
        return AlertDialog(
          title: Text(index == null ? 'Add Expense' : 'Edit Expense'),
          content: Column
          (
            mainAxisSize: MainAxisSize.min,
            children: 
            [
              TextField
              (
                controller: costController,
                decoration: const InputDecoration
                ( 
                  labelText: 'Enter amount (UAH)',
                ),
                keyboardType: TextInputType.number,
              ),
              
              const SizedBox(height: 10),

              TextField
              (
                controller: descriptionController,
                decoration: const InputDecoration
                (
                  labelText: 'Enter description',
                ),
              ),
              
              const SizedBox(height: 10),
             
              DropdownButtonFormField<String>
              (
                value: selectedCategory,
                onChanged: (String? newValue) 
                {
                  setState(() 
                  {
                    selectedCategory = newValue!;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String value) 
                {
                  return DropdownMenuItem<String>
                  (
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration
                (
                  contentPadding: EdgeInsets.symmetric
                  (
                    horizontal: 15, vertical: 10,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
          actions: 
          [
            TextButton
            (
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton
            (
              onPressed: () 
              {
                final int? cost = int.tryParse(costController.text);
                if (cost != null) 
                {
                  setState(() 
                  {
                    final String formattedDate = DateFormat('dd.MM.yy HH:mm').format(DateTime.now());
                    if (index == null) 
                    {
                      expenses.add
                      ({
                        'cost': cost.toString(),
                        'description': descriptionController.text,
                        'category': selectedCategory,
                        'date': formattedDate,
                      });
                      colors.add(_getRandomColor());
                      totalExpenses += cost;
                    } 
                    else 
                    {
                      totalExpenses -= int.parse(expenses[index]['cost']!);
                      expenses[index] = {
                        'cost': cost.toString(),
                        'description': descriptionController.text,
                        'category': selectedCategory, // Update the category
                        'date': formattedDate,
                      };
                      totalExpenses += cost;
                    }
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text(index == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  Color _getRandomColor() 
  {
  final random = Random();
  
  if (colors.isEmpty) 
  {
    return colorsList[random.nextInt(colorsList.length)];
  }

  Color newColor;
  final Color lastColor = colors.last;

  do 
  {
    newColor = colorsList[random.nextInt(colorsList.length)];
  } while (newColor == lastColor);

  return newColor;
  }

  void _deleteExpense(int index) 
  {
    setState(() 
    {
      totalExpenses -= int.parse(expenses[index]['cost']!);
      expenses.removeAt(index);
      colors.removeAt(index);
    });
  }

  String? username;

  

  Future<void> _getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) 
  {
    final String currentDate = DateFormat('EEE dd MMM').format(DateTime.now());

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
              Text
              (
                'Hello, $username',
                style: const TextStyle
                (
                  fontSize: 28, fontWeight: FontWeight.bold,
                ),
              ),
              Text
              (
                currentDate,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              
              const SizedBox(height: 20),
              
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
                    const Text
                    (
                      'Daily Expenses',
                      style: TextStyle
                      (
                        fontSize: 20, fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row
                    (
                      children: 
                      [
                        const SizedBox(width: 5),
                        Text('\$ Total spent: $totalExpenses UAH'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              
              Expanded
              (
                child: GridView.builder
                (
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
                  (
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: expenses.length,
                  itemBuilder: (context, index) 
                  {
                    final expense = expenses[index];
                    final Color color = (index < colors.length) ? 
                                         colors[index] : Colors.grey;

                    return GestureDetector
                    (
                      onTap: () 
                      {
                        showDialog
                        (
                          context: context,
                          builder: (BuildContext context) 
                          {
                            return AlertDialog(
                              title: const Text('Expense Options'),
                              content: const Text
                              (
                                'What would you like to do with this expense?',
                              ),
                              actions: 
                              [
                                TextButton
                                (
                                  onPressed: () 
                                  {
                                    Navigator.of(context).pop();
                                    _showExpenseDialog(index: index);
                                  },
                                  child: const Text('Edit'),
                                ),
                                TextButton
                                (
                                  onPressed: ()
                                  {
                                    Navigator.of(context).pop();
                                    _deleteExpense(index);
                                  },
                                  child: const Text('Delete'),
                                ),
                                TextButton
                                (
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container
                      (
                        height: 40,
                        decoration: BoxDecoration
                        (
                          color: color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding
                        (
                          padding: const EdgeInsets.all(8),
                          child: Column
                          (
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: 
                            [
                              Text
                              (
                                '${expense['category']}', 
                                style: const TextStyle
                                (
                                  fontWeight: FontWeight.bold, fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text('${expense['cost']} UAH'),
                              const SizedBox(height: 5),
                              Text('${expense['description']}'),
                              const SizedBox(height: 5),
                              Text('${expense['date']}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
            icon: Icon(Icons.bar_chart), label: 'Statistics',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (index) 
        {
          if (index == 1) 
          {
            Navigator.push
            (
              context,
              MaterialPageRoute
              (
                builder: (context) => StatisticsPage(expenses: expenses),
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
      floatingActionButton: FloatingActionButton
      (
        backgroundColor: Colors.purple[100],
        onPressed: _showExpenseDialog,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
