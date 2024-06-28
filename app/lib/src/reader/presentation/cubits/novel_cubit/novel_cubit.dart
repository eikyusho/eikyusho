import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';
import 'package:app/src/reader/data/repositories/novel_repository.dart';

part 'novel_state.dart';

class NovelCubit extends Cubit<NovelState> {
  NovelCubit(this._novelRepository) : super(NovelLoading());

  final NovelRepository _novelRepository;

  Future<void> getNovelDetails(Novel novel) async {
    emit(NovelLoading());
    try {
      final novelDetails = await _novelRepository.getNovelDetails(novel);
      emit(NovelInfoLoaded(novelDetails));
    } on Exception catch (e) {
      emit(NovelError(e));
    }
  }

  Future<void> loadChapters(NovelDetails novel) async {
    if (state is! NovelInfoLoaded) return;

    try {
      final novelChapters = await _novelRepository.getNovelChapters(novel);
      emit(
        NovelChaptersLoaded((state as NovelInfoLoaded).novel, novelChapters),
      );
    } on Exception catch (e) {
      emit(NovelError(e));
    }
  }
}
