import 'package:flutter/material.dart';
import 'package:wallet_app/db_controllers/categories_data.dart';
import 'package:wallet_app/pages/main_page.dart';

class ConfirmWindow extends StatelessWidget {
  final String categoryId;
  ConfirmWindow(this.categoryId);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            'Вы действительно хотите удалить эту категорию?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21,
            ),
          )),
      actions: [
        TextButton(
            onPressed: () {
              // Remove the box
              deleteCategory(categoryId);

              // Close the dialog
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(
                            title: 'Wallet App',
                            selectedIdx: 1,
                          )));
            },
            child: const Text(
              'Да',
              style: TextStyle(
                fontSize: 19,
              ),
            )),
        TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(
                            title: 'Wallet App',
                            selectedIdx: 1,
                          )));
            },
            child: const Text(
              'Нет',
              style: TextStyle(
                fontSize: 19,
              ),
            ))
      ],
    );
  }
}