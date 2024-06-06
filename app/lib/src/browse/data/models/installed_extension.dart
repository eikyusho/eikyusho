import 'package:database/database.dart' as database;

import 'package:app/src/browse/data/models/extension.dart';

class InstalledExtension extends Extension {
  const InstalledExtension({
    required this.id,
    required super.uuid,
    required super.name,
    required super.icon,
    required super.version,
    required super.language,
    required this.baseUrl,
    this.isEnabled = true,
    this.isObsolete = false,
    this.hasUpdate = false,
    this.discover = true,
    this.updateVersion,
  });

  factory InstalledExtension.fromDatabase(database.Extension extension) {
    return InstalledExtension(
      id: extension.id,
      uuid: extension.uuid,
      name: extension.name,
      icon: extension.icon,
      version: extension.version,
      language: extension.language,
      baseUrl: extension.baseUrl,
      isEnabled: extension.isEnabled,
      isObsolete: extension.isObsolete,
      hasUpdate: extension.hasUpdate,
      discover: extension.discover,
      updateVersion: extension.updateVersion,
    );
  }

  final int id;
  final String baseUrl;
  final bool isEnabled;
  final bool isObsolete;
  final bool hasUpdate;
  final bool discover;
  final String? updateVersion;

  InstalledExtension copyWith({
    int? id,
    String? uuid,
    String? name,
    String? icon,
    String? version,
    String? language,
    String? baseUrl,
    bool? isEnabled,
    bool? isObsolete,
    bool? hasUpdate,
    bool? discover,
    String? updateVersion,
  }) {
    return InstalledExtension(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      version: version ?? this.version,
      language: language ?? this.language,
      baseUrl: baseUrl ?? this.baseUrl,
      isEnabled: isEnabled ?? this.isEnabled,
      isObsolete: isObsolete ?? this.isObsolete,
      hasUpdate: hasUpdate ?? this.hasUpdate,
      discover: discover ?? this.discover,
      updateVersion: updateVersion ?? this.updateVersion,
    );
  }
}
