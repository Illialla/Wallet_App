import 'package:flutter/material.dart';
import 'package:wallet_app/pages/page_with_circle_diagram.dart';
import 'package:wallet_app/pages/categories_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    MyHomePage(title: 'Wallet App'), // Главная страница
    CategoriesPage(title: 'Wallet App') // Страница добавления траты
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // home: const MyHomePage(title: 'Wallet App'),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Категории',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF160E73), // Цвет выбранного пункта
          onTap: _onItemTapped,
        ),

      ),
    );
  }
}
