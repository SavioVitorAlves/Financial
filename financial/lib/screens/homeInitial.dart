import 'package:financial/widgets/funcionalidades.dart';
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
              height: MediaQuery.of(context).size.height * .25,
              width: double.infinity,
              color: const Color.fromARGB(255, 2, 19, 119),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.monetization_on_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          '8,420.00',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(90, 10),
                              backgroundColor:
                                  const Color.fromARGB(120, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            // Ação do botão
                          },
                          child: const Text('ADD+',
                              style: TextStyle(color: Colors.white)),
                        ), // Botão no
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(120, 255, 255, 255),
                          ),
                          child: const Icon(
                            Icons.crisis_alert_outlined,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Aqui ficara uma recomendação!',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .75,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Operações',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Funcionalidades(
                            name: 'Emprestado',
                            url: 'lib/assets/imgs/transacao.png'),
                        Funcionalidades(
                            name: 'Parcelado',
                            url: 'lib/assets/imgs/moeda.png'),
                        Funcionalidades(
                            name: 'Cartões', url: 'lib/assets/imgs/cartao.png'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Operações Recentes',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
