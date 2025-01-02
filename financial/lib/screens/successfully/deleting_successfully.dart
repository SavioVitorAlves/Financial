import 'package:financial/utils/app_routes.dart';
import 'package:flutter/material.dart';

class DeletingSuccessfully extends StatelessWidget {
  const DeletingSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 2, 19, 119),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.verified_rounded,
              color: Colors.blueAccent,
              size: 200,
            ),
            const Column(
              children: [
                Text(
                  'Deletado',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'com Sucesso',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.HOME,
                  (route) => false,
                );
              },
              child: const Text('Continuar',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
