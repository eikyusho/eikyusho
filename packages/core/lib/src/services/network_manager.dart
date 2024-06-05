import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../enums/exception_types.dart';
import '../enums/status_code.dart';
import '../errors/exceptions.dart';
import '../utils/utils.dart';

@protected
enum RequestMethod {
  get('GET');

  const RequestMethod(this.value);

  final String value;

  @override
  String toString() {
    return value;
  }
}

abstract class NetworkClient<Client> {
  const NetworkClient(this.client);

  @protected
  final Client client;

  Future<ResponseData<T>> get<T>(
    String url, {
    HttpRequestOptions? options,
    DataMap? query,
  }) async {
    return handleRequest<T>(
      url: url,
      data: query,
      method: RequestMethod.get,
      options: options,
    );
  }

  Future<bool> isConnected();

  Future<bool> isWifi();

  Future<bool> isMobile();

  Future<ResponseData<T>> handleRequest<T>({
    required String url,
    required DataMap? data,
    required RequestMethod method,
    required HttpRequestOptions? options,
  });

  bool isGet(RequestMethod method) => method == RequestMethod.get;
}

class DioClient extends NetworkClient<Dio> {
  const DioClient(super.client);

  @override
  Future<bool> isConnected() async {
    throw UnimplementedError();
  }

  @override
  Future<bool> isMobile() async {
    throw UnimplementedError();
  }

  @override
  Future<bool> isWifi() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseData<T>> handleRequest<T>({
    required String url,
    required DataMap? data,
    required RequestMethod method,
    required HttpRequestOptions? options,
  }) async {
    try {
      final opts = options.getOr(const HttpRequestOptions());

      final response = await client.request<T>(
        url,
        data: isGet(method) ? null : data,
        queryParameters: isGet(method) ? data : null,
        cancelToken: opts.cancelToken,
        onReceiveProgress: opts.onReceiveProgress,
        options: Options(
          headers: opts.headers,
          method: method.toString(),
          responseType: opts.responseType,
          receiveDataWhenStatusError: true,
        ),
      );

      return ResponseData<T>(
        statusCode: StatusCode.from(response.statusCode.getOr(0)),
        body: response,
      );
    } on DioException catch (e) {
      final message = e.response?.statusMessage ?? e.message;

      throw ServerException(
        message.getOr('No Status Message'),
        type: ServerExceptionType.fromDioException(e),
      );
    }
  }
}
