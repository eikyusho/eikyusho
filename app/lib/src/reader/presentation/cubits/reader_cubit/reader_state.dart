part of 'reader_cubit.dart';

sealed class ReaderState extends Equatable {
  const ReaderState();
}

final class ReaderLoading extends ReaderState {
  @override
  List<Object> get props => [];
}

final class ReaderLoaded extends ReaderState {
  const ReaderLoaded(this.chapter, {required this.content});

  final Chapter chapter;
  final String content;

  @override
  List<Object> get props => [chapter, content];
}

final class ReaderError extends ReaderState {
  const ReaderError(this.error);

  final Exception error;

  @override
  List<Object> get props => [error];
}
