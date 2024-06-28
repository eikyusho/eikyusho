import 'package:app/common/data/models/novel.dart';
import 'package:equatable/equatable.dart';

class Chapter extends Equatable {
  const Chapter(
    this.novel, {
    required this.number,
    required this.title,
    required this.link,
    required this.date,
  });

  final int number;
  final String title;
  final String link;
  final String date;
  final Novel novel;

  @override
  List<Object?> get props => [title, number, novel, link];
}
