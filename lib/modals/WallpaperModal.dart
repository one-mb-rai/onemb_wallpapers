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