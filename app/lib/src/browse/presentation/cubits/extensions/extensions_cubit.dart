import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:app/src/browse/data/data.dart';

part 'extensions_state.dart';

@injectable
class ExtensionsCubit extends Cubit<ExtensionsState> {
  ExtensionsCubit(this._repository) : super(const ExtensionsLoading());

  final ExtensionsRepository _repository;

  Future<void> getExtensionsAndSources() async {
    try {
      final (available, outdated) = await _repository.getExtensionsAndSources();

      emit(ExtensionsLoaded(available, outdated));
    } catch (e) {
      AppLogger.error(e.toString(), e);
    }
  }
}
