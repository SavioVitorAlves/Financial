import 'package:financial/models/emprestado.dart';
import 'package:financial/models/pessoa.dart';
import 'package:financial/services/db_data.dart';
import 'package:financial/utils/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetPessoa extends StatelessWidget {
  final Pessoa pessoa;

  const WidgetPessoa({required this.pessoa, super.key});

  @override
  Widget build(BuildContext context) {
    double valorTotal(List<Emprestado> emprestado) {
      double valorTotal = 0.0;
      for (var dinheiro in emprestado) {
        valorTotal += dinheiro.valor;
      }
      return valorTotal;
    }

    Future<void> _submitForm(BuildContext context) async {
      try {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Aviso!'),
            content: const Text('Você deseja deletar essa pessoa?'),
            actions: [
              TextButton(
                  onPressed: () {
                    final saldo = Provider.of<DbData>(context, listen: false)
                        .conta['saldo'];
                    if (valorTotal(pessoa.dinheiro) <= saldo) {
                      final result = saldo - valorTotal(pessoa.dinheiro);
                      Provider.of<DbData>(context, listen: false)
                          .deletePessoa(pessoa.id);
                      Provider.of<DbData>(context, listen: false)
                          .UpdateSaldo(result);

                      Provider.of<DbData>(context, listen: false).loadPessoas();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Pessoa removida com sucesso!')));
                      Navigator.of(context).pushNamed(
                        AppRoutes.DELETING_SUCCESSFULLY,
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Saldo insulficiente!'),
                          content: const Text(
                              'A pessoa que você deseja deletar tem um valor acima do seu saldo.'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.of(ctx).pop(),
                                child: const Text('OK'))
                          ],
                        ),
                      );
                      return;
                    }
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
                      'Ocorreu um erro ao deletar uma pessoa! Error: $error'),
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
                pessoa.nome.substring(0, 1).toUpperCase(),
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
              Text(pessoa.nome,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 2, 19, 119))),
              Text('R\$ ${valorTotal(pessoa.dinheiro).toString()}',
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
