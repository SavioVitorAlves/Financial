import 'dart:math';
import 'package:financial/models/card.dart' as custom_card;
import 'package:financial/models/credito.dart';
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
    double valorTotal(List<Credito> credito) {
      double valorTotal = 0.0;
      for (var cred in credito) {
        valorTotal += cred.valor;
      }
      return valorTotal;
    }

    int cor = int.parse("0xff${card.cor}");
    int cor99 = int.parse("0x99${card.cor}");
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
                  content: const Text('Quer deletar esse cartão?'),
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
          final saldo =
              Provider.of<DbData>(context, listen: false).conta['saldo'];
          if (valorTotal(card.credito) <= saldo) {
            final result = saldo - valorTotal(card.credito);
            Provider.of<DbData>(context).UpdateSaldo(result);
            await Provider.of<DbData>(context, listen: false)
                .deleteCartao(card.id);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cartão removido com sucesso')));
          } else {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Saldo insulficiente!'),
                content: const Text(
                    'O cartão que você deseja deletar tem um valor acima do seu saldo.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('OK'))
                ],
              ),
            );
            return;
          }
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
          gradient: RadialGradient(colors: [
            Color(cor99),
            Color(cor),
          ]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                card.name,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Transform.rotate(
                  angle: pi / 2,
                  child: const Icon(
                    Icons.wifi_rounded,
                    color: Colors.white,
                  )),
              Text(
                card.name_pessoa,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
