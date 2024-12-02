import 'package:flutter/material.dart';
import 'package:money_tracker/home_page.dart';
import 'package:money_tracker/sign_in_page.dart';
import 'package:money_tracker/sign_up_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async 
{
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await getLoginStatus();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

Future<bool> getLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

class MyApp extends StatelessWidget
{
  const MyApp({required this.isLoggedIn, super.key});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      theme: ThemeData
      (
        colorScheme: ColorScheme.fromSeed
        (
          seedColor: const Color.fromARGB(255, 51, 51, 51),
        ),
        useMaterial3: true,
      ),
      home: isLoggedIn ? const HomePage() : 
                         const MyHomePage(title: 'MoneyTracker'),
    );
  }
}

class MyHomePage extends StatefulWidget 
{
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
{
  void _incrementCounter() 
  {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Center
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>
          [
            Image.asset('assets/logo.png', width: 300, height: 210),
            SizedBox
            (
              width: 300, height: 60,
              child: FloatingActionButton.extended
              (
                onPressed: () 
                {
                  Navigator.push
                  (
                    context, 
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                  );
                },
                label: const Text
                (
                  'SIGN IN', 
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: const Color.fromARGB(255, 51, 51, 51),
                shape: RoundedRectangleBorder
                (
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox
            (
              width: 300, height: 60,
              child: FloatingActionButton.extended
              (
                onPressed: ()
                {
                  Navigator.push
                  (
                    context, 
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                label: const Text
                (
                  'SIGN UP', 
                  style: TextStyle(color: Colors.white),
                  ),
                backgroundColor: const Color.fromARGB(255, 51, 51, 51),
                shape: RoundedRectangleBorder
                (
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
