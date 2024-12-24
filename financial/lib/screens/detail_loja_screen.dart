import 'package:financial/models/loja.dart';
import 'package:financial/models/pessoa.dart';
import 'package:financial/widgets/emprestado_form.dart';
import 'package:financial/widgets/gasto_form.dart';
import 'package:financial/widgets/widget_emprestado.dart';
import 'package:financial/widgets/widget_gasto.dart';
import 'package:financial/widgets/widget_pessoa.dart';
import 'package:flutter/material.dart';

class DetailLojaScreen extends StatefulWidget {
  const DetailLojaScreen({super.key});

  @override
  State<DetailLojaScreen> createState() => _DetailLojaScreenState();
}

class _DetailLojaScreenState extends State<DetailLojaScreen> {
  _openGastosFormModal(BuildContext context, int id) {
    showModalBottomSheet(
        context: context,
        builder: (_) => GastoForm(
              id: id,
            ));
  }

  @override
  Widget build(BuildContext context) {
    Loja loja = ModalRoute.of(context)!.settings.arguments as Loja;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loja.nome, // nome da pessoa vindo do bando de dados no appBar
          style: const TextStyle(
              color: Color.fromARGB(255, 2, 19, 119), fontSize: 18),
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
                  height: 400,
                  child: loja.compra.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhuma compra foi registrada.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: loja.compra.length,
                          itemBuilder: (context, index) {
                            return WidgetGasto(
                              gasto: loja.compra[index],
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
                  onPressed: () => _openGastosFormModal(context, loja.id),
                  child: const Text('Adicionar Compra',
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
