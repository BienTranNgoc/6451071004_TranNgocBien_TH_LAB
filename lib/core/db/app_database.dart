// SQLite database helper - Trần Ngọc Biên (6451071004)
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Singleton quản lý kết nối SQLite cho toàn bộ ứng dụng.
///
/// Bảng `profiles` lưu thông tin hồ sơ cá nhân (Phần 3 - CRUD Profile).
class AppDatabase {
  AppDatabase._internal();
  static final AppDatabase instance = AppDatabase._internal();

  static const String dbName = 'jobspot.db';
  static const int dbVersion = 1;

  static const String tableProfiles = 'profiles';
  static const String colId = 'id';
  static const String colFullName = 'full_name';
  static const String colStudentId = 'student_id';
  static const String colEmail = 'email';
  static const String colPhone = 'phone';
  static const String colAddress = 'address';

  Database? _database;

  Future<Database> get database async {
    _database ??= await _open();
    return _database!;
  }

  Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableProfiles (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colFullName TEXT NOT NULL,
        $colStudentId TEXT NOT NULL,
        $colEmail TEXT NOT NULL,
        $colPhone TEXT NOT NULL,
        $colAddress TEXT NOT NULL
      )
    ''');

    // Hồ sơ mẫu của sinh viên thực hiện đề tài.
    await db.insert(tableProfiles, {
      colFullName: 'Trần Ngọc Biên',
      colStudentId: '6451071004',
      colEmail: 'tranngocbien.6451071004@st.edu.vn',
      colPhone: '0987654321',
      colAddress: 'Việt Nam',
    });
  }
}
