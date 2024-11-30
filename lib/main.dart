import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/jokes_screen.dart';
import 'screens/random_joke_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/jokes': (context) => JokesScreen(
          jokeType: ModalRoute.of(context)!.settings.arguments as String,
        ),
        '/random': (context) => RandomJokeScreen(
          joke: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
        ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: const Text('Go to Home Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/jokes', arguments: 'funny');
              },
              child: const Text('Go to Jokes Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/random', arguments: {'joke': 'Random joke here!'});
              },
              child: const Text('Go to Random Joke Screen'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
