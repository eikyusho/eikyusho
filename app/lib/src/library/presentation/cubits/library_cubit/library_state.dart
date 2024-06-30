part of 'library_cubit.dart';

sealed class LibraryState extends Equatable {
  const LibraryState();
}

final class LibraryLoading extends LibraryState {
  @override
  List<Object> get props => [];
}

final class LibraryLoaded extends LibraryState {
  const LibraryLoaded(this.novels);

  final List<Novel> novels;

  @override
  List<Object> get props => [novels];
}

final class LibraryError extends LibraryState {
  const LibraryError(this.error);

  final Exception error;

  @override
  List<Object> get props => [error];
}
