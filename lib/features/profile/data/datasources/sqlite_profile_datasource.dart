import '../../../../core/db/app_database.dart';
import 'profile_local_datasource.dart';

/// Triển khai [ProfileLocalDataSource] bằng SQLite (gói `sqflite`).
class SqliteProfileDataSource implements ProfileLocalDataSource {
  final AppDatabase appDatabase;

  SqliteProfileDataSource(this.appDatabase);

  @override
  Future<List<Map<String, dynamic>>> getProfiles() async {
    final db = await appDatabase.database;
    return db.query(
      AppDatabase.tableProfiles,
      orderBy: '${AppDatabase.colId} DESC',
    );
  }

  @override
  Future<Map<String, dynamic>?> getProfileById(int id) async {
    final db = await appDatabase.database;
    final rows = await db.query(
      AppDatabase.tableProfiles,
      where: '${AppDatabase.colId} = ?',
      whereArgs: [id],
      limit: 1,
    );
    return rows.isNotEmpty ? rows.first : null;
  }

  @override
  Future<int> insertProfile(Map<String, dynamic> row) async {
    final db = await appDatabase.database;
    return db.insert(AppDatabase.tableProfiles, row);
  }

  @override
  Future<int> updateProfile(Map<String, dynamic> row) async {
    final db = await appDatabase.database;
    return db.update(
      AppDatabase.tableProfiles,
      row,
      where: '${AppDatabase.colId} = ?',
      whereArgs: [row[AppDatabase.colId]],
    );
  }

  @override
  Future<int> deleteProfile(int id) async {
    final db = await appDatabase.database;
    return db.delete(
      AppDatabase.tableProfiles,
      where: '${AppDatabase.colId} = ?',
      whereArgs: [id],
    );
  }
}
