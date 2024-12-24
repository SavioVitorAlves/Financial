import 'package:financial/services/db_data.dart';
import 'package:financial/utils/app_routes.dart';
import 'package:financial/widgets/loja_form.dart';

import 'package:financial/widgets/widget_loja.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Parcelado extends StatefulWidget {
  const Parcelado({super.key});

  @override
  State<Parcelado> createState() => _ParceladoState();
}

class _ParceladoState extends State<Parcelado> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<DbData>(context, listen: false).loadLojas();
  }

  _openStoreFormModal(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => const LojaForm());
  }

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
      body: Consumer<DbData>(
        builder: (context, compras, child) {
          final lojas = compras.lojas;
          print('Lojas: $lojas');
          return Center(
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
                      height: 400,
                      child: lojas.isEmpty
                          ? const Center(
                              child: Text(
                                'Nenhuma loja registrada.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: lojas.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: WidgetLoja(
                                    loja: lojas[index],
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.DETAIL_LOJA_SCREEN,
                                        arguments: lojas[index]);
                                  },
                                );
                              }),
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
                      onPressed: () => _openStoreFormModal(
                        context,
                      ),
                      child: const Text('Adicionar Loja',
                          style: TextStyle(color: Colors.white)),
                    ), // ,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
