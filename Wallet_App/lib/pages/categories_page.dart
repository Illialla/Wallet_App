import 'package:flutter/material.dart';
import 'package:wallet_app/db_controllers/categories_data.dart';
import 'package:wallet_app/pages/add_new_category.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.title});

  final String title;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String _selectedBlock = 'month'; // По умолчанию выбран блок 'Месяц'

  Map<String, String> months = {
    '01': 'январь',
    '02': 'февраль',
    '03': 'март',
    '04': 'апрель',
    '05': 'май',
    '06': 'июнь',
    '07': 'июль',
    '08': 'август',
    '09': 'сентябрь',
    '10': 'октябрь',
    '11': 'ноябрь',
    '12': 'декабрь'
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
          useMaterial3: true,
        ),
        home: Scaffold(
            // home: const MyHomePage(title: 'Wallet App'),
            // extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: const Color(0xFFD2C8FF), // Цвет фона заголовка
              title: const Text(
                'Категории',
                style: TextStyle(
                    color: Color(0xFF160E73)), // Цвет текста заголовка
              ),
            ),
            body: SingleChildScrollView(
    child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 15.0),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: Text(
                          'Ваши категории',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 29,
                            color: Color(0xFF160E73),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddCategory(title: 'Wallet App')),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFD2C8FF),
                            borderRadius: BorderRadius.circular(13.0),
                            border: Border.all(
                              color: Color(0xFF160E73),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '+',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Color(0xFF160E73),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])),

                Container(
                  child: FutureBuilder<List<List<String>>>(
                    future: getCategoryListForShow(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: snapshot.data!.map((category) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 8,
                                        child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF0EDFF),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomLeft:
                                                    Radius.circular(20)),
                                            border: Border.all(
                                              color: Color(0xFF160E73),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 25.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                category[0],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF160E73),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(category[1])),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                            border: Border.all(
                                              color: Color(0XFF160E73),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        }
                      }
                    },
                  ),
                ),
                // Container(
                //   child: Align(
                //     alignment: Alignment.bottomCenter,
                //     // alignment: Alignment.bottomRight,
                //     child: Container(
                //       margin: EdgeInsets.only(bottom: 20.0),
                //       // margin: EdgeInsets.fromLTRB(0, 20, 30, 20.0),
                //       height: 60,
                //       width: 60,
                //       decoration: BoxDecoration(
                //         color: Color(0xFFD2C8FF),
                //         borderRadius: BorderRadius.circular(30.0),
                //         border: Border.all(
                //           color: Color(0xFF160E73),
                //         ),
                //       ),
                //       child: Align(
                //         alignment: Alignment.center,
                //         child: FittedBox(
                //           fit: BoxFit.scaleDown,
                //           child: Text(
                //             '+',
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 30,
                //               color: Color(0xFF160E73),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Container(
                //   margin:
                //       EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                //   height: 55,
                //   // width: 250,
                //   decoration: BoxDecoration(
                //     color: Color(0xFFD2C8FF),
                //     borderRadius: BorderRadius.circular(15.0),
                //     border: Border.all(
                //       color: Color(0xFF160E73),
                //     ),
                //   ),
                //   padding:
                //       EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                //   child: Align(
                //     alignment: Alignment.center,
                //     child: FittedBox(
                //       fit: BoxFit.scaleDown,
                //       child: Text(
                //         'Добавить категорию',
                //         style: TextStyle(
                //           fontSize: 20,
                //           color: Color(0xFF160E73),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            )))));
  }
}
