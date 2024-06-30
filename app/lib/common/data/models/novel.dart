import 'package:eikyusho_web_scraper/eikyusho_web_scraper.dart';
import 'package:equatable/equatable.dart';

import 'package:app/src/browse/data/data.dart';

class Novel extends Equatable {
  const Novel(
    this.source, {
    required this.title,
    required this.cover,
    required this.link,
    this.additionalInfo,
    this.isCompleted,
    this.extension,
    this.isInLibrary,
  });

  final String title;
  final String cover;
  final String link;
  final EikyushoSource source;
  final bool? isCompleted;
  final AvailableExtension? extension;
  final String? additionalInfo;
  final bool? isInLibrary;

  @override
  List<Object?> get props => [title, link, source];
}
