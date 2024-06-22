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

  List<AvailableExtension>? sources;

  Future<void> getSources({bool withLoading = false}) async {
    if (withLoading) emit(const DiscoverLoading());

    try {
      final sources = await _extensionsRepository.getSources(
        filter: SourcesFilter.onlyDiscover,
      );

      if (sources.isNotEmpty) this.sources = sources;

      if (sources.isEmpty) {
        return emit(const DiscoverEmpty());
      }

      final selected = await _discoverRepository.getDiscoverSource();

      if (selected == null) {
        return emit(DiscoverUninitialized(sources));
      }

      emit(DiscoverLoaded(sources, selected));
    } on Exception catch (e) {
      emit(DiscoverError(e, sources));
    }
  }

  Future<bool> selectSource(AvailableExtension source) async {
    final isLoaded = state is DiscoverLoaded;
    final isUninitialized = state is DiscoverUninitialized;

    if (!isLoaded && !isUninitialized) return false;

    if (isLoaded && source.uuid == (state as DiscoverLoaded).selected.uuid) {
      return false;
    }

    try {
      await _discoverRepository.setDiscoverSource(source.uuid);
    } on PreferencesException catch (e) {
      emit(DiscoverError(e, sources));
    }

    await getSources(withLoading: true);

    return true;
  }
}
