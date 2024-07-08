import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:wallet_app/db_controllers/categories_data.dart';
import 'package:wallet_app/pages/categories_page.dart';
import 'package:wallet_app/pages/main_page.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key, required this.title});
  static int chosenIdx = 1;
  final String title;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override

  Widget build(BuildContext context) {
    final dynamic categoryId = ModalRoute.of(context)!.settings.arguments;
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
              'Новая категория',
              style:
                  TextStyle(color: Color(0xFF160E73)), // Цвет текста заголовка
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Возвращение на предыдущую страницу
              },
            ),
          ),
          body: Center(
            child: Text('Test page!'),
          )
          // body: SingleChildScrollView(
          //     child: Center(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: <Widget>[
          //           Container(
          //             margin: EdgeInsets.fromLTRB(35, 30, 35, 20),
          //             child: Column(
          //               children: <Widget>[
          //                 Text(
          //                   'Какую категорию вы бы хотели добавить?',
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 23,
          //                     color: Color(0xFF160E73),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             margin:
          //             EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          //             height: 50,
          //             width: 200,
          //             decoration: BoxDecoration(
          //               color: Color(0xFFD2C8FF),
          //               borderRadius: BorderRadius.circular(25.0),
          //               border: Border.all(
          //                 color: Color(0xFF160E73),
          //               ),
          //             ),
          //             padding:
          //             EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          //             child: GestureDetector(
          //               onTap: () {
          //                 setState(() {
          //                   Navigator.pushReplacement(
          //                     context,
          //                     MaterialPageRoute(
          //                       builder: (context) => MainScreen(
          //                           title: 'Wallet App',
          //                       ),
          //                     ),
          //                   );
          //                   // _MainScreenState mainScreenState = context.findAncestorStateOfType<MainScreen>(); // Получаем экземпляр состояния MainScreen
          //                   // mainScreenState._onItemTapped(1); // Переключение на CategoriesPage
          //                 });
          //               },
          //               child: Align(
          //                 alignment: Alignment.center,
          //                 child: FittedBox(
          //                   fit: BoxFit.scaleDown,
          //                   child: Text(
          //                     'Создать',
          //                     style: TextStyle(
          //                       fontSize: 20,
          //                       color: Color(0xFF160E73),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     )),

          ),
    );
  }
}
