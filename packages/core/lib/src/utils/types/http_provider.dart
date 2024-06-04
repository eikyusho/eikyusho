// import 'package:dio/dio.dart';
// import 'package:eikyusho/core/constants/app_constants.dart';
// import 'package:eikyusho/core/enums/cache_policy.dart';
// import 'package:eikyusho/core/enums/status_code.dart';
// import 'package:eikyusho/core/services/middlewares/log_middleware.dart';
// import 'package:eikyusho/core/utils/types/typedefs.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
//
// export 'package:dio/dio.dart' show CancelToken, ResponseType;
//
// class DioProvider {
//   static Dio init() {
//     final dio = Dio(
//       BaseOptions(
//         contentType: Headers.jsonContentType,
//         connectTimeout: AppConstants.connectTimeout,
//         sendTimeout: AppConstants.sendTimeout,
//         receiveTimeout: AppConstants.receiveTimeout,
//       ),
//     );
//
//     dio.interceptors.addAll(
//       [
//         if (kDebugMode) DioLogInterceptor(),
//       ],
//     );
//
//     return dio;
//   }
// }
//
// class HttpRequestOptions {
//   const HttpRequestOptions({
//     this.headers,
//     this.onReceiveProgress,
//     this.cancelToken,
//     this.responseType = ResponseType.json,
//     this.cachePolicy = CachePolicy.cacheFirst,
//   });
//
//   final CachePolicy cachePolicy;
//   final ResponseType responseType;
//   final DataMap? headers;
//   final ProgressGetter? onReceiveProgress;
//   final CancelToken? cancelToken;
// }
//
// class ResponseData<T> extends Equatable {
//   const ResponseData({
//     required this.statusCode,
//     required this.body,
//   });
//
//   final StatusCode statusCode;
//   final Response<T> body;
//
//   @override
//   List<Object?> get props => [statusCode, body];
// }
