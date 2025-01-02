import 'package:financial/models/pessoa.dart';
import 'package:financial/widgets/credito_form.dart';
import 'package:financial/widgets/emprestado_form.dart';
import 'package:financial/widgets/widget_card.dart';
import 'package:financial/widgets/widget_credito.dart';
import 'package:financial/widgets/widget_emprestado.dart';
import 'package:financial/widgets/widget_pessoa.dart';
import 'package:financial/models/card.dart' as custom_card;
import 'package:flutter/material.dart';

class DetailCartaoScreen extends StatefulWidget {
  const DetailCartaoScreen({super.key});

  @override
  State<DetailCartaoScreen> createState() => _DetailCartaoScreenState();
}

class _DetailCartaoScreenState extends State<DetailCartaoScreen> {
  _openCreditoFormModal(BuildContext context, int id) {
    showModalBottomSheet(
        context: context,
        builder: (_) => CreditoForm(
              id: id,
            ));
  }

  @override
  Widget build(BuildContext context) {
    custom_card.Card card =
        ModalRoute.of(context)!.settings.arguments as custom_card.Card;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          card.name, // nome do cartao vindo do bando de dados no appBar
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
                  height: 500,
                  child: card.credito.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhum credito foi registrado.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: card.credito.length,
                          itemBuilder: (context, index) {
                            return WidgetCredito(
                              credito: card.credito[index],
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
                  onPressed: () => _openCreditoFormModal(context, card.id),
                  child: const Text('Adicionar Credito',
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
