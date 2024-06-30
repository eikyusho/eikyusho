import 'package:equatable/equatable.dart';

class Collection extends Equatable {
  const Collection({
    required this.title,
    required this.description,
    required this.tags,
  });

  final String title;
  final String description;
  final List<String> tags;

  @override
  List<Object?> get props => [title, description];
}
