import 'package:flutter/material.dart';

Future<bool> customAlertDialog({
  required BuildContext context,
  required String alertTitle,
  required String alertContent,
  required String yesButtonTitle,
  required String noButtonTitle,
}) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(alertTitle),
          content: Text(alertContent),
          actions: [
            TextButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Color(0xFF06234C))),
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                noButtonTitle,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red)),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                yesButtonTitle,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ) ??
      false;
}
