import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Database details
  static const _databaseName = 'bank_db.db';
  static const _databaseVersion = 1;

  // Bank Details Table
  static const bankDetailsTable = 'bank_details_table';

  // Bank Details Table - Column
  static const columnId = "_id";
  static const columnBankName = "_bankName";
  static const columnBranch = "_branch";
  static const columnAccountType = "_accountType";
  static const columnAccountNo = "_accountNo";
  static const columnIFSCCode = "_IFSCCode";

  late Database _db;

  Future<void> init() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, _databaseName);
    _db = await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database database, int version) async {
    await database.execute('''CREATE TABLE $bankDetailsTable(
     $columnId INTEGER PRIMARY KEY,
     $columnBankName TEXT,
     $columnBranch TEXT,
     $columnAccountType TEXT,
     $columnAccountNo TEXT,
     $columnIFSCCode TEXT
     )''');
  }

  _onUpgrade(Database database, int oldVersion, int newVersion) async {
    await database.execute('drop table $bankDetailsTable');
    _onCreate(database, newVersion);
  }

  Future<int> insert(Map<String, dynamic> row, String tableName) async {
    return await _db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    // select *from bank_details_table;
    return await _db.query(tableName);
  }

  Future<int> update(Map<String,dynamic> row, String tableName) async{
    int id  = row[columnId];
    return await _db.update(
      tableName,
      row,
      where: '$columnId = ?',
      whereArgs: [id]
    );
  }

  Future<int> delete(int id, String tableName) async {
    return await _db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],);
  }
}
