import 'package:core/core.dart';
import 'package:eikyusho_web_scraper/eikyusho_web_scraper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/src/browse/data/data.dart';
import 'package:app/src/discover/data/data.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit(this._extensionsRepository, this._discoverRepository)
      : super(const DiscoverLoading());

  final ExtensionsRepository _extensionsRepository;
  final DiscoverRepository _discoverRepository;

  Future<void> getSources({bool withLoading = false}) async {
    if (withLoading) emit(const DiscoverLoading());

    try {
      final sources = await _extensionsRepository.getSources(
        filter: SourcesFilter.onlyDiscover,
      );

      if (sources.isEmpty) {
        return emit(const DiscoverEmpty());
      }

      final selected = await _discoverRepository.getDiscoverSource();

      if (selected == null) {
        return emit(DiscoverUninitialized(sources));
      }

      emit(DiscoverLoaded(sources, selected));
    } catch (e) {
      emit(const DiscoverError('TODO: DB, Prefs, Storage'));
    }
  }

  Future<void> selectSource(AvailableExtension source) async {
    final isLoaded = state is DiscoverLoaded;
    final isUninitialized = state is DiscoverUninitialized;

    if (!isLoaded && !isUninitialized) return;

    if (isLoaded && source.uuid == (state as DiscoverLoaded).selected.uuid) {
      return;
    }

    try {
      await _discoverRepository.setDiscoverSource(source.uuid);
    } on PreferencesException catch (e) {
      emit(DiscoverError('TODO: $e'));
    }

    await getSources(withLoading: true);
  }
}
