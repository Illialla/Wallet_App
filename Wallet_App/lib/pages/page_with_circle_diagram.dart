import 'package:flutter/material.dart';
import 'package:wallet_app/widgets/diagram_widget.dart';
import 'package:wallet_app/db_controllers/categories_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  DateTime now = DateTime.now();
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int currentYear = DateTime.now().year;
  // int currentYearForMonth = DateTime.now().year;
  int currentMonthIndex = DateTime.now().month-1; // Индекс текущего месяца (май)
  int initialDay = DateTime.now().day;
  int initialMonth = DateTime.now().month;
  int initialYear = DateTime.now().year;

  void resetDateValues() {
    setState(() {
      now = DateTime.now();
      day = initialDay;
      month = initialMonth;
      currentYear = initialYear;
      // currentYearForMonth = initialYear;
      currentMonthIndex = initialMonth - 1;
    });
  }


  void nextDay() {
    setState(() {
      now = now.add(Duration(days: 1)); // Перемещаемся на 1 день вперед
      day = now.day;
      month = now.month;
      currentYear = now.year;
      // currentYearForMonth = now.year;
      currentMonthIndex = now.month - 1;
    });
  }

  void previousDay() {
    setState(() {
      now = now.subtract(Duration(days: 1)); // Перемещаемся на 1 день назад
      day = now.day;
      month = now.month;
      currentYear = now.year;
      // currentYearForMonth = now.year;
      currentMonthIndex = now.month - 1;
    });
  }

  void nextMonth() {
    setState(() {
      if (currentMonthIndex < months.length - 1) {
        currentMonthIndex++;
      } else {
        currentMonthIndex = 0;
        currentYear++;
      }
    });
  }

  void previousMonth() {
    setState(() {
      if (currentMonthIndex > 0) {
        currentMonthIndex--;
      } else {
        currentMonthIndex = 11;
        currentYear--;
      }
    });
  }

  void nextYear() {
    setState(() {
      currentYear++;
      // currentYearForMonth = currentYear;
    });
  }

  void previousYear() {
    setState(() {
      currentYear--;
      // currentYearForMonth = currentYear;
    });
  }

  // String formattedDate = '${now.day}.${now.month}.${now.year}';

  @override
  Widget build(BuildContext context) {
    String currentMonthKey = months.keys.toList()[currentMonthIndex];
    // String currentMonth = months[currentMonthKey]!;
    String dayString = day < 10 ? '0$day' : day.toString();
    String monthString = month < 10 ? '0$month' : month.toString();
    print(now);
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
            'Статистика',
            style: TextStyle(color: Color(0xFF160E73)), // Цвет текста заголовка
          ),
        ),
        body: SingleChildScrollView(
    child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin:
                      EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF0EDFF),
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Color(0xFF160E73),
                    ),
                  ),
                  child: Row(children: <Widget>[
                    Expanded(
                      flex: 33,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedBlock = 'day';
                            resetDateValues();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 7),
                          decoration: BoxDecoration(
                            color: _selectedBlock == 'day'
                                ? Color(0xFFD2C8FF)
                                : Color(0xFFF0EDFF),
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: _selectedBlock == 'day'
                                  ? Color(0xFF160E73)
                                  : Colors.transparent,
                            ),
                          ),
                          child: Text(
                            'День',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF160E73),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 34,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedBlock = 'month';
                            resetDateValues();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 7),
                          decoration: BoxDecoration(
                            color: _selectedBlock == 'month'
                                ? Color(0xFFD2C8FF)
                                : Color(0xFFF0EDFF),
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: _selectedBlock == 'month'
                                  ? Color(0xFF160E73)
                                  : Colors.transparent,
                            ),
                          ),
                          child: Text(
                            'Месяц',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF160E73),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 33,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedBlock = 'year';
                            resetDateValues();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 7),
                          decoration: BoxDecoration(
                            color: _selectedBlock == 'year'
                                ? Color(0xFFD2C8FF)
                                : Color(0xFFF0EDFF),
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: _selectedBlock == 'year'
                                  ? Color(0xFF160E73)
                                  : Colors.transparent,
                            ),
                          ),
                          child: Text(
                            'Год',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF160E73),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ])),
              Container(
                margin: EdgeInsets.fromLTRB(35.0, 20.0, 35.0, 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed:
                      _selectedBlock == 'month'
                          ? previousMonth
                          : _selectedBlock == 'day'
                          ? previousDay
                          : previousYear,
                    ),
                    _selectedBlock == 'month'
                        ? Text(
                      '${months[currentMonthKey]} ${currentYear}',
                      style: TextStyle(fontSize: 23, color: Color(0xFF160E73)),
                    )
                        : _selectedBlock == 'day'
                        ? Text(
                      '${dayString}-${monthString}-${currentYear}',
                      style: TextStyle(fontSize: 23, color: Color(0xFF160E73)),
                    )
                        : Text(
                      '${currentYear} год',
                      style: TextStyle(fontSize: 23, color: Color(0xFF160E73)),
                    ), // Если _selectedBlock не равно ни 'month', ни 'day', ни 'year'
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: _selectedBlock == 'month'
                          ? nextMonth
                          : _selectedBlock == 'day'
                          ? nextDay
                          : nextYear,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 70.0),
                // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 70.0),
                child: DonutChart(day.toString(), months.keys.elementAt(currentMonthIndex),
                    currentYear.toString(), _selectedBlock),
              ),
              Container(
                child: FutureBuilder<List<List<String>>>(
                  future: getCategoryList(day.toString(), months.keys.elementAt(currentMonthIndex),
                      currentYear.toString(), _selectedBlock),
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
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF0EDFF),
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                    color: Color(0xFF160E73),
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 7,
                                      child: Container(
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
                                    Container(
                                      width: 1.0,
                                      height: 55,
                                      color: Color(0xFF160E73),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(int.parse(category[1])),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15.0),
                                            bottomRight: Radius.circular(15.0),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 10.0),
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  category[2],
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFF160E73),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
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
            ],
          ),
        ),)
      ),
    );
  }
}
