import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class WallpapersSetPage extends StatefulWidget {
  const WallpapersSetPage({super.key, required this.wallpapersUrl});
  final String wallpapersUrl;

  @override
  State<WallpapersSetPage> createState() => _WallpapersPageState();
}

class _WallpapersPageState extends State<WallpapersSetPage> {
  bool _isLoading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void showLoading() {
    Navigator.pop(context);
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }


  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await AsyncWallpaper.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
    });
  }

  void showBottomSheet() {
      scaffoldKey.currentState!.showBottomSheet(
        elevation: 5,
        enableDrag: true,
            (context) => SizedBox(
              height: 250,
              width: double.infinity,
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        setWallpaperFromFileHome(widget.wallpapersUrl);
                      },
                      child: const Text('Home Screen'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        setWallpaperFromFileLock(widget.wallpapersUrl);
                      },
                      child: const Text('Lock Screen'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        setWallpaperFromFileBoth(widget.wallpapersUrl);
                      },
                      child: const Text('Home & Lock Screen'),
                    ),
                  ],
                )
              )
            ),
      );
  }

  Future<void> setWallpaperFromFileHome(url) async {
    showLoading();
    String result;
    var file = await DefaultCacheManager().getSingleFile(url);
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
        goToHome: false,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
      hideLoading();
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    if (!mounted) return;
  }

  Future<void> setWallpaperFromFileLock(url) async {
    showLoading();
    String result;
    var file = await DefaultCacheManager().getSingleFile(url);
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
        goToHome: false,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
      hideLoading();
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    if (!mounted) return;

    setState(() {
    });
  }

  Future<void> setWallpaperFromFileBoth(url) async {
    showLoading();
    String result;
    var file = await DefaultCacheManager().getSingleFile(url);
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
        goToHome: false,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
      hideLoading();
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        floatingActionButton:  FloatingActionButton.extended(label: const Text("Set Wallpaper"), onPressed: _isLoading ? null : () {
          showBottomSheet();
        },),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        
        body: Stack(
          children: [
            InkWell(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.network(
                  widget.wallpapersUrl,
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child; // Image is loaded
                    return const Center(child: CircularProgressIndicator()); // Display loader while loading
                  },
                ),
              )
            ),
            _isLoading
                ? Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
                : const SizedBox(),
        ])
    );
  }
}