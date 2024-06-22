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

final class BrowseError extends BrowseState {
  const BrowseError(this.error);

  final Exception error;

  @override
  List<Object> get props => [error];
}

final class BrowseLoaded extends BrowseState {
  const BrowseLoaded(this.sources);

  final List<InstalledExtension> sources;

  @override
  List<Object> get props => [sources];
}
