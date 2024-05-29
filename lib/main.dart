import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future getPosts() async {
    const url = "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return;
    }
    debugPrint("Something happened");
    debugPrint(response.body);
  }

  Future createPost() async {
    const url = "https://jsonplaceholder.typicode.com/posts";
    final Map<String, dynamic> postData = {
      "title": "Title One",
      "body": "This is the first testing post",
      "userId": 1,
    };
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(postData),
    );
    if (response.statusCode == 201) {
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return;
    }
    debugPrint("Something went wrong");
    debugPrint(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Testing"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: createPost,
          child: const Text("Get Posts"),
        ),
      ),
    );
  }
}
