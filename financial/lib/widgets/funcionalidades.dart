import 'package:flutter/material.dart';

class Funcionalidades extends StatelessWidget {
  final String url;
  final String name;
  const Funcionalidades({required this.name, required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue, width: 2.0)),
        child: Column(
          children: [
            Container(height: 70, width: 70, child: Image.asset(url)),
            Text(name),
          ],
        ),
      ),
    );
  }
}
