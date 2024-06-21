import '../../constants/app_constants.dart';
import '../../services/storage_manager.dart';
import '../helpers/path.dart';

Future<String> getSourcePath(String extension) async {
  final directory = await StorageManager.appDirectory;
  final uuid = extension;

  return Path.join(directory.path, AppConstants.sourcesPath, uuid);
}
