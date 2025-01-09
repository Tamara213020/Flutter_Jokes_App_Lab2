import 'package:flutter/material.dart';
import '../services/api_services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> jokeTypes = [];

  @override
  void initState() {
    super.initState();
    fetchJokeTypes();
  }

  void fetchJokeTypes() async {
    try {
      final types = await ApiService.fetchJokeTypes();
      setState(() {
        jokeTypes = types;
      });
    } catch (e) {
      print("Error fetching joke types: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Joke Types"),
        actions: [
          IconButton(
            icon: Row(
              children: [
                Icon(Icons.lightbulb),
                SizedBox(width: 8),
                Text("Joke of the Day"),
              ],
            ),
            onPressed: () async {
              final joke = await ApiService.fetchRandomJoke();
              Navigator.pushNamed(context, "/random", arguments: joke);
            },
          ),
        ],
      ),
      body: jokeTypes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: jokeTypes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/jokes",
                  arguments: jokeTypes[index],
                );
              },
              child: Card(
                color: Colors.deepPurpleAccent,
                child: Center(
                  child: Text(
                    jokeTypes[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
