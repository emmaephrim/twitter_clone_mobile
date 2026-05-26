import 'package:flutter/material.dart';

class FirstScreeen extends StatelessWidget {
  final String name;
  const FirstScreeen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello!, $name"),
        centerTitle: true,
        elevation: 20.0,
      ),
    );
  }
}
