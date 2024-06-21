import 'package:equatable/equatable.dart';

class Novel extends Equatable {
  const Novel({required this.title, required this.cover, required this.link});

  final String title;
  final String cover;
  final String link;

  @override
  List<Object?> get props => [title, cover, link];
}
