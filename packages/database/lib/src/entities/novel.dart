import '../../database.dart';

part 'novel.g.dart';

@collection
class LibraryNovel {
  LibraryNovel();

  LibraryNovel.create({
    required this.title,
    required this.link,
    required this.cover,
    required this.author,
    required this.chapterCount,
    required this.status,
    required this.views,
    required this.description,
    required this.genres,
    required this.chapters,
    this.completed = false,
  });

  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String link;

  late String title;

  late String cover;

  late String author;

  late int chapterCount;

  late String status;

  late String views;

  late String description;

  late List<String> genres;

  late List<NovelChapter> chapters;

  late bool completed;

  final source = IsarLink<Extension>();
}

@embedded
class NovelChapter {
  NovelChapter();

  NovelChapter.create({
    required this.number,
    required this.title,
    required this.link,
    required this.date,
  });

  late String number;
  late String title;
  late String link;
  late String date;
  bool read = false;
  bool downloaded = false;
}
