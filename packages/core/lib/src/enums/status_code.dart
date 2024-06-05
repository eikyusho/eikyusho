enum StatusCode {
  ok(200),
  created(201),
  badRequest(400),
  unauthorized(401),
  forbidden(403),
  notFound(404),
  conflict(409),
  internalServerError(500),
  other(0);

  const StatusCode(this.code);

  final int code;

  static StatusCode from(int code) {
    return StatusCode.values.firstWhere(
          (element) => element.code == code,
      orElse: () => StatusCode.other,
    );
  }
}
