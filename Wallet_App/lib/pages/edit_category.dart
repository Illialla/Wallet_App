import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:wallet_app/db_controllers/categories_data.dart';
import 'package:wallet_app/pages/categories_page.dart';
import 'package:wallet_app/pages/main_page.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({super.key, required this.title});

  final String title;

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  @override
  String categoryName = '';
  String categoryColour = '';
  Color currentColor = Color(0xFFD2C8FF);
  List<Color> currentColors = [Colors.yellow, Colors.red];
  bool showColorPicker = false;
  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);
  void changeChosenColor(Color color) {
    setState(() {
      currentColor = color;
      // showColorPicker = false;
    });
  }

  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    // print(arguments);

    String? categoryId = arguments?['categoryId'] as String?;
    int newCategoryId = int.tryParse(categoryId ?? '') ?? 0;
    String? currentCategoryName = arguments?['categoryName'] as String?;
    String? currentCategoryColour = arguments?['categoryColour'] as String?;
    // currentColor == Color(int.tryParse(currentCategoryColour ?? '') ?? 0);
    // print("Тут $currentColor");
    TextEditingController textController =
        TextEditingController(text: currentCategoryName);

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
          title: const Text(
            'Редактирование категории',
            style: TextStyle(color: Color(0xFF160E73)), // Цвет текста заголовка
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Возвращение на предыдущую страницу
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(35, 30, 35, 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Как бы вы хотели изменить название категории?',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                        color: Color(0xFF160E73),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: TextField(
                    controller: textController,
                    onChanged: (value) {
                      categoryName =
                          value; // Сохраняем введённое пользователем название категории
                    },
                    decoration: InputDecoration(
                      // border: OutlineInputBorder(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                      hintText: 'Название категории',
                    ),
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(35, 10, 35, 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Выберите цвет категории',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 23,
                              color: Color(0xFF160E73),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showColorPicker = !showColorPicker;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      height: 50,
                      decoration: BoxDecoration(
                        color: currentColor,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Color(0xFF160E73),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            ' ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF919191),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (showColorPicker)
                    Container(
                      height: 275,
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      child: MaterialPicker(
                        pickerColor: currentColor,
                        onColorChanged: changeColor,
                      ),
                    ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 50, 30, 10),
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFD2C8FF),
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    color: Color(0xFF160E73),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      categoryColour = currentColor.toString().substring(6, 16);
                      print("Конечный цвет $categoryColour");
                      print("Конечное название $categoryName");
                      print("Конечный айди $newCategoryId");
                      editCategory(newCategoryId, categoryName, categoryColour);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesPage(title: 'Wallet App')));


                      // _MainScreenState mainScreenState = context.findAncestorStateOfType<MainScreen>(); // Получаем экземпляр состояния MainScreen
                      // mainScreenState._onItemTapped(1); // Переключение на CategoriesPage
                    });
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Обновить',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF160E73),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
