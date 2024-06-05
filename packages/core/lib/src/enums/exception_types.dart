import 'package:dio/dio.dart';

enum ServerExceptionType {
  failed,
  timeout,
  connection,
  cancelled,
  unknown;

  static ServerExceptionType fromDioException(DioException e) {
    return switch (e.type) {
      DioExceptionType.badResponse => ServerExceptionType.failed,
      DioExceptionType.connectionError => ServerExceptionType.connection,
      DioExceptionType.cancel => ServerExceptionType.cancelled,
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        ServerExceptionType.timeout,
      _ => ServerExceptionType.unknown,
    };
  }
}
