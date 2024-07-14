import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:wallet_app/db_controllers/categories_data.dart';
import 'package:wallet_app/pages/categories_page.dart';
import 'package:wallet_app/pages/main_page.dart';

class WasteInCategory extends StatefulWidget {
  const WasteInCategory({super.key, required this.title});
  final String title;

  @override
  State<WasteInCategory> createState() => _WasteInCategoryState();
}

class _WasteInCategoryState extends State<WasteInCategory> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    String? categoryId = arguments?['categoryId'] as String?;
    String? categoryName = arguments?['categoryName'] as String?;
    String sameDayWaste = '';
    int newCategoryId = int.tryParse(categoryId ?? '') ?? 0;
    print("id $newCategoryId");

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
        useMaterial3: true,
      ),
      routes: {
        '/categoriesPage': (context) => CategoriesPage(title: 'Wallet App'),
      },
      home: Scaffold(
          // home: const MyHomePage(title: 'Wallet App'),
          // extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: const Color(0xFFD2C8FF), // Цвет фона заголовка
            title: Text(
              'Категория "$categoryName"',
              style:
                  TextStyle(color: Color(0xFF160E73)), // Цвет текста заголовка
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/categoriesPage',
                  arguments: {},
                ); // Возвращение на предыдущую страницу
              },
            ),
          ),
          body: SingleChildScrollView(
              child: Center(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Text('Selected category ID: $categoryId'),
              Container(
                  child: FutureBuilder<Map<String, List<List<String>>>>(
                      future: getCategoryWasteList(newCategoryId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Показываем индикатор загрузки, пока данные загружаются
                        } else {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            if (snapshot.data == null ||
                                snapshot.data!.isEmpty) {
                              return Container(
                                  margin: EdgeInsets.fromLTRB(50, 50, 50, 0),
                                  child: Text(
                                      'На данный момент в категории нет трат',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF919191),
                                  ),)); // Если данные не загружены, показываем сообщение
                            } else {
                              return Column(
                                  children:
                                      snapshot.data!.entries.map((category) {
                                // print("category ${category}");
                                // List<List<String>> data = category.value;
                                return Container(
                                  margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                                  // padding: EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                    // color: Color(0xFFD2C8FF),
                                    color: Color(0xFFe2dbff),
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 10, 15, 10),
                                              child: Text(
                                                category.key,
                                                style: TextStyle(
                                                    fontSize: 23,
                                                    color: Color(0xFF160E73),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ))),
                                      Column(
                                        children: category.value.map((item) {
                                          String sum = item[0];
                                          String description = item[2];
                                          return Container(
                                              decoration: BoxDecoration(
                                                // color: Color(0xFFeeebff),
                                                color: Color(0xFFeeebff),
                                                border: Border.all(width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 5, 15, 5),
                                              padding: EdgeInsets.fromLTRB(
                                                  15, 5, 15, 5),
                                              child: Row(children: <Widget>[
                                                Expanded(
                                                  flex: 75,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                            "${description}",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              color: Color(
                                                                  0xFF160E73),
                                                            ))),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 25,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text("${sum}",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              color: Color(
                                                                  0xFF160E73),
                                                            ))),
                                                  ),
                                                ),
                                              ]));
                                        }).toList(),
                                      ),
                                      SizedBox(
                                        // width: 35, // Ширина иконки
                                        height: 15,
                                      )
                                    ],
                                  ),
                                );
                                // sameDayWaste = category[1];
                              }).toList());
                            }
                          }
                        }
                      }))
            ],
          )))),
    );
  }
}
