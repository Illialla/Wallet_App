import 'package:flutter/material.dart';
import 'package:wallet_app/pages/main_page.dart';
import 'package:wallet_app/data_base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Создай базу данных перед запуском приложения:
  await createDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // createDatabase();
    return MaterialApp(
      title: 'Wallet App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
        useMaterial3: true,
      ),
      home: const MainScreen(title: 'Wallet App', selectedIdx: 0),
    );
  }
}
