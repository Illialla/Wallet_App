import 'package:flutter/material.dart';
import 'package:wallet_app/db_controllers/categories_data.dart';
import 'package:wallet_app/db_controllers/waste_data.dart';
import 'package:wallet_app/pages/categories_page.dart';
import 'package:wallet_app/pages/main_page.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class AddWaste extends StatefulWidget {
  const AddWaste({super.key, required this.title});

  final String title;

  @override
  State<AddWaste> createState() => _AddWasteState();
}

class _AddWasteState extends State<AddWaste> {
  @override
  // String wasteDate = '';
  // DateTime wasteDate = DateTime.now();
  DateTime wasteDate = DateTime.now();
  String formattedDate = 'Выберите дату';
  String saveDate = '';
  String wastePrice = '';
  String wasteDescription = '';
  String? wasteCategory = '';
  void reformatDate(DateTime wasteDate) {
    initializeDateFormatting('ru').then((_) {
      formattedDate = DateFormat('dd MMMM yyyy', 'ru').format(wasteDate);
      // formattedDate = formattedDate.split(" ")[0];
      saveDate = DateFormat('yyyy-MM-dd', 'ru').format(wasteDate);
      print("1 var - $formattedDate");
      print("2 var - $saveDate");
    });
  }

  // List<String> data = getCategoriesForWaste();

  // String? _selectedValue = 'Вариант 1';
  // List<String> categories = [
  //   'Категория 1',
  //   'Категория 2',
  //   'Категория 3'
  // ];
  List<String> categories = [];
  List<String> categoriesIdx = [];

  Future<List<String>> getData() async {
    List<List<String>> data = await getCategoriesForWaste();
    List<String> idxList = [];
    List<String> nameList = [];
    print("data: $data");
    for (var value in data) {
      nameList.add(value[0]);
      idxList.add(value[1]);
    }
    // categories = nameList;
    categoriesIdx = idxList;
    return nameList;
  }
  // String dropdownValue = categories.first;
  // String categoryColour = '';
  // Color currentColor = Color(0xFFD2C8FF);
  // List<Color> currentColors = [Colors.yellow, Colors.red];
  // bool showColorPicker = false;
  // void changeColor(Color color) => setState(() => currentColor = color);
  // void changeColors(List<Color> colors) =>
  //     setState(() => currentColors = colors);
  // void changeChosenColor(Color color) {
  //   setState(() {
  //     currentColor = color;
  //     // showColorPicker = false;
  //   });
  // }

  Widget build(BuildContext context) {
    // categories = getData();
    // String? _selectedValue = categories[0];
    return FutureBuilder<List<String>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Показываем индикатор загрузки, пока данные загружаются
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              categories = snapshot.data!;
              print("Категории: $categories");
              print("Айдишники: $categoriesIdx");
              String? _selectedValue = null; // Теперь данные доступны для использования
              int? selectedIndex;
              void initState() {
                super.initState();
                _selectedValue = categories.isNotEmpty
                    ? categories[0]
                    : null; // установка начального выбранного значения
              }

              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
                  useMaterial3: true,
                ),
                // routes: {
                //   '/mainPage': (context) => MainScreen(title: 'Wallet App'),
                // },
                home: Scaffold(
                  // home: const MyHomePage(title: 'Wallet App'),
                  // extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    backgroundColor:
                        const Color(0xFFD2C8FF), // Цвет фона заголовка
                    title: const Text(
                      'Новая трата',
                      style: TextStyle(
                          color: Color(0xFF160E73)), // Цвет текста заголовка
                    ),
                  ),
                  body: SingleChildScrollView(
                      child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(35, 30, 35, 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Что это была за трата?',
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
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: TextField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            onChanged: (value) {
                              wasteDescription =
                                  value; // Сохраняем введённое пользователем название категории
                            },
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20),
                              hintText: 'Описание',
                              hintStyle: TextStyle(fontSize: 19),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(35, 30, 35, 20),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'К какой категории она относится?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23,
                                  color: Color(0xFF160E73),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(35, 0, 35, 0),
                            child: DropdownButtonFormField<String>(
                              value: _selectedValue,
                              hint: Text('Выберите категорию', style: TextStyle(fontSize: 19),),
                              onChanged: (String? newValue) {
                                _selectedValue = newValue;
                                selectedIndex = categories.indexOf(newValue!); // получаем индекс выбранного элемента
                                print("selected: $_selectedValue, index: $selectedIndex");
                                wasteCategory = _selectedValue;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF919191), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF919191), width: 1),
                                ),
                              ),
                              // onSaved: (String? value) {
                              //   setState(() {
                              //     wasteCategory = value;
                              //     print(wasteCategory);
                              //   });
                              // },
                              validator: (String? value) {
                                if (value == null) {
                                  return 'Please select an option';
                                }
                                return null;
                              },
                              items: categories.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(35, 30, 35, 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Когда она произошла?',
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
                        margin: EdgeInsets.fromLTRB(35, 5, 35, 15),
                        child: Column(
                          children: <Widget>[
                            StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return InkWell(
                                  onTap: () async {
                                    final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                    );

                                    if (selectedDate != null) {
                                      setState(() {
                                        wasteDate = selectedDate;
                                        reformatDate(wasteDate);
                                        print("Мы выбрали дату: $wasteDate");
                                      });
                                    }
                                  },
                                  child: Text(
                                    '${formattedDate}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Color(0xFF919191),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
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
                                      'Сколько денег Вы потратили?',
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
                        Row(
                            children: <Widget>[
                          Expanded(
                            flex: 7,
                              child: Container(
                            margin: EdgeInsets.fromLTRB(35, 0, 10, 30),
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                wastePrice =
                                    value; // Сохраняем введённое пользователем название категории
                              },
                              decoration: InputDecoration(
                                // border: OutlineInputBorder(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20),
                                hintText: '100',
                                hintStyle: TextStyle(fontSize: 19),
                              ),
                            ),
                          )),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 35, 30),
                                      child: Text(
                                    "руб.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),

                                  ))
                              )
                            ]),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 100.0, vertical: 10.0),
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Color(0xFFD2C8FF),
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                              color: Color(0xFF160E73),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // categoryColour = currentColor.toString().substring(6, 16);
                                print("Данные: ${categoriesIdx[selectedIndex!]}, $saveDate, $wastePrice, $wasteDescription");
                                addWasteToDatabase(categoriesIdx[selectedIndex!], saveDate, wasteDescription, wastePrice);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen(
                                            title: 'Wallet App', selectedIdx: 0,)));
                                // Navigator.pushNamed(context, '/mainPage', arguments:{
                                // },);
                                // _MainScreenState mainScreenState = context.findAncestorStateOfType<MainScreen>(); // Получаем экземпляр состояния MainScreen
                                // mainScreenState._onItemTapped(1); // Переключение на CategoriesPage
                              });
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Добавить',
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
        });
  }
}
