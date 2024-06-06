import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/src/browse/data/data.dart';

part 'extensions_state.dart';

class ExtensionsCubit extends Cubit<ExtensionsState> {
  ExtensionsCubit() : super(ExtensionsInitial());

  Future<void> fetchExtensions() async {
    emit(ExtensionsLoading());

    await Future.delayed(const Duration(seconds: 3));

    emit(
      ExtensionsLoaded(
        List<Extension>.generate(
          10,
          (index) => Extension(
            name: 'Extension $index',
            icon: 'icon',
            language: 'language',
            version: '1.0.$index',
            uuid: 'uuid',
          ),
        ),
        List<InstalledExtension>.generate(
          3,
          (index) => InstalledExtension(
            name: 'Extension $index',
            icon: 'icon',
            language: 'language',
            version: '1.0.$index',
            uuid: 'uuid',
          ),
        ),
      ),
    );
  }
}
