part of 'discover_cubit.dart';

sealed class DiscoverState extends Equatable {
  const DiscoverState();
}

final class DiscoverLoading extends DiscoverState {
  const DiscoverLoading();

  @override
  List<Object> get props => [];
}

final class DiscoverEmpty extends DiscoverState {
  const DiscoverEmpty();

  @override
  List<Object> get props => [];
}

final class DiscoverUninitialized extends DiscoverState {
  const DiscoverUninitialized(this.sources);

  final List<InstalledExtension> sources;

  @override
  List<Object> get props => [sources];
}

final class DiscoverLoaded extends DiscoverState {
  const DiscoverLoaded(this.sources, this.selected);

  final List<InstalledExtension> sources;
  final EikyushoSource selected;

  @override
  List<Object?> get props => [sources, selected];
}

final class DiscoverError extends DiscoverState {
  const DiscoverError(this.error, this.sources);

  final Exception error;
  final List<AvailableExtension>? sources;

  @override
  List<Object?> get props => [error, sources];
}
