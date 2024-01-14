import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 50,
          width: 50,
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
