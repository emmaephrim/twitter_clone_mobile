import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen, $name"),
        centerTitle: true,
        elevation: 20.0,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop("Comming from Second Screen");
            },
            child: Text("Pop action gun"),
          ),
        ],
      ),
    );
  }
}
