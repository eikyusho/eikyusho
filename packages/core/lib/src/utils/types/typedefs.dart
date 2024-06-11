import 'dart:typed_data';

import 'http_provider.dart';

typedef DataMap = Map<String, dynamic>;
typedef Bytes = Uint8List;
typedef RBytes = ResponseData<Bytes>;

// * || Functions
typedef ProgressGetter = void Function(int sent, int total);
