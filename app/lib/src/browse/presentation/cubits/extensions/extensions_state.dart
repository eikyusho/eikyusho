part of 'extensions_cubit.dart';

sealed class ExtensionsState extends Equatable {
  const ExtensionsState();
}

final class ExtensionsLoading extends ExtensionsState {
  const ExtensionsLoading({this.isRefreshing = false});

  final bool isRefreshing;

  @override
  List<Object> get props => [isRefreshing];
}

final class ExtensionsFailure extends ExtensionsState {
  const ExtensionsFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class ExtensionsLoaded extends ExtensionsState {
  const ExtensionsLoaded(this.available, this.outdated);

  final List<Extension> available;
  final List<InstalledExtension> outdated;

  bool get hasOutdated => outdated.isNotEmpty;

  @override
  List<Object> get props => [available, outdated];
}
