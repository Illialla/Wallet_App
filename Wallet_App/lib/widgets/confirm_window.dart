import 'package:flutter/material.dart';
import 'package:wallet_app/db_controllers/categories_data.dart';
import 'package:wallet_app/db_controllers/waste_data.dart';
import 'package:wallet_app/pages/main_page.dart';

class ConfirmWindow extends StatefulWidget {
  final String index;
  final String type;

  ConfirmWindow(this.index, this.type);

  @override
  _ConfirmWindowState createState() => _ConfirmWindowState();
}

class _ConfirmWindowState extends State<ConfirmWindow> {
  @override
  Widget build(BuildContext context) {
    String message = '';
    if (widget.type == 'category')
      message = 'Вы действительно хотите удалить эту категорию?';
    if (widget.type == 'waste')
      message = 'Вы действительно хотите удалить эту трату?';
    return AlertDialog(
      content: Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21,
            ),
          )),
      actions: [
        TextButton(
            onPressed: () {
              // Remove the box
              if (widget.type == 'category')
                deleteCategory(widget.index);
              if (widget.type == 'waste')
                deleteWaste(widget.index);

              // Close the dialog
              // setState(() {});
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(
                            title: 'Wallet App',
                            selectedIdx: 1,
                          )));
              setState(() {});
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
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => MainScreen(
              //               title: 'Wallet App',
              //               selectedIdx: 1,
              //             )));
              Navigator.pop(context);
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
