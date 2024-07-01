import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';
import 'package:app/src/reader/data/data.dart';

part 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  ReaderCubit(
    this._repository, {
    required List<Chapter> chapters,
    required Chapter chapter,
  }) : super(ReaderLoading()) {
    pageController = PageController();
    currentPage = chapters.indexOf(chapter);
  }

  final NovelRepository _repository;

  late final PageController pageController;
  late int currentPage;

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
