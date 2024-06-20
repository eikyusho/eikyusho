part of 'browse_cubit.dart';

sealed class BrowseState extends Equatable {
  const BrowseState();
}

final class BrowseLoading extends BrowseState {
  const BrowseLoading({this.isRefreshing = false});

  final bool isRefreshing;

  @override
  List<Object> get props => [isRefreshing];
}

final class BrowseFailure extends BrowseState {
  const BrowseFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class BrowseLoaded extends BrowseState {
  const BrowseLoaded(this.sources);

  final List<InstalledExtension> sources;

  @override
  List<Object> get props => [sources];
}
