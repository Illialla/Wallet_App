import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<List<List<String>>> getCategoryList(String day, String month, String year, String _selectedBlock) async {
  Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_database2.db'));
  String query = '';
  if(_selectedBlock=='day'){
    query = '''
      SELECT cat.name, cat.colour, SUM(w.sum) as totalSum
      FROM tblCategory as cat
      JOIN tblWaste as w ON cat.category_id = w.category_id
      WHERE w.date = "$year-$month-$day"
      GROUP BY cat.category_id;
    ''';
    print("$year-$month-$day");
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
  Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_database2.db'));
  String query = '';

  query = '''
    SELECT cat.name, cat.colour, cat.category_id
      FROM tblCategory as cat
      GROUP BY cat.category_id
      ORDER BY cat.name;
  ''';

  List<Map<String, dynamic>> categories = await database.rawQuery(query);

  List<List<String>> categoryList = [];

  categories.forEach((category) {
    String name = category['name'];
    String colour = category['colour'];
    String categoryId = category['category_id'].toString();
    categoryList.add([name, colour, categoryId]);
  });
  print(categoryList);
  return categoryList;
}

Future<void> addCategoryToDatabase(String categoryName, String categoryColour) async {
  // Получаем путь к базе данных
  Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_database2.db'));

  String query = 'INSERT INTO tblCategory(name, colour) VALUES("$categoryName", "$categoryColour")';

  await database.transaction((txn) async {
    await txn.rawInsert(query);
  });
}

Future<void> deleteCategory(String categoryId) async {
  // Получаем путь к базе данных
  Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_database2.db'));

  // Обновляем записи в таблице tblWaste, привязанные к удаляемой категории
  String updateQuery = 'UPDATE tblWaste SET category_id = 1 WHERE category_id = "$categoryId"';
  await database.transaction((txn) async {
    await txn.rawUpdate(updateQuery);
  });

  String query = 'DELETE FROM tblCategory WHERE category_id = "$categoryId"';
  await database.transaction((txn) async {
    await txn.rawDelete(query);
  });
}


Future<void> editCategory(int categoryId, String categoryName, String categoryColour) async {
  // Получаем путь к базе данных
  Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_database2.db'));

  await database.update(
    'tblCategory',
    {
      'name': categoryName,
      'colour': categoryColour,
    },
    where: 'category_id = $categoryId'
  );

}


Future<Map<String, List<List<String>>>> getCategoryWasteList(int categoryId) async {
  // Ваш существующий код для получения данных из базы
  Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_database2.db'));
  String query = '''
      SELECT w.sum, w.date, w.description, w.waste_id 
      FROM tblWaste as w 
      JOIN tblCategory as cat ON cat.category_id = w.category_id 
      WHERE w.category_id = "$categoryId"
      ORDER BY w.date DESC;
  ''';

  List<Map<String, dynamic>> categories = await database.rawQuery(query);

  // Преобразование данных в список
  List<List<String>> categoryList = [];
  categories.forEach((category) {
    String sum = category['sum'].toString();
    String date = (category['date']);
    List<String> dateParts = date.split("-");
    // Форматируем дату
    String formatedDate = "${dateParts[2]}.${dateParts[1]}.${dateParts[0]}";
    String description = category['description'];
    String wasteId = category['waste_id'].toString();
    categoryList.add([sum, formatedDate, description, wasteId]);
  });

  // Группировка данных по дате
  Map<String, List<List<String>>> groupedData = {};
  categoryList.forEach((category) {
    String sum = category[0];
    String date = category[1];
    String description = category[2];
    String wasteId = category[3].toString();
    if (groupedData.containsKey(date)) {
      groupedData[date]!.add([sum, date, description, wasteId]);
    } else {
      groupedData[date] = [[sum, date, description, wasteId]];
    }
  });
  print(groupedData);
  return groupedData;
}

