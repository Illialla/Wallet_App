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
              'Траты в категории $categoryName',
              style:
                  TextStyle(color: Color(0xFF160E73)), // Цвет текста заголовка
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, '/categoriesPage', arguments:{
                },); // Возвращение на предыдущую страницу
              },
            ),
          ),
          body: SingleChildScrollView(
              child: Center(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Text('Selected category ID: $categoryId'),
              Container(
                  child: FutureBuilder<List<List<String>>>(
                      future: getCategoryWasteList(newCategoryId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Показываем индикатор загрузки, пока данные загружаются
                        } else {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            if (snapshot.data == null) {
                              return Text(
                                  'No data available'); // Если данные не загружены, показываем сообщение
                            } else {
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: snapshot.data!.map((category) {
                                    return Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(0xFF919191),
                                            ),
                                          ),
                                        ),

                                        child: Column(children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  20, 25, 20, 5),
                                              child: Text(
                                                  "${category[1]}",
                                                  style: TextStyle(
                                                    fontSize: 23,
                                                    color: Color(0xFF160E73),
                                                    fontWeight: FontWeight.w500
                                                  )))),
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(20, 5, 20, 5),
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child: Row(children: <Widget>[
                                            Expanded(
                                              flex:7,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    "${category[2]}",
                                                    style: TextStyle(
                                                      fontSize: 19,
                                                      color: Color(0xFF160E73),
                                                    ))),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text("${category[0]}",
                                                    style: TextStyle(
                                                      fontSize: 19,
                                                      color: Color(0xFF160E73),
                                                    ))),
                                              ),
                                            ),
                                          ])),
                                        Container(
                                          margin: EdgeInsetsDirectional.only(top: 10),
                                          width: double.infinity,
                                          height: 1,
                                        )
                                    ]));
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
