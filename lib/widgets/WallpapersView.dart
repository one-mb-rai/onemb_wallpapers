import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onemb_wallpapers/widgets/WallpaperSet.dart';

import '../modals/WallpaperModal.dart';

class WallpapersViewPage extends StatefulWidget {
  const WallpapersViewPage({super.key, required this.title, required this.wallpapersList});
  final String title;
  final List<Wallpaper> wallpapersList;

  @override
  State<WallpapersViewPage> createState() => _WallpapersPageState();
}

class _WallpapersPageState extends State<WallpapersViewPage> {


  @override
  void initState() {
    super.initState();
    print(widget.wallpapersList);
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
                childAspectRatio: 0.6
          ),
          itemCount: widget.wallpapersList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      WallpapersSetPage(wallpapersUrl: widget.wallpapersList.elementAt(index).url)),
                );
              },
              child: SizedBox(
                height: 300,
                child: Card.filled(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          widget.wallpapersList.elementAt(index).url,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}