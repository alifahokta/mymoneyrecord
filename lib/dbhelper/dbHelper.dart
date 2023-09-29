import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:mymoneyrecord/dbhelper/tipeKeuangan.dart';
import 'package:mymoneyrecord/models/user.dart';
import 'package:mymoneyrecord/models/keuangan.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}finplan.db';

    var itemDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return itemDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE user (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      password TEXT
      )'''
    );
    await db.execute('''
    CREATE TABLE keuangan (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      tanggal TEXT,
      jumlah TEXT,
      deskripsi TEXT,
      tipe TEXT
      )'''
    );
    await db.insert("user", {'username': 'user', 'password': 'user'});
  }

  //user
  Future<int> insertUser(User object) async {
    Database db = await this.database;
    int count = await db.insert('user', object.toMap());
    return count;
  }

  Future<bool> loginUser(String username, String password) async {
    Database db = await this.database;

    List<Map<String, dynamic>> result = await db.query('user', where: 'username = ? AND password = ?', whereArgs: [username, password]);
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> changePassword(String username, String password) async {
    Database db = await this.database;

    int result = await db.rawUpdate(
      'UPDATE user SET password = ? WHERE username = ?', [password, username]);
    return result;
  }

  Future<List<User>> getUserLogin(String username) async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.query('user', where: 'username = ?', whereArgs: [username]);

    List<User> users = [];
    for (var i = 0; i < result.length; i++) {
      users.add(User.fromMap(result[i]));
    }
    return users;
  }

  Future<User?> getUserByUsername(String username) async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.query('user', where: 'username = ?', whereArgs: [username]);

    if (result.isNotEmpty) {
      return User.fromMap(result[0]);
    } else {
      return null;
    }
  }

  //keuangan
  Future<int> insertKeuangan(Keuangan object) async {
    Database db = await this.database;
    int count = await db.insert('keuangan', object.toMap());
    return count;
  }

  Future<int> insertPemasukan(
    String tanggal, String jumlah, String deskripsi) async {
    Database db = await this.database;

    Keuangan pemasukanData = Keuangan(tanggal, jumlah, deskripsi, tipePemasukan);
    print(pemasukanData.toMap());
    int count = await db.insert('keuangan', pemasukanData.toMap());
    return count;
  }

    Future<int> getTotalPemasukan() async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT SUM(jumlah) as total FROM keuangan where tipe = "pemasukan"');

    if (result.isNotEmpty && result[0]['total'] != null) {
      int total = result[0]['total'];
      return total;
    } else {
      return 0;
    }
  }

  Future<int> insertPengeluaran(
    String tanggal, String jumlah, String deskripsi) async {
    Database db = await this.database;

    Keuangan pengeluaranData = Keuangan(tanggal, jumlah, deskripsi, tipePengeluaran);
    print(pengeluaranData.toMap());
    int count = await db.insert('keuangan', pengeluaranData.toMap());
    return count;
  }

  Future<int> getTotalPengeluaran() async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT SUM(jumlah) as total FROM keuangan where tipe = "pengeluaran"');

    if (result.isNotEmpty && result[0]['total'] != null) {
      int total = result[0]['total'];
      return total;
    } else {
      
      return 0;
    }
  }

  Future<List<Keuangan>> getKeuangan() async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.query('keuangan');

    List<Keuangan> keuangan = [];
    for (var i = 0; i < result.length; i++) {
      keuangan.add(Keuangan.fromMap(result[i]));
    }
    return keuangan;
  }

  Future<int> insertDataKeuangan(Keuangan object) async {
    Database db = await this.database;
    int count = await db.insert('keuangan', object.toMap());
    return count;
  }

  Future<int> deleteDataKeuangan(int id) async {
    Database db = await this.database;
    int count = await db.delete('keuangan', where: 'id=?', whereArgs: [id]);
    return count;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database!;
  }

}

