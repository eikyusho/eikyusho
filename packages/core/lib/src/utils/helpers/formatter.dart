class Formatter {
  static String viewCount(String views) {
    final count = int.tryParse(views);

    if (count == null) {
      return views.toUpperCase();
    }

    return switch (count) {
      < 10000 => count.toString(),
      < 1000000 => '${(count / 1000).toStringAsFixed(0)}K',
      _ => '${(count / 1000000).toStringAsFixed(0)}M',
    };
  }
}
