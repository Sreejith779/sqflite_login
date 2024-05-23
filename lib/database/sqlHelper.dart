 import 'package:sqflite/sqflite.dart'as sql;

class SqlHelper{
  static Future<sql.Database>openOrCreate()async{
    return await sql.openDatabase("users",version: 1,
    onCreate: (database,int)async{
      await createTable(database);
    });
  }

  static createTable(sql.Database database)async{
    await database.execute(
      "CREATE TABLE Logins(ID INTEGER AUTOINCREMENT NOT NULL, name NAME,email EMAIL,pass PASSWORD)"
    );
  }

}