part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();
}

final class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

final class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

final class SearchLoaded extends SearchState {
  const SearchLoaded(this.novels, {this.isLocalSearch = false});

  final bool isLocalSearch;
  final List<Novel> novels;

  @override
  List<Object> get props => [novels, isLocalSearch];
}

final class SearchError extends SearchState {
  const SearchError(this.error);

  final Exception error;

  @override
  List<Object> get props => [error];
}
