import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/screens/entry/modal/entry_modal.dart';

class DBHelper {
  static DBHelper dbHelper = DBHelper._();

  DBHelper._();

  Database? database;

  String tableName = "incexp";
  String c_id = "id";
  String c_amount = "amount";
  String c_category = "category";
  String c_date = "date";
  String c_time = "time";
  String c_method = "method";
  String c_status = "status";

  Future<Database?> checkDB() async {
    if (database != null) {
      print("===========================================check");

      return database;
    } else {
      print("===========================================checkinit");
      Database? db;
      return db = await initDB();
    }
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "transaction.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE $tableName ($c_id INTEGER PRIMARY KEY AUTOINCREMENT,$c_amount TEXT,$c_category TEXT,$c_date TEXT,$c_time TEXT,$c_method TEXT,$c_status INTEGER)";
        String query2 =
            "CREATE TABLE categry ($c_id INTEGER PRIMARY KEY AUTOINCREMENT,$c_category TEXT)";
        db.execute(query);
        db.execute(query2);
      },
    );
  }

  Future<void> insertDB(EntryModel e1) async {
    database = await checkDB();

    print("===========================================insert");

    database!.insert(tableName, {
      c_amount: e1.Amount,
      c_category: e1.Category,
      c_date: e1.Date,
      c_time: e1.Time,
      c_method: e1.Method,
      c_status: e1.Status,
    });
  }

  Future<void> insertDB2(String Category) async {
    database = await checkDB();

    print("===========================================insert");

    database!.insert("categry", {
      c_category: Category,
    });
  }

  Future<List<Map>> readDB() async {
    database = await checkDB();

    print("================================read");

    String query = "SELECT * FROM $tableName";
    List<Map> l1 = await database!.rawQuery(query);
    return l1;
  }

  Future<List<Map>> readIncome() async {
    database = await checkDB();

    String query = "SELECT * FROM $tableName WHERE $c_status = 0";
    List<Map> l1 = await database!.rawQuery(query);
    return l1;
  }

  Future<List<Map>> readExpense() async {
    database = await checkDB();

    String query = "SELECT * FROM $tableName WHERE $c_status = 1";
    List<Map> l1 = await database!.rawQuery(query);
    return l1;
  }

  Future<List<Map>> readDB2() async {
    database = await checkDB();

    print("================================read");

    String query = "SELECT * FROM categry";
    List<Map> l1 = await database!.rawQuery(query);

    print(l1);
    return l1;
  }

  Future<void> updateDB(EntryModel e1, int Id) async {
    database = await checkDB();

    database!.update(
        tableName,
        {
          c_amount: e1.Amount,
          c_category: e1.Category,
          c_date: e1.Date,
          c_time: e1.Time,
          c_method: e1.Method,
          c_status: e1.Status,
        },
        where: "id=?",
        whereArgs: [Id]);
  }

  Future<void> deleteDB(int Id) async {
    database = await checkDB();

    database!.delete(tableName, where: "id=?", whereArgs: [Id]);
  }

  // Filter({ required statusCode, required method,required category,}) async {
  //   print("helper ============================");
  //   print(statusCode);
  //   print(method);
  //   if(statusCode != "2" && method == "All" && category == "")
  //   {
  //     database = await checkDB();
  //     String query = "SELECT * FROM $tableName WHERE $c_status = $statusCode";
  //     List<Map> l1 = await database!.rawQuery(query);
  //     return l1;
  //   }
  //   else if(statusCode == 2 && method != "all" && category == "")
  //   {
  //     database = await checkDB();
  //     String query = "SELECT * FROM $tableName WHERE $c_method = '$method'";
  //     List<Map> l1 = await database!.rawQuery(query);
  //     return l1;
  //   }
  //   else if(statusCode == 2 && method == "all" && category != "")
  //   {
  //     String query = "SELECT * FROM $tableName WHERE $c_date = '$category'";
  //     List<Map> l1 = await database!.rawQuery(query);
  //     return l1;
  //   }
  //   else if(statusCode != 2 && method == "all" && category != "")
  //   {
  //     String query = "SELECT * FROM $tableName WHERE $c_date = '$category' AND $c_status = $statusCode";
  //     List<Map> l1 = await database!.rawQuery(query);
  //     return l1;
  //   }
  //   else if(statusCode == 2 && method != "all" && category != "")
  //   {
  //     String query = "SELECT * FROM $tableName WHERE $c_date = '$category' AND $c_method = '$method'";
  //     List<Map> l1 = await database!.rawQuery(query);
  //     return l1;
  //   }
  //   else if (statusCode != 2 && method != 'all' && category == "") {
  //     database = await checkDB();
  //     String query = "SELECT * FROM $tableName WHERE $c_method = '$method' AND $c_status = '$statusCode'";
  //     List<Map> l1 = await database!.rawQuery(query);
  //     return l1;
  //   }
  //   else if(statusCode != 2 && method != 'all' && category != "")
  //   {
  //     String query = "SELECT * FROM $tableName WHERE $c_date = '$category' AND $c_method = '$method' AND $c_status = '$statusCode'";
  //     List<Map> l1 = await database!.rawQuery(query);
  //     return l1;
  //   }
  //
  // }
  multiSort({
    required statusCode,
    required method,
    required category,
  }) async {
    database = await checkDB();

    print("helper ============================");
    print(statusCode);
    print(method);
    if (statusCode != "2" && method == "All" && category == "") {
      String query = "SELECT * FROM $tableName WHERE $c_status = '$statusCode'";
      List<Map> l1 = await database!.rawQuery(query);
      return l1;
    } else if (statusCode == 2 && method != "All" && category == "") {
      String query = "SELECT * FROM $tableName WHERE $c_method = '$method'";
      List<Map> l1 = await database!.rawQuery(query);
      return l1;
    } else if (statusCode == 2 && method == "All" && category != "") {
      String query = "SELECT * FROM $tableName WHERE $c_category = '$category'";
      List<Map> l1 = await database!.rawQuery(query);
      return l1;
    } else if (statusCode != 2 && method == "All" && category != "") {
      String query =
          "SELECT * FROM $tableName WHERE $c_category = '$category' AND $c_status = '$statusCode'";
      List<Map> l1 = await database!.rawQuery(query);
      return l1;
    } else if (statusCode == 2 && method != "All" && category != "") {
      String query =
          "SELECT * FROM $tableName WHERE $c_category = '$category' AND $c_method = '$method'";
      List<Map> l1 = await database!.rawQuery(query);
      return l1;
    } else if (statusCode != 2 && method != 'All' && category == "") {
      String query =
          "SELECT * FROM $tableName WHERE $c_method = '$method' AND $c_status = '$statusCode'";
      List<Map> l1 = await database!.rawQuery(query);
      return l1;
    } else if (statusCode != 2 && method != 'All' && category != "") {
      String query =
          "SELECT * FROM $tableName WHERE $c_category = '$category' AND $c_method = '$method' AND $c_status = '$statusCode'";
      List<Map> l1 = await database!.rawQuery(query);
      return l1;
    }
  }

  Future<List<Map>> IEFilter(String status) async {
    database = await checkDB();

    String query = "SELECT * FROM $tableName WHERE $c_status = $status";
    List<Map> l1 = await database!.rawQuery(query);
    return l1;
  }

  Future<List<Map>> methodFilter(String method) async {
    database = await checkDB();

    String query = "SELECT * FROM $tableName WHERE $c_method = $method";
    List<Map> l1 = await database!.rawQuery(query);
    return l1;
  }

  Future<List<Map>> categoryFilter(String cate) async {
    database = await checkDB();

    String query = "SELECT * FROM $tableName WHERE $c_category = $cate";
    List<Map> l1 = await database!.rawQuery(query);
    return l1;
  }
}
