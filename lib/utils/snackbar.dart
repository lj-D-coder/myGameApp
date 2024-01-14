import 'package:flutter/material.dart';

void showSnackBar(context, msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
