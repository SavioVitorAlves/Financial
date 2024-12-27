import 'package:financial/services/db_data.dart';
import 'package:financial/widgets/datePicker.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SaldoForm extends StatefulWidget {
  final double valor;
  const SaldoForm({required this.valor, super.key});

  @override
  State<SaldoForm> createState() => _SaldoFormState();
}

class _SaldoFormState extends State<SaldoForm> {
  final _addControler = TextEditingController();
  final _SubtractControler = TextEditingController();

  Future<void> _submitAddForm(BuildContext context) async {
    if (_addControler.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Valor vazio!'),
          content: const Text(
              'Por favor, insira o valor para ser adicionado ao saldo.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'))
          ],
        ),
      );
      return;
    }

    final double add = double.parse(_addControler.text);
    final double valor = widget.valor;

    final result = valor + add;

    try {
      await Provider.of<DbData>(context, listen: false).UpdateSaldo(result);
      Provider.of<DbData>(context, listen: false).loadConta();
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Ocorreu um erro!'),
                content: Text(
                    'Ocorreu um erro ao atualizar o saldo da sua conta! Error: $error'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('OK'))
                ],
              ));
    }
  }

  Future<void> _submitSubtractForm(BuildContext context) async {
    if (_SubtractControler.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Valor vazio!'),
          content: const Text(
              'Por favor, insira o valor para ser subtraido do saldo.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'))
          ],
        ),
      );
      return;
    }

    final double sub = double.parse(_SubtractControler.text);
    final double valor = widget.valor;

    final result = valor - sub;

    try {
      await Provider.of<DbData>(context, listen: false).UpdateSaldo(result);
      Provider.of<DbData>(context, listen: false).loadConta();
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Ocorreu um erro!'),
                content: Text(
                    'Ocorreu um erro ao atualizar o saldo da sua conta! Error: $error'),
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
              controller: _addControler,
              decoration: const InputDecoration(label: Text('Adicionar Valor')),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                backgroundColor: const Color.fromARGB(255, 2, 19, 119),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => _submitAddForm(context),
              child: const Text('Adicionar Valor',
                  style: TextStyle(color: Colors.white)),
            ),
            TextField(
              controller: _SubtractControler,
              decoration: const InputDecoration(label: Text('Subtrair Valor')),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                backgroundColor: const Color.fromARGB(255, 2, 19, 119),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => _submitSubtractForm(context),
              child: const Text('Subtrair Valor',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ));
  }
}
