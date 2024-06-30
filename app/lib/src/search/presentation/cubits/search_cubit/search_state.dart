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

final class SearchEmpty extends SearchState {
  const SearchEmpty({required this.showTip});

  final bool showTip;

  @override
  List<Object> get props => [showTip];
}

final class SearchLoaded extends SearchState {
  const SearchLoaded(this.novels, {this.showTip = false});

  final List<Novel> novels;
  final bool showTip;

  @override
  List<Object> get props => [novels, showTip];
}

final class SearchError extends SearchState {
  const SearchError(this.error);

  final Exception error;

  @override
  List<Object> get props => [error];
}
