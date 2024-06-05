import 'dart:convert';

import 'package:dio/dio.dart';

import '../../utils/utils.dart';

class DioLogInterceptor extends Interceptor {
  final encoder = const JsonEncoder.withIndent('  ');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.debug('''
#->[ ${options.method} ${options.uri.path} ]<--------#


Headers: ${options.headers}
Query Parameters: ${options.queryParameters}
Request Body: ${options.data}
Content-Type: ${options.contentType}''');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    AppLogger.info('''
#->[ ${response.statusCode} ${response.requestOptions.uri.path} ]<--------#


Response Body: ${response.data}
Content-Type: ${response.headers.map['content-type']}''');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response.toString();
    String prettyPrint;

    try {
      final jsonObject = json.decode(response);

      prettyPrint = encoder.convert(jsonObject);
    } catch (e) {
      prettyPrint = response;
    }

    AppLogger.error('''
#->[ ${err.response?.statusCode} ${err.requestOptions.uri.path} ]<--------#

Type: ${err.type}
Error: $prettyPrint''');

    super.onError(err, handler);
  }
}
