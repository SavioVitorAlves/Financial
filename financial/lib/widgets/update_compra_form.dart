import 'package:financial/services/db_data.dart';
import 'package:financial/utils/app_routes.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class UpdateCompraForm extends StatefulWidget {
  final double valorAtual;
  final int id;
  const UpdateCompraForm(
      {required this.id, required this.valorAtual, super.key});

  @override
  State<UpdateCompraForm> createState() => _UpdateCompraFormState();
}

class _UpdateCompraFormState extends State<UpdateCompraForm> {
  final _valorControler = TextEditingController();

  Future<void> _submitForm(BuildContext context) async {
    if (_valorControler.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Valor vazio!'),
          content: const Text(
              'Por favor, insira o valor a ser subtraido da compra.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'))
          ],
        ),
      );
      return;
    }
    final double novoValor;
    final double sub = double.parse(_valorControler.text);
    if (sub <= widget.valorAtual) {
      novoValor = widget.valorAtual - sub;
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Valor alto!'),
          content: const Text(
              'Por favor, insira um valor inferior ou igual ao atual.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'))
          ],
        ),
      );
      return;
    }

    try {
      final saldo = Provider.of<DbData>(context, listen: false).conta['saldo'];
      if (sub <= saldo) {
        final result = saldo - sub;
        await Provider.of<DbData>(context).UpdateSaldo(result);
        await Provider.of<DbData>(context, listen: false)
            .insertExtrato("Pagou uma compra", novoValor, DateTime.now());
        await Provider.of<DbData>(context, listen: false)
            .updateGasto(widget.id, novoValor);
        Provider.of<DbData>(context, listen: false).loadLojas();
        Provider.of<DbData>(context, listen: false).loadConta();
        Navigator.of(context).pushNamed(
          AppRoutes.PAGAMENTO_SUCCESSFULLY,
        );
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Saldo insulficiente!'),
            content:
                const Text('Por favor, insira um valor abaixo do seu saldo.'),
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
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Ocorreu um erro!'),
                content: Text(
                    'Ocorreu um erro ao subtrair o valor desejado do valor atual! Error: $error'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('OK'))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Card(
      child: Padding(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            TextField(
              controller: _valorControler,
              decoration: const InputDecoration(label: Text('Valor')),
            ),
            FilledButton(
                onPressed: () => _submitForm(context),
                child: const Text('Subtrair Valor')),
          ],
        ),
      ),
    ));
  }
}
