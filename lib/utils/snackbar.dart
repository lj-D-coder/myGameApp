import 'package:flutter/material.dart';

void showSnackBar(context, msg) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

void clearSnackBar(context) {
  ScaffoldMessenger.of(context).clearSnackBars();
}
