import 'package:flutter/material.dart';
import 'package:wallet_app/db_controllers/categories_data.dart';

class DonutChart extends StatelessWidget {
  final String dayString;
  final String monthString;
  final String currentYear;
  final String _selectedBlock;

  DonutChart(this.dayString, this.monthString, this.currentYear, this._selectedBlock);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategoryList(dayString, monthString, currentYear.toString(), _selectedBlock),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<List<String>> categoryList = snapshot.data as List<List<String>>;

          List<double> divisions = [];
          List<Color> colors = [];

          for (List<String> categoryData in categoryList) {
            divisions.add(double.parse(categoryData[2]));
            // print(divisions);
            colors.add(Color(int.parse(categoryData[1])));
          }

          return Center(
            child: Stack(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: CustomPaint(
                    painter: DonutChartPainter(
                      divisions: divisions, // Передаем данные для деления диаграммы
                      colors: colors, // Передаем цвета для делений
                      total: categoryList.fold<double>(0, (sum, item) => sum + double.parse(item[2])).toDouble(),
                    ),
                  ),
                ),
              ],
            ),
          );

        } else {
          return Center(
            child: CircularProgressIndicator(), // Индикатор загрузки, пока данные загружаются
          );
        }
      },
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final List<double> divisions;
  final List<Color> colors;
  final double total;

  DonutChartPainter({required this.divisions, required this.colors, required this.total});

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = 0.0;
    double outerRadius = size.width / 1.7;
    double innerRadius = size.width / 2.5; // Диаметр в 1.5 раза меньше

    for (int i = 0; i < divisions.length; i++) {
      double sweepAngle = divisions[i] / total * 2 * 3.14;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: outerRadius),
        startAngle,
        sweepAngle,
        true,
        Paint()..color = colors[i],
      );
      startAngle += sweepAngle;
    }

    // Рисуем внешнюю рамку
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      outerRadius,
      Paint()
        ..color = Color(0xFF160E73) // Прозрачный цвет рамки
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5, // Толщина рамки 1 пиксель
    );

    // Рисуем белый круг
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      innerRadius,
      Paint()..color = Colors.white,
    );

    // Рисуем внутреннюю рамку
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      innerRadius,
      Paint()
        ..color = Color(0xFF160E73) // Прозрачный цвет рамки
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5, // Толщина рамки 1 пиксель
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
