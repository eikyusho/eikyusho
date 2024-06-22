import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/src/browse/data/data.dart';

part 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit(this._repository) : super(const BrowseLoading());

  final ExtensionsRepository _repository;

  Future<void> getSources() async {
    emit(const BrowseLoading());

    final sources = await _repository.getSources(
      filter: SourcesFilter.none,
    );

    emit(BrowseLoaded(sources));
  }

  Future<void> getDisabledSources() async {
    emit(const BrowseLoading());

    final sources = await _repository.getSources(
      filter: SourcesFilter.onlyDisabled,
    );

    emit(BrowseLoaded(sources));
  }

  Future<void> enableExtension(InstalledExtension extension) async {
    await _repository.enableExtension(extension.id);

    await getSources();
  }

  Future<void> disableExtension(InstalledExtension extension) async {
    await _repository.disableExtension(extension.id);

    await getSources();
  }

  Future<void> enableDiscoverExtension(InstalledExtension extension) async {
    await _repository.enableDiscoverExtension(extension.id);

    await getSources();
  }

  Future<void> disableDiscoverExtension(InstalledExtension extension) async {
    await _repository.disableDiscoverExtension(extension.id);

    await getSources();
  }

  Future<void> uninstallExtension(InstalledExtension extension) async {
    await _repository.uninstallExtension(extension);

    await getSources();
  }
}
