import 'package:flutter/material.dart';

class Homeinitial extends StatelessWidget {
  const Homeinitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .3,
              width: double.infinity,
              color: const Color.fromARGB(255, 2, 19, 119),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: const Icon(
                        Icons.monetization_on_outlined), // Ícone inicial
                    title: const Text(
                      '8,420.00',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ), // Título no meio
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(50, 20),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        // Ação do botão
                      },
                      child: const Text('ADD+'),
                    ), // Botão no final
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Container(
                        color: Colors.white,
                        child: const Icon(Icons.crisis_alert_outlined),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Aqui ficara uma recomendação!')
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
