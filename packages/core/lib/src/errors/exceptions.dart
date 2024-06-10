import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../enums/exception_types.dart';

enum ExceptionType {
  server,
  database,
  storage,
}

@immutable
abstract class _CustomException extends Equatable implements Exception {
  const _CustomException(this.message);

  final String message;
}

class ServerException extends _CustomException {
  const ServerException(super.message, {required this.type, this.statusCode});

  factory ServerException.fromException(Object e) {
    return ServerException(
      e.toString(),
      type: ServerExceptionType.unknown,
      statusCode: 999,
    );
  }

  final int? statusCode;
  final ServerExceptionType type;

  @override
  List<Object?> get props => [message, type, statusCode];
}

class DatabaseException extends _CustomException {
  const DatabaseException(super.message);

  @override
  List<Object?> get props => [message];
}

class StorageException extends _CustomException {
  const StorageException(super.message);

  @override
  List<Object?> get props => [message];
}
