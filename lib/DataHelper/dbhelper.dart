import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static DbHelper dbHelper = DbHelper._();

  DbHelper._();

  Database? _db;

  Future<Database> get database async => _db ?? await initDatabase();

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'Platform.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''CREATE TABLE Platform(
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         Name TEXT,
         Phone TEXT,
         Chat TEXT,
         img TEXT,
         Time TEXT,
         Time2 Text
        );'''; // Removed the extra comma
        await db.execute(sql);
      },
    );
    return _db!;
  }

  Future<void> insertData(
      {required String Name,
        required String Phone,
        required String Chat,
        required String img,
        required String Time,
        required String Time2}) async {
    Database? db = await database;
    String sql = '''INSERT INTO Platform(Name, Phone, Chat,img,Time,Time2)
    VALUES (?, ?, ?, ?, ?, ?);''';
    List<dynamic> args = [Name, Phone, Chat, img, Time, Time2];
    await db.rawInsert(sql, args);
  }

  Future readData() async {
    Database? db = await database;
    String sql = '''
    SELECT * FROM Platform
    ''';
    return await db!.rawQuery(sql);
  }

  Future<void> deleteData(int id) async {
    Database? db = await database;
    String sql = '''DELETE FROM Platform WHERE id = ?''';
    List args = [id];
    await db.rawDelete(sql, args);
  }

//   Future<void> updateData(
//       int id, double amount, int isIncome, String category, String img) async {
//     Database? db = await database;
//     String sql =
//     '''UPDATE finance SET amount = ?, isIncome = ?, category = ?, img = ? WHERE id = ?;''';
//     List<dynamic> args = [amount, isIncome, category, img, id]; // Corrected the order of arguments
//     await db.rawUpdate(sql, args);
//   }

  Future<void> updateData(
      int id,
      String Name,
      String Phone,
      String Chat,
      String img,
      String Time,
      String Time2,
      ) async {
    Database? db = await database;
    String sql =
    '''UPDATE Platform SET Name = ?, Phone = ?, Chat = ?, img = ?, Time = ?, Time2 = ? WHERE id = ?;''';
    List args = [Name, Phone, Chat, img,Time,Time2, id];
    await db.rawUpdate(sql, args);
  }
//    Name TEXT,
//          Phone TEXT,
//          Chat TEXT,
//          img TEXT,
}