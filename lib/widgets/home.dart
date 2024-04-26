

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Map<String, dynamic>? jsonArray;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadJsonFromAssets();
  }

  Future<void> _loadJsonFromAssets() async {
    try {
      String jsonString = await rootBundle.loadString('assets/fileList.json');
      setState(() {
        jsonArray = jsonDecode(jsonString)['wallpapersArray'];
      });
    } catch (e) {
      print('Error loading JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: jsonArray!.keys.length,
        itemBuilder: (context, index) {
          return Card.filled(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(jsonArray!.entries.elementAt(index).key),
                  ),
                ],
              ),
            );
          }
        )
    );
  }
}