class Formatter {
  static String viewCount(int viewCount) {
    return switch (viewCount) {
      < 10000 => viewCount.toString(),
      < 1000000 => '${(viewCount / 1000).toStringAsFixed(0)}K',
      _ => '${(viewCount / 1000000).toStringAsFixed(0)}M',
    };
  }
}
