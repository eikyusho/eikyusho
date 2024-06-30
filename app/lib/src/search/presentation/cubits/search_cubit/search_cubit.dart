import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';
import 'package:app/src/library/data/data.dart';
import 'package:app/src/search/data/data.dart';

part 'search_state.dart';

enum ShowMode { grid, list }

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._searchRepository, this._libraryRepository)
      : super(SearchInitial());

  final SearchRepository _searchRepository;

  final LibraryRepository _libraryRepository;

  final showMode = ValueNotifier<ShowMode>(ShowMode.grid);

  Future<void> searchLocally(String query) async {
    emit(SearchLoading());

    try {
      final novels = await _libraryRepository.getNovels();

      if (query.isEmpty) {
        emit(const SearchLoaded([], isLocalSearch: true));
        return;
      }

      final filteredNovels = novels.where((novel) {
        return novel.title.toLowerCase().contains(query.toLowerCase());
      }).toList();

      emit(SearchLoaded(filteredNovels, isLocalSearch: true));
    } on Exception catch (e) {
      emit(SearchError(e));
    }
  }

  void changeShowModeToGrid() {
    showMode.value = ShowMode.grid;
  }

  void changeShowModeToList() {
    showMode.value = ShowMode.list;
  }
}
