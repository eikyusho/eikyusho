import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/src/browse/data/data.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit(this._repository) : super(const DiscoverLoading());

  final ExtensionsRepository _repository;

  Future<void> getSources() async {
    try {
      final sources = await _repository.getSources(
        filter: SourcesFilter.onlyDiscover,
      );

      emit(DiscoverLoaded(sources));
    } catch (e) {
      emit(const DiscoverError('TODO:'));
    }
  }
}
