import 'package:eikyusho_web_scraper/eikyusho_web_scraper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';

part 'discover_content_state.dart';

class DiscoverContentCubit extends Cubit<DiscoverContentState> {
  DiscoverContentCubit() : super(const DiscoverContentInitial());

  Future<void> load(EikyushoSource source) async {
    emit(const DiscoverContentInitial());

    try {
      await _fetchSpotlights(source);
      await _fetchMostPopular(source);
      await _fetchRecentlyUpdated(source);
    } on Exception catch (e) {
      emit(DiscoverContentError(e));
    }
  }

  Future<void> _fetchSpotlights(EikyushoSource source) async {
    final rawNovels = await source.getTrendingNovels();

    final novels = rawNovels
        .map(
          (novel) => Novel(
            source,
            title: novel.title,
            cover: novel.cover,
            link: novel.link,
          ),
        )
        .toList();

    emit(
      (state as DiscoverContentInitial).copyWith(
        spotlightsLoading: false,
        spotlights: novels,
      ),
    );
  }

  Future<void> _fetchMostPopular(EikyushoSource source) async {
    final rawNovels = await source.getMostPopularNovels();

    final novels = rawNovels
        .map(
          (novel) => Novel(
            source,
            title: novel.title,
            cover: novel.cover,
            link: novel.link,
          ),
        )
        .toList();

    emit(
      (state as DiscoverContentInitial).copyWith(
        mostPopularLoading: false,
        mostPopular: novels,
      ),
    );
  }

  Future<void> _fetchRecentlyUpdated(EikyushoSource source) async {
    final rawNovels = await source.getRecentlyUpdatedNovels();

    final novels = rawNovels
        .map(
          (novel) => Novel(
            source,
            title: novel.title,
            cover: novel.cover,
            link: novel.link,
          ),
        )
        .toList();

    emit(
      (state as DiscoverContentInitial).copyWith(
        recentlyUpdatedLoading: false,
        recentlyUpdated: novels,
      ),
    );
  }
}
