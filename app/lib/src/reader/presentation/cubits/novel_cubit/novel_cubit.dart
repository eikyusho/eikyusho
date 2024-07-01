import 'package:flutter/cupertino.dart';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';
import 'package:app/src/reader/data/data.dart';

part 'novel_state.dart';

class NovelCubit extends Cubit<NovelState> {
  NovelCubit(this._novelRepository) : super(NovelLoading());

  final NovelRepository _novelRepository;
  final ValueNotifier<bool> isAscending = ValueNotifier(true);
  String? url;

  Future<void> getNovelDetails(Novel novel) async {
    emit(NovelLoading());
    try {
      final (details, isLocal) = await _novelRepository.getNovelDetails(novel);
      url ??= details.link;
      await _loadChapters(details, isLocal: isLocal);
    } on Exception catch (e) {
      emit(NovelError(e));
    }
  }

  Future<void> _loadChapters(
    NovelDetails novel, {
    required bool isLocal,
  }) async {
    emit(NovelLoaded(novel, isLoading: true));

    try {
      final chapters = await _novelRepository.getNovelChapters(
        novel,
        isLocal: isLocal,
      );
      emit(NovelLoaded(novel, chapters: chapters, isLocal: isLocal));
    } on ServerException catch (e) {
      emit(NovelError(e));
    }
  }

  Future<void> addToLibrary(NovelDetails novel, List<Chapter> chapters) async {
    try {
      await _novelRepository.addToLibrary(novel, chapters);
      emit(NovelLoaded(novel, chapters: chapters, isLocal: true));
    } on Exception catch (e) {
      emit(NovelError(e));
    }
  }

  Future<void> removeFromLibrary(NovelDetails novel) async {
    if (state is! NovelLoaded) return;

    try {
      await _novelRepository.removeFromLibrary(novel);
      emit(NovelLoaded(novel, chapters: (state as NovelLoaded).chapters));
    } on Exception catch (e) {
      emit(NovelError(e));
    }
  }

  void toggleSort() {
    isAscending.value = !isAscending.value;
  }
}
