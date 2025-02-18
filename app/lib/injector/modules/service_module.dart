import 'package:flutter/foundation.dart';

import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:eikyusho_extensions/extensions.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ServiceModule {
  @preResolve
  @lazySingleton
  Future<SharedPrefsManager> sharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefsManager(prefs);
  }

  @preResolve
  @lazySingleton
  Future<EikyushoDatabase> database() async => EikyushoDatabase.init(
        AppConstants.appName.toLowerCase(),
        await StorageManager.appDirectory,
      );

  @lazySingleton
  EikyushoCompiler get compiler => const EikyushoCompiler();

  @singleton
  DioClient dioClient(Dio dio) => DioClient(dio);

  @injectable
  Dio dio() {
    final interceptors = Interceptors()
      ..addAll(
        [
          if (kDebugMode) DioLogInterceptor(),
        ],
      );

    return HttpProvider(interceptors: interceptors).init();
  }
}
