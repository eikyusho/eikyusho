import 'package:isar/isar.dart';

part 'extension.g.dart';

@collection
class ExtensionEntity {
  ExtensionEntity();

  ExtensionEntity.create({
    required this.uuid,
    required this.name,
    required this.icon,
    required this.version,
    required this.language,
    required this.baseUrl,
    required this.isEnabled,
    required this.isObsolete,
    required this.hasUpdate,
    required this.discover,
    this.updateVersion,
  });

  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  late String name;

  late String icon;

  late String version;

  late String language;

  late String baseUrl;

  late bool isEnabled;

  late bool isObsolete;

  late bool hasUpdate;

  late bool discover;

  String? updateVersion;
}
