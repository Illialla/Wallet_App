import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<List<List<String>>> getCategoriesForWaste() async {
  Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_database2.db'));
  String query = '';

  query = '''
      SELECT DISTINCT c.name, c.category_id
      FROM tblCategory as c;
  ''';

  List<Map<String, dynamic>> categories = await database.rawQuery(query);

  List<List<String>> categoryList = [];

  categories.forEach((category) {
    String name = category['name'];
    String categoryId = category['category_id'].toString();
    categoryList.add([name, categoryId]);
  });
  print(categoryList);
  return categoryList;
}

Future<void> addWasteToDatabase(String categoryId, String wasteDate, String wasteDescription, String wastePrice) async {
  // Получаем путь к базе данных
  Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_database2.db'));

  String query = 'INSERT INTO tblWaste(category_id, sum, date, description) '
      'VALUES("$categoryId", "$wastePrice", "$wasteDate", "$wasteDescription")';

  await database.transaction((txn) async {
    await txn.rawInsert(query);
  });
}
//
// Future<void> deleteCategory(String categoryId) async {
//   // Получаем путь к базе данных
//   Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_database.db'));
//
//   String query = 'DELETE FROM tblCategory WHERE category_id = "$categoryId"';
//
//   await database.transaction((txn) async {
//     await txn.rawDelete(query);
//   });
// }
//
//
// Future<void> editCategory(int categoryId, String categoryName, String categoryColour) async {
//   // Получаем путь к базе данных
//   Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_database.db'));
//
//   await database.update(
//     'tblCategory',
//     {
//       'name': categoryName,
//       'colour': categoryColour,
//     },
//     where: 'category_id = $categoryId'
//   );
//
// }
//
//
// Future<List<List<String>>> getCategoryWasteList(int categoryId) async {
//   Database database = await openDatabase(join(await getDatabasesPath(), 'wallet_database.db'));
//   String query = '';
//
//   query = '''
//     SELECT w.sum, w.date, w.description
//       FROM tblWaste as w
//       JOIN tblCategory as cat ON cat.category_id = w.category_id
//       WHERE w.category_id = "$categoryId";
//   ''';
//
//   List<Map<String, dynamic>> categories = await database.rawQuery(query);
//   print(categories);
//   List<List<String>> categoryList = [];
//
//   categories.forEach((category) {
//     String sum = category['sum'].toString();
//     String date = category['date'];
//     String description = category['description'];
//     categoryList.add([sum, date, description]);
//   });
//
//   print(categoryList);
//   return categoryList;
//
//
// }
