import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';
import 'package:app/src/browse/data/data.dart';

part 'extension_card_state.dart';

class ExtensionCardCubit extends Cubit<ExtensionCardState> {
  ExtensionCardCubit(this._repository, this.extension)
      : super(const ExtensionCardInitial());

  final ExtensionsRepository _repository;
  final AvailableExtension extension;

  CancelToken cancelToken = CancelToken();

  Future<void> download() async {
    emit(const ExtensionCardDownloading(0));

    try {
      await _repository.installExtension(
        extension: extension,
        progressCallback: _progressEmitter,
        cancelToken: cancelToken,
      );
    } catch (e) {
      AppLogger.error(e.toString());
      emit(ExtensionCardError(e.toString()));
    }
  }

  Future<void> _progressEmitter(int progress, int total) async {
    if (!cancelToken.isCancelled) {
      emit(ExtensionCardDownloading(progress / total));
    }

    if (progress == total) {
      emit(const ExtensionCardDownloaded());
    }
  }
}
