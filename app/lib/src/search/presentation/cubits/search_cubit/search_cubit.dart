import 'package:flutter/material.dart';

import 'package:core/core.dart';
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
  final globalMode = ValueNotifier<bool>(false);
  final query = ValueNotifier<String>('');

  Future<void> search(String query, BuildContext context) async {
    if (query.isEmpty) {
      emit(const SearchLoaded([]));
      return;
    }

    try {
      if (globalMode.value) {
        await _searchGlobally(query, context);
      } else {
        await _searchLocally(query);
      }
    } on Exception catch (e) {
      emit(SearchError(e));
    }
  }

  Future<void> _searchLocally(String query) async {
    emit(SearchLoading());

    final novels = await _libraryRepository.getNovels();

    final filteredNovels = novels.where((novel) {
      return novel.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (filteredNovels.isEmpty) {
      emit(const SearchEmpty(showTip: true));
      return;
    }

    emit(SearchLoaded(filteredNovels, showTip: true));
  }

  Future<void> _searchGlobally(String query, BuildContext context) async {
    emit(SearchLoading());

    final novelStream = await _searchRepository.searchNovels(query);

    novelStream.listen(
      (novels) {
        emit(SearchLoaded(novels));
      },
      onDone: () {
        final state = this.state as SearchLoaded;

        if (state.novels.isEmpty) {
          emit(const SearchEmpty(showTip: false));
        }
      },
      onError: (Object e) {
        context.showSnackBar(
          message: e.toString(),
          color: context.colors.error,
        );
      },
      cancelOnError: false,
    );
  }

  void changeGlobalMode(BuildContext context) {
    globalMode.value = !globalMode.value;
    if (query.value.isNotEmpty) search(query.value, context);
  }

  void changeShowModeToGrid() {
    showMode.value = ShowMode.grid;
  }

  void changeShowModeToList() {
    showMode.value = ShowMode.list;
  }
}
