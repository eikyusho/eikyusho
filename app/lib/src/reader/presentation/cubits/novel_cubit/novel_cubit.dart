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
      emit(NovelLoaded(novelDetails));
    } on Exception catch (e) {
      emit(NovelError(e));
    }
  }
}
