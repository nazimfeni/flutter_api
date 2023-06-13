import 'dart:convert'; // for JSON decoding
import 'package:flutter/material.dart'; //for Flutter UI components
import 'package:http/http.dart' as http; // for making HTTP requests

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Rest API Call"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final name = user['name']['first'];
          final email = user['email'];
          final imageurl = user['picture']['thumbnail'];
          return ListTile(
            leading: ClipRRect(child: Image.network(imageurl),
                borderRadius: BorderRadius.circular(100),
            ),
            title: Text(name),
            subtitle: Text(email),
          );
        },
      ),
      //creating button
      floatingActionButton: FloatingActionButton(
        onPressed: fetchusers,
      ),
    );
  }

  void fetchusers() async {
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    print("fetch user completed");
  }
}
