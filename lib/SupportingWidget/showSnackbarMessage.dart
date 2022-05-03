import 'package:flutter/material.dart';

showSnackbarMessage(context, String message,
    {Color color = Colors.black,
    Duration duration = const Duration(seconds: 3)}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: duration,
    ),
  );
}
