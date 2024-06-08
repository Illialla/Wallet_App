import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<List<List<String>>> getCategoryList(String day, String month, String year, String _selectedBlock) async {
  Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_db.db'));
  String query = '';
  if(_selectedBlock=='day'){
    query = '''
      SELECT cat.name, cat.colour, SUM(w.sum) as totalSum
      FROM tblCategory as cat
      JOIN tblWaste as w ON cat.category_id = w.category_id
      WHERE w.date = "$year-$month-$day"
      GROUP BY cat.category_id;
    ''';
  }
  else if(_selectedBlock=='month'){
    DateTime firstDay = DateTime(int.parse(year), int.parse(month));
    DateTime lastDay = DateTime(firstDay.year, firstDay.month + 1, 0);
    String firstDate = '${firstDay.year}-${firstDay.month.toString().padLeft(2, '0')}-01';
    String lastDate = '${lastDay.year}-${lastDay.month.toString().padLeft(2, '0')}-${lastDay.day.toString().padLeft(2, '0')}';
    query = '''
      SELECT cat.name, cat.colour, SUM(w.sum) as totalSum
      FROM tblCategory as cat
      JOIN tblWaste as w ON cat.category_id = w.category_id
      WHERE w.date BETWEEN "$firstDate" AND "$lastDate"
      GROUP BY cat.category_id;
    ''';
  }
  else {
    query = '''
      SELECT cat.name, cat.colour, SUM(w.sum) as totalSum
      FROM tblCategory as cat
        JOIN tblWaste as w ON cat.category_id = w.category_id
      WHERE w.date >= "$year-01-01" AND w.date <= "$year-12-31"
      GROUP BY cat.category_id;
    ''';
  }

  List<Map<String, dynamic>> categories = await database.rawQuery(query);

  List<List<String>> categoryList = [];

  categories.forEach((category) {
    String name = category['name'];
    String colour = category['colour'];
    // Обработка случая, когда totalSum может быть NULL
    double totalSum = category['totalSum'] != null ? category['totalSum'] : 0.0;
    categoryList.add([name, colour, totalSum.toString()]);
  });
  print(categoryList);
  return categoryList;
}

Future<List<List<String>>> getCategoryListForShow() async {
  Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_db.db'));
  String query = '';

  query = '''
    SELECT cat.name, cat.colour
      FROM tblCategory as cat
      GROUP BY cat.category_id;
  ''';

  List<Map<String, dynamic>> categories = await database.rawQuery(query);

  List<List<String>> categoryList = [];

  categories.forEach((category) {
    String name = category['name'];
    String colour = category['colour'];
    categoryList.add([name, colour]);
  });
  print(categoryList);
  return categoryList;
}

Future<void> addCategoryToDatabase(String categoryName, String categoryColour) async {
  // Получаем путь к базе данных
  Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_db.db'));

  String query = 'INSERT INTO tblCategory(name, colour) VALUES("$categoryName", "$categoryColour")';

  await database.transaction((txn) async {
    await txn.rawInsert(query);
  });
}

Future<void> deleteCategoryFromDatabase(String categoryName) async {
  // Получаем путь к базе данных
  Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_db.db'));

  String query = 'DELETE FROM tblCategory WHERE name = "$categoryName"';

  await database.transaction((txn) async {
    await txn.rawDelete(query);
  });
}
