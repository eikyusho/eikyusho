import 'package:equatable/equatable.dart';

class AvailableExtension extends Equatable {
  const AvailableExtension({
    required this.uuid,
    required this.name,
    required this.icon,
    required this.version,
    required this.language,
  });

  factory AvailableExtension.fromMap(Map<String, dynamic> map) {
    return AvailableExtension(
      uuid: map['uuid'] as String,
      name: map['name'] as String,
      icon: map['icon'] as String,
      version: map['version'] as String,
      language: map['language'] as String,
    );
  }

  final String uuid;
  final String name;
  final String icon;
  final String version;
  final String language;

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'icon': icon,
      'version': version,
      'language': language,
    };
  }

  @override
  List<Object> get props => [uuid, language];
}
