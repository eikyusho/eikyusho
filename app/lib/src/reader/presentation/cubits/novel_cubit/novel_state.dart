part of 'novel_cubit.dart';

sealed class NovelState extends Equatable {
  const NovelState({this.isLocal = false});

  final bool isLocal;

  @override
  List<Object> get props => [isLocal];
}

final class NovelLoading extends NovelState {}

final class NovelLoaded extends NovelState {
  const NovelLoaded(
    this.novel, {
    this.chapters = const [],
    this.isLoading = false,
  });

  final NovelDetails novel;
  final List<Chapter> chapters;
  final bool isLoading;

  @override
  List<Object> get props => [novel, chapters, isLocal, isLoading];
}

final class NovelError extends NovelState {
  const NovelError(this.error);

  final Exception error;

  @override
  List<Object> get props => [error, isLocal];
}
