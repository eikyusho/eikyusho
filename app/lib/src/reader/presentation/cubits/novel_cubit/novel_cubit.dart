import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';
import 'package:app/src/reader/data/data.dart';

part 'novel_state.dart';

class NovelCubit extends Cubit<NovelState> {
  NovelCubit(this._novelRepository) : super(NovelLoading());

  final NovelRepository _novelRepository;

  Future<void> getNovelDetails(Novel novel) async {
    emit(NovelLoading());
    try {
      final novelDetails = await _novelRepository.getNovelDetails(novel);
      await loadChapters(novelDetails);
    } on Exception catch (e) {
      emit(NovelError(e));
    }
  }

  Future<void> loadChapters(NovelDetails novel) async {
    emit(NovelLoaded(novel, isLoading: true));

    try {
      final chapters = await _novelRepository.getNovelChapters(novel);
      emit(NovelLoaded(novel, chapters: chapters));
    } on ServerException catch (e) {
      emit(NovelError(e));
    }
  }

  void _addChapters(NovelDetails novel, List<Chapter> chapters) {
    if (state is! NovelLoaded) return;

    final newChapters = [...(state as NovelLoaded).chapters, ...chapters];

    emit(
      NovelLoaded(novel, chapters: newChapters, isLoading: true),
    );
  }
}
