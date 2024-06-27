enum NovelStatus {
  completed,
  ongoing,
  hiatus,
  dropped,
  cancelled,
  unknown;

  String get name {
    return switch (this) {
      NovelStatus.completed => 'Completed',
      NovelStatus.ongoing => 'Ongoing',
      NovelStatus.hiatus => 'Hiatus',
      NovelStatus.dropped => 'Dropped',
      NovelStatus.cancelled => 'Cancelled',
      NovelStatus.unknown => 'Unknown'
    };
  }
}
