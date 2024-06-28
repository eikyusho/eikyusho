part of 'novel_cubit.dart';

sealed class NovelState extends Equatable {
  const NovelState({this.isLocal = false});

  final bool isLocal;

  @override
  List<Object> get props => [isLocal];
}

final class NovelLoading extends NovelState {}

final class NovelInfoLoaded extends NovelState {
  const NovelInfoLoaded(this.novel);

  final NovelDetails novel;

  @override
  List<Object> get props => [novel, isLocal];
}

final class NovelChaptersLoaded extends NovelState {
  const NovelChaptersLoaded(this.novel, this.chapters);

  final NovelDetails novel;
  final List<Chapter> chapters;

  @override
  List<Object> get props => [novel, chapters, isLocal];
}

final class NovelError extends NovelState {
  const NovelError(this.error);

  final Exception error;

  @override
  List<Object> get props => [error, isLocal];
}
