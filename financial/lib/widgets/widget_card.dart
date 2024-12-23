import 'dart:math';
import 'package:financial/models/card.dart' as custom_card;
import 'package:financial/services/db_data.dart';
import 'package:financial/widgets/update_emprestado_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WidgetCard extends StatelessWidget {
  final custom_card.Card card;
  const WidgetCard({required this.card, super.key});

  @override
  Widget build(BuildContext context) {
    _openUpdateEmprestadoFormModal(BuildContext context, int id, double valor) {
      showModalBottomSheet(
          context: context,
          builder: (_) => UpdateEmprestadoForm(id: id, valorAtual: valor));
    }

    return Dismissible(
      key: ValueKey(card.id),
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
                  content: const Text('Quer deletar esse dinheiro emprestado?'),
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
              .deleteDinheiro(card.id);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cartão removido com sucesso')));
        } catch (error) {
          // Reverter o estado se falhar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Erro ao remover "${card.name}". Tente novamente. Error: $error'),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 200,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          gradient: const RadialGradient(colors: [
            Color.fromARGB(50, 158, 158, 158),
            Color.fromARGB(255, 158, 158, 158),
          ]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Nome do Banco'),
              Transform.rotate(
                  angle: pi / 2, child: const Icon(Icons.wifi_rounded)),
              const Text('Nome da Pessoa'),
            ],
          ),
        ),
      ),
    );
  }
}
