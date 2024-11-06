import 'package:flutter/material.dart';

void main() 
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      theme: ThemeData
      (
        colorScheme: ColorScheme.fromSeed
        (
          seedColor: const Color.fromARGB(255, 51, 51, 51),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'MoneyTracker'),
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

class SignInPage extends StatelessWidget 
{
  const SignInPage({super.key});

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
            const Padding
            (
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align
              (
                alignment: Alignment.centerLeft,
                child: Text
                (
                  'Sign In',
                  style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),
            
            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField
              (
                decoration: InputDecoration
                (
                  labelText: 'E-mail',
                  enabledBorder: OutlineInputBorder
                  (
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 2),
                  ),
                  focusedBorder: OutlineInputBorder
                  (
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField
              (
                obscureText: true,
                decoration: InputDecoration
                (
                  labelText: 'Password',
                  enabledBorder: OutlineInputBorder
                  (
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 2),
                  ),
                  focusedBorder: OutlineInputBorder
                  (
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            
            TextButton
            (
              onPressed: () 
              {
                Navigator.push
                (
                  context, 
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              child: const Text
              (
                "Don't have an account? Sign Up",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),

            const SizedBox(height: 60),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox
      (
        width: 320, height: 60, 
        child: FloatingActionButton.extended
        (
          onPressed: () 
          {
            Navigator.push
            (
              context, 
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          label: const Text('CONFIRM', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 51, 51, 51),
          shape: RoundedRectangleBorder
          (
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget 
{
  const SignUpPage({super.key});

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
            const Padding
            (
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align
              (
                alignment: Alignment.centerLeft,
                child: Text
                (
                  'Sign Up',
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField
              (
                decoration: InputDecoration
                (
                  labelText: 'User name',
                  enabledBorder: OutlineInputBorder
                  (
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 2),
                  ),
                  focusedBorder: OutlineInputBorder
                  (
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField
              (
                decoration: InputDecoration
                (
                  labelText: 'E-mail',
                  enabledBorder: OutlineInputBorder
                  (
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 2),
                  ),
                  focusedBorder: OutlineInputBorder
                  (
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding
            (
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField
              (
                obscureText: true,
                decoration: InputDecoration
                (
                  labelText: 'Password',
                  enabledBorder: OutlineInputBorder
                  (
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 2),
                  ),
                  focusedBorder: OutlineInputBorder
                  (
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextButton
            (
              onPressed: () 
              {
                Navigator.push
                (
                  context, 
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
              child: const Text
              (
                'Already have an account? Sign In',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),

            const SizedBox(height: 60),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox
      (
        width: 320, height: 60, 
        child: FloatingActionButton.extended
        (
          onPressed: () 
          {
            Navigator.push
            (
              context, 
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          label: const Text
          (
            'CONFIRM', 
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 51, 51, 51),
          shape: RoundedRectangleBorder
          (
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget 
{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) 
  {
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
              const Text
              (
                'Hello, Serhii',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text
              (
                'Today 11 Oct',
                style: TextStyle(fontSize: 16, color: Colors.grey),
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
                child: const Column
                (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text
                    (
                      'Daily Expanses',
                      style: TextStyle
                      (
                        fontSize: 20, fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Row
                    (
                      children: 
                      [
                        Icon(Icons.currency_bitcoin, size: 18),
                        SizedBox(width: 5),
                        Text('Today you paid 100 UAH'),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),

              Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (index) 
                {
                  return Column
                  (
                    children: 
                    [
                      Text
                      (
                        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Container
                      (
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric
                        (
                          horizontal: 10, vertical: 5,
                        ),
                        decoration: BoxDecoration
                        (
                          color: index == 4 ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text
                        (
                          '${7 + index}',
                          style: TextStyle
                          (
                            fontSize: 16,
                            color: index == 4 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),

              const SizedBox(height: 20),

              Expanded
              (
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  [
                    Expanded
                    (
                      child: Container
                      (
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration
                        (
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 150,
                        child: const Column
                        (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: 
                          [
                            Text
                            (
                              'Public transport', 
                              style: TextStyle
                              (
                                fontSize: 18, fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('11 Oct 16:37'),
                            SizedBox(height: 10),
                            Text('20A'),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),
                    
                    Expanded
                    (
                      child: Container
                      (
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration
                        (
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 120,
                        child: const Column
                        (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: 
                          [
                            Text
                            (
                              'Food', 
                              style: TextStyle
                              (
                                fontSize: 18, fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('11 Oct 18:12'),
                            SizedBox(height: 10),
                            Text("McDonald's"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.schedule), label: "Schedule"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}