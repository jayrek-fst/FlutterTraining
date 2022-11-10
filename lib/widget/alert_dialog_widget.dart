import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget(
      {Key? key, this.title = '', required this.message, this.widgetActions})
      : super(key: key);

  final String title;
  final String message;
  final List<Widget>? widgetActions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        content: Text(message, style: const TextStyle(fontSize: 14)),
        actions: widgetActions);
  }
}
