

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Wallpaper {
  final String name;
  final String url;

  const Wallpaper(this.name, this.url);

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final url = json['url'] as String;
    return Wallpaper(name, url);
  }
}

class WallpapersArray {
  final List<Wallpaper> wallpapers;

  const WallpapersArray(this.wallpapers);
}

class _MyHomePageState extends State<MyHomePage> {

  final jsonArray = <Map<String, List<Wallpaper>>>[];
  List<String> keys = [];


  @override
  void initState() {
    super.initState();
    _loadJsonFromAssets();
  }

  Future<void> _loadJsonFromAssets() async {
    try {
      String jsonString = await rootBundle.loadString('assets/fileList.json');
      final jsonData = jsonDecode(jsonString);
      if (jsonData is Map<String, dynamic>) {
        if (jsonData.containsKey('wallpapersArray')) {
          final wallpapersArray = jsonData['wallpapersArray'] as Map<String, dynamic>;
          wallpapersArray.forEach((key, value) {
            if (value is List<dynamic>) {
              final processedWallpapers = value.map((wallpaperJson) => Wallpaper.fromJson(wallpaperJson)).toList();
              jsonArray.add({key: processedWallpapers});
            }
          });
          setState(() {
            keys = wallpapersArray.keys.toList();
          });
        }
      }
    } finally {
      setState(() {}); // Update UI regardless of success or failure
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
        title: Text(widget.title, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: keys.length,
        itemBuilder: (context, index) {
          // String imageUrl = jsonArray!.entries.elementAt(index).value;
          return InkWell(
                onTap: () {

                },
                child: SizedBox(
                  height: 10,
                  child: Card.filled(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            jsonArray.elementAt(index).values.first.elementAt(0).url,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          keys.elementAt(index).toUpperCase().split("_").join(" "),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white70, fontSize: 26, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
              ),
            );
          }
        )
    );
  }
}