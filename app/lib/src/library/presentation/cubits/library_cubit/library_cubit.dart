import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';
import 'package:app/src/library/data/data.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit(this._libraryRepository) : super(LibraryLoading());

  final LibraryRepository _libraryRepository;

  Future<void> loadLibrary() async {
    emit(LibraryLoading());
    try {
      final novels = await _libraryRepository.getNovels();
      emit(LibraryLoaded(novels));
    } on Exception catch (e) {
      emit(LibraryError(e));
    }
  }
}
