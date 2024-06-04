import 'package:path/path.dart' as p;

class Path {
  static String join(String path1, String path2, [String? path3]) {
    return p.join(path1, path2, path3);
  }

  static String joinAll(Iterable<String> paths) {
    return p.joinAll(paths);
  }

  static String setExtension(String path, String extension) {
    return p.setExtension(path, extension);
  }

  static String getExtension(String path) {
    return p.extension(path);
  }

  static String getFilename(String path) {
    return p.basename(path);
  }

  static String getFilenameWithoutExtension(String path) {
    return p.basenameWithoutExtension(path);
  }

  static String getDirectory(String path) {
    return p.dirname(path);
  }

  static String normalize(String path) {
    return p.normalize(path);
  }

  static bool isWithin(String parent, String child) {
    return p.isWithin(parent, child);
  }
}
