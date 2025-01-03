import 'package:financial/models/emprestado.dart';
import 'package:financial/services/db_data.dart';
import 'package:financial/utils/app_routes.dart';
import 'package:financial/widgets/emprestado_form.dart';
import 'package:financial/widgets/update_emprestado_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WidgetEmprestado extends StatelessWidget {
  final Emprestado emprestado;

  const WidgetEmprestado({required this.emprestado, super.key});

  @override
  Widget build(BuildContext context) {
    final _valorControler = TextEditingController();

    double valorTotal(List<Emprestado> emprestado) {
      double valorTotal = 0.0;
      for (var dinheiro in emprestado) {
        valorTotal += dinheiro.valor;
      }
      return valorTotal;
    }

    _openUpdateEmprestadoFormModal(BuildContext context, int id, double valor) {
      showModalBottomSheet(
          context: context,
          builder: (_) => UpdateEmprestadoForm(id: id, valorAtual: valor));
    }

    return Dismissible(
      key: ValueKey(emprestado.id),
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
          final saldo =
              Provider.of<DbData>(context, listen: false).conta['saldo'];
          if (emprestado.valor <= saldo) {
            final result = saldo - emprestado.valor;
            await Provider.of<DbData>(context).UpdateSaldo(result);
            await Provider.of<DbData>(context, listen: false).insertExtrato(
                "Deletou: ${emprestado.descricao}",
                emprestado.valor,
                DateTime.now());
            await Provider.of<DbData>(context, listen: false)
                .deleteDinheiro(emprestado.id);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Dinheiro emprestado removido com sucesso')));
            Navigator.of(context).pushNamed(
              AppRoutes.PAGAMENTO_SUCCESSFULLY,
            );
          } else {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Saldo insulficiente!'),
                content: const Text(
                    'O item que você deseja deletar tem um valor acima do seu saldo.'),
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
                  'Erro ao remover "${emprestado.descricao}". Tente novamente. Error: $error'),
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
                child: FittedBox(
                  child: Text(
                    emprestado.valor.toString(), //valor que foi pegado
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(emprestado.descricao, // descrição do dinheiro emprestado
                    style: const TextStyle(
                        color: Color.fromARGB(255, 2, 19, 119))),
                Text(
                    DateFormat('dd/MM/yy').format(
                        emprestado.date), //data que pegou o dinheiro emprestado
                    style: const TextStyle(
                        color: Color.fromARGB(255, 2, 19, 119))),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () => _openUpdateEmprestadoFormModal(
                    context, emprestado.id, emprestado.valor),
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
