import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';
import 'package:app/src/reader/data/data.dart';

part 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  ReaderCubit(this._repository) : super(ReaderLoading());

  final NovelRepository _repository;

  int currentPage = 0;

  Future<void> loadChapter(Chapter chapter, List<Chapter> chapters) async {
    try {
      emit(ReaderLoading());

      final chapterContent = await _repository.getChapter(chapter);

      emit(ReaderLoaded(chapter, content: chapterContent, chapters: chapters));
    } on ServerException catch (e) {
      emit(ReaderError(e));
    }
  }
}
