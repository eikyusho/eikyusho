part of 'discover_cubit.dart';

sealed class DiscoverState extends Equatable {
  const DiscoverState();
}

final class DiscoverLoading extends DiscoverState {
  const DiscoverLoading();

  @override
  List<Object> get props => [];
}

final class DiscoverLoaded extends DiscoverState {
  const DiscoverLoaded(this.sources) : super();

  final List<InstalledExtension> sources;

  bool get hasExtensions => sources.isNotEmpty;

  @override
  List<Object> get props => [sources];
}

final class DiscoverError extends DiscoverState {
  const DiscoverError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
