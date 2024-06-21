import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:app/src/browse/data/data.dart';

part 'browse_state.dart';

@injectable
class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit(this._repository) : super(const BrowseLoading());

  final ExtensionsRepository _repository;

  Future<void> getSources() async {
    emit(const BrowseLoading());

    final sources = await _repository.getSources(
      filter: SourcesFilter.onlyEnabled,
    );

    emit(BrowseLoaded(sources));
  }
}
