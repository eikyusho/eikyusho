import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';
import 'package:app/src/library/data/data.dart';
import 'package:app/src/search/data/data.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._searchRepository, this._libraryRepository)
      : super(SearchInitial());

  final SearchRepository _searchRepository;

  final LibraryRepository _libraryRepository;

  Future<void> searchLocally(String query) async {
    try {
      final novels = await _libraryRepository.getNovels();

      final results = novels.where((novel) {
        return novel.title.toLowerCase().contains(query.toLowerCase());
      }).toList();

      emit(SearchLoaded(results, isLocalSearch: true));
    } on Exception catch (e) {
      emit(SearchError(e));
    }
  }
}
