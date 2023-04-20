
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user_item.dart';

class DbHelper {

  static final _databaseName = "userlist.db";
  static final _databaseVersion = 1;
  static final table = 'users';
  static final columnId = 'id';
  static final columnFname = 'fname';
  static final columnLname = 'lname';
  static final columnEmail = 'email';
  // make this a singleton class
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnFname TEXT NOT NULL,
            $columnLname TEXT NOT NULL,  $columnEmail TEXT NOT NULL
          )
          ''');
  }

  Future<User> addUserData(User user) async {
    var dbClient = await instance.database;
    print(user.toMap());
    user.id = await dbClient!.insert('users', user.toMap());
    return user;
  }
  Future<int> insert(User user) async {
    Database? db = await instance.database;
    return await db!.insert(table, {'fname': user.fname, 'lname': user.lname, 'email': user.email});
  }

  getUsers() async{
    var dbClient = await  instance.database;
    final res = await dbClient!.rawQuery("SELECT * FROM users");
    print(res);
    return res;
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryRows(name) async {
    Database? db = await instance.database;
    return await db!.query(table, where: "$columnFname LIKE '%$name%'");
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.


  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
   delete(int? id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}