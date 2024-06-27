import 'package:eikyusho_web_scraper/eikyusho_web_scraper.dart';
import 'package:equatable/equatable.dart';

class Novel extends Equatable {
  const Novel(
    this.source, {
    required this.title,
    required this.cover,
    required this.link,
  });

  final String title;
  final String cover;
  final String link;
  final EikyushoSource source;

  @override
  List<Object?> get props => [title, link, source];
}
