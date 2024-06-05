import 'dart:io';

import 'package:isar/isar.dart';

import 'entities/extension.dart';

class EikyushoDatabase {
  const EikyushoDatabase._(this._database);

  final Isar _database;

  static Future<EikyushoDatabase> init(String name, Directory directory) async {
    final database = await Isar.open(
      name: name,
      directory: directory.path,
      [
        ExtensionEntitySchema,
      ],
    );

    return EikyushoDatabase._(database);
  }

  Future<void> close() async {
    await _database.close();
  }

  Future<T> exec<T>(Future<T> Function(Isar isar) action) async {
    return _database.writeTxn(() => action(_database));
  }

  Future<T> readOnly<T>(Future<T> Function(Isar isar) action) async {
    return _database.txn(() => action(_database));
  }
}
