part of 'novel_cubit.dart';

sealed class NovelState extends Equatable {
  const NovelState();
}

final class NovelLoading extends NovelState {
  @override
  List<Object> get props => [];
}

final class NovelLoaded extends NovelState {
  const NovelLoaded(this.novel, {this.isLocal = false});

  final NovelDetails novel;
  final bool isLocal;

  @override
  List<Object> get props => [novel];
}

final class NovelError extends NovelState {
  const NovelError(this.error);

  final Exception error;

  @override
  List<Object> get props => [error];
}
