enum NovelStatus {
  completed,
  ongoing,
  hiatus,
  dropped,
  unknown;

  String get name {
    switch (this) {
      case NovelStatus.completed:
        return 'Completed';
      case NovelStatus.ongoing:
        return 'Ongoing';
      case NovelStatus.hiatus:
        return 'Hiatus';
      case NovelStatus.dropped:
        return 'Dropped';
      case NovelStatus.unknown:
        return 'Unknown';
    }
  }
}
