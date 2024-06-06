part of 'extensions_cubit.dart';

sealed class ExtensionsState extends Equatable {
  const ExtensionsState();
}

final class ExtensionsInitial extends ExtensionsState {
  @override
  List<Object> get props => [];
}

final class ExtensionsLoading extends ExtensionsState {
  @override
  List<Object> get props => [];
}

final class ExtensionsLoaded extends ExtensionsState {
  const ExtensionsLoaded(this.available, this.outdated);

  final List<Extension> available;
  final List<InstalledExtension> outdated;

  @override
  List<Object> get props => [available, outdated];
}
