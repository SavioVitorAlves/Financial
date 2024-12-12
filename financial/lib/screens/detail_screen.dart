import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Compras Parceladas',
          style:
              TextStyle(color: Color.fromARGB(255, 2, 19, 119), fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.monetization_on_outlined,
                      size: 30,
                      color: Color.fromARGB(255, 2, 19, 119),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '8,420.00',
                      style: TextStyle(
                          color: Color.fromARGB(255, 2, 19, 119),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Compras Recente',
                    style: TextStyle(
                        color: Color.fromARGB(255, 2, 19, 119),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(50, 158, 158, 158),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue,
                        ),
                        child: const Center(
                          child: Text(
                            'N',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nome da Loja',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 2, 19, 119))),
                          Text('R\$ 25.00',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 2, 19, 119))),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.remove_circle,
                            size: 35,
                            color: Color.fromARGB(255, 2, 19, 119),
                          ))
                    ],
                  ),
                ),

                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    backgroundColor: const Color.fromARGB(255, 2, 19, 119),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Ação do botão
                  },
                  child: const Text('Adicionar Loja',
                      style: TextStyle(color: Colors.white)),
                ), // ,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
