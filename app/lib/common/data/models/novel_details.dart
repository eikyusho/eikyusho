import 'package:app/common/data/models/novel.dart';

class NovelDetails extends Novel {
  const NovelDetails(
    super.source, {
    required super.title,
    required super.cover,
    required super.link,
    required this.author,
    required this.chapters,
    required this.status,
    required this.views,
    required this.description,
    required this.genres,
  });

  final String author;
  final int chapters;
  final String status;
  final String views;
  final String description;
  final List<String> genres;
}
