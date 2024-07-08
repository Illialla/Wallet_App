import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> createDatabase() async {
  // Откройте соединение с базой данных:
  Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_database2.db'), version: 1,
  onCreate: (Database db, int version) async {
    // создание
    await db.execute('''
          CREATE TABLE IF NOT EXISTS tblCategory(
            category_id INTEGER PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            colour VARCHAR(255) NOT NULL
          );
        ''');

    await db.execute('''
          CREATE TABLE IF NOT EXISTS tblWaste(
            waste_id INTEGER PRIMARY KEY,
            category_id INTEGER NOT NULL,
            sum REAL NOT NULL,
            date DATE NOT NULL,
            description VARCHAR(255) NOT NULL,
            FOREIGN KEY (category_id) REFERENCES tblCategory(category_id)
          );
        ''');

    await db.execute('''
          INSERT INTO tblCategory (name, colour) VALUES 
          ('Без категории', '0xFF919191');
        ''');

  }
  );
}