import 'package:financial/models/emprestado.dart';
import 'package:financial/models/gasto.dart';
import 'package:financial/models/loja.dart';
import 'package:financial/models/pessoa.dart';
import 'package:financial/services/db_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetLoja extends StatelessWidget {
  final Loja loja;

  const WidgetLoja({required this.loja, super.key});

  @override
  Widget build(BuildContext context) {
    double valorTotal(List<Gasto> gasto) {
      double valorTotal = 0.0;
      for (var compra in gasto) {
        valorTotal += compra.valor;
      }
      return valorTotal;
    }

    Future<void> _submitForm(BuildContext context) async {
      try {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Aviso!'),
            content: const Text('Você deseja deletar essa loja?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Provider.of<DbData>(context, listen: false)
                        .deleteLoja(loja.id);
                    Provider.of<DbData>(context, listen: false).loadPessoas();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Pessoa removida com sucesso!')));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Sim')),
              TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Não'))
            ],
          ),
        );
        return;
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Ocorreu um erro!'),
                  content: Text(
                      'Ocorreu um erro ao deletar uma loja! Error: $error'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('OK'))
                  ],
                ));
      }
    }

    return Container(
      padding: const EdgeInsets.all(10),
      height: 70,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 5),
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
            child: Center(
              child: Text(
                loja.nome.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(loja.nome,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 2, 19, 119))),
              Text(valorTotal(loja.compra).toString(),
                  style:
                      const TextStyle(color: Color.fromARGB(255, 2, 19, 119))),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () => _submitForm(context),
              icon: const Icon(
                Icons.remove_circle,
                size: 35,
                color: Color.fromARGB(255, 2, 19, 119),
              ))
        ],
      ),
    );
  }
}