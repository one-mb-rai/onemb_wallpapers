import 'package:flutter/material.dart';
import 'package:onemb_wallpapers/widgets/home.dart';

void main() {
  runApp(const ONEMBWallpapersApp());
}

class ONEMBWallpapersApp extends StatelessWidget {
  const ONEMBWallpapersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ONEMB Wallpapers',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Wallpaper Categories'),
    );
  }
}
