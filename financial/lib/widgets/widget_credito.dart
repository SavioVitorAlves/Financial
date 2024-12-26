import 'package:financial/models/credito.dart';
import 'package:financial/models/emprestado.dart';
import 'package:financial/models/gasto.dart';
import 'package:financial/services/db_data.dart';
import 'package:financial/widgets/emprestado_form.dart';
import 'package:financial/widgets/update_compra_form.dart';
import 'package:financial/widgets/update_credito_form.dart';
import 'package:financial/widgets/update_emprestado_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WidgetCredito extends StatelessWidget {
  final Credito credito;

  const WidgetCredito({required this.credito, super.key});

  @override
  Widget build(BuildContext context) {
    final _valorControler = TextEditingController();

    double valorTotal(List<Credito> credito) {
      double valorTotal = 0.0;
      for (var dinheiro in credito) {
        valorTotal += dinheiro.valor;
      }
      return valorTotal;
    }

    _openUpdateCreditoFormModal(BuildContext context, int id, double valor) {
      showModalBottomSheet(
          context: context,
          builder: (_) => UpdateCreditoForm(id: id, valorAtual: valor));
    }

    return Dismissible(
      key: ValueKey(credito.id),
      direction: DismissDirection.endToStart,
      background: Container(
        height: 70,
        color: Theme.of(context).colorScheme.error,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(
          right: 20,
        ),
      ),
      confirmDismiss: (_) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Tem Certeza?'),
                  content: const Text('Quer deletar esse credito?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Não')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Sim'))
                  ],
                ));
      },
      onDismissed: (_) async {
        try {
          await Provider.of<DbData>(context, listen: false)
              .deleteCredito(credito.id);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Compra removida com sucesso')));
        } catch (error) {
          // Reverter o estado se falhar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Erro ao remover "${credito.descricao}". Tente novamente. Error: $error'),
            ),
          );
        }
      },
      child: Container(
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
                  credito.valor.toString(), //valor que foi pegado
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
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
                Text(credito.descricao, // descrição do dinheiro emprestado
                    style: const TextStyle(
                        color: Color.fromARGB(255, 2, 19, 119))),
                Text(
                    DateFormat('dd/MM/yy').format(
                        credito.date), //data que pegou o dinheiro emprestado
                    style: const TextStyle(
                        color: Color.fromARGB(255, 2, 19, 119))),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () => _openUpdateCreditoFormModal(
                    context, credito.id, credito.valor),
                icon: const Icon(
                  Icons.remove_circle,
                  size: 35,
                  color: Color.fromARGB(255, 2, 19, 119),
                ))
          ],
        ),
      ),
    );
  }
}
