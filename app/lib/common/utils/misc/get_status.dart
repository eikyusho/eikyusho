import 'package:core/core.dart';

NovelStatus getStatus(String status) {
  return switch (status) {
    'completed' => NovelStatus.completed,
    'ongoing' => NovelStatus.ongoing,
    'hiatus' => NovelStatus.hiatus,
    'dropped' => NovelStatus.dropped,
    'cancelled' => NovelStatus.cancelled,
    _ => NovelStatus.unknown
  };
}
