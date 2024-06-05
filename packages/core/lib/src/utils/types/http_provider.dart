import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../constants/app_constants.dart';
import '../../enums/cache_policy.dart';
import '../../enums/status_code.dart';
import '../utils.dart';

class HttpProvider {
  const HttpProvider({required this.interceptors});

  Dio init() {
    final options = BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      contentType: Headers.jsonContentType,
      connectTimeout: AppConstants.connectTimeout,
      sendTimeout: AppConstants.sendTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
    );

    final dio = Dio(options);

    dio.interceptors.addAll(interceptors);

    return dio;
  }

  final Interceptors interceptors;
}

class HttpRequestOptions {
  const HttpRequestOptions({
    this.headers,
    this.onReceiveProgress,
    this.cancelToken,
    this.responseType = ResponseType.json,
    this.cachePolicy = CachePolicy.cacheFirst,
  });

  final CachePolicy cachePolicy;
  final ResponseType responseType;
  final DataMap? headers;
  final ProgressGetter? onReceiveProgress;
  final CancelToken? cancelToken;
}

class ResponseData<T> extends Equatable {
  const ResponseData({
    required this.statusCode,
    required this.body,
  });

  final StatusCode statusCode;
  final Response<T> body;

  @override
  List<Object?> get props => [statusCode, body];
}
