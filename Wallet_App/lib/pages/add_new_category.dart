import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key, required this.title});

  final String title;

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  @override
  Color currentChosenColor = Color(0xFFD2C8FF);
  Color currentColor = Colors.purple;
  List<Color> currentColors = [Colors.yellow, Colors.red];
  bool showColorPicker = false;
  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);
  void changeChosenColor(Color color) {
    setState(() {
      currentChosenColor = color;
      showColorPicker = false;
    });
  }

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
            'Новая категория',
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
                      'Какую категорию вы бы хотели добавить?',
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
                            'Текущий цвет',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF160E73),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (showColorPicker)
                    Container(
                      height: 275,
                      margin: EdgeInsets.symmetric(
                          vertical: 20.0),
                      child: MaterialPicker(
                        pickerColor: currentColor,
                        onColorChanged: changeColor,
                      ),
                    ),
                ],
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFD2C8FF),
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    color: Color(0xFF160E73),
                  ),
                ),
                padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Создать',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF160E73),
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
