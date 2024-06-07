import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> createDatabase() async {
  // Откройте соединение с базой данных:
  Database database = await openDatabase(join(await getDatabasesPath(), 'new_database.db'), version: 1,
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
            FOREIGN KEY (category_id) REFERENCES tblCategory(category_id)
          );
        ''');

    await db.execute('''
          INSERT INTO tblCategory (name, colour) VALUES 
          ('Еда', '0xFFACA5F7'), ('Транспорт', '0xFFA5F7D5'), ('Прочее', '0xFFFF88BA');
        ''');

    await db.execute('''
          INSERT INTO tblWaste (category_id, sum, date) VALUES 
          (1, 550, '2024-05-25'), (2, 750, '2024-05-25'), (2, 450, '2024-05-30'), (3, 415, '2024-05-30');
        ''');
  });
}