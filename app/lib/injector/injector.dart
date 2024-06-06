import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:app/injector/injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  asExtension: false,
)
Future<void> configureDependencies() async => $initGetIt(getIt);
