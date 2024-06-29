import 'package:equatable/equatable.dart';

import 'package:app/common/data/models/novel.dart';

class Chapter extends Equatable {
  const Chapter(
    this.novel, {
    required this.number,
    required this.title,
    required this.link,
    required this.date,
  });

  final String number;
  final String title;
  final String link;
  final String date;
  final Novel novel;

  @override
  List<Object?> get props => [title, number, novel, link];
}
