import 'package:financial/services/db_data.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class UpdateEmprestadoForm extends StatefulWidget {
  final double valorAtual;
  final int id;
  const UpdateEmprestadoForm(
      {required this.id, required this.valorAtual, super.key});

  @override
  State<UpdateEmprestadoForm> createState() => _UpdateEmprestadoFormState();
}

class _UpdateEmprestadoFormState extends State<UpdateEmprestadoForm> {
  final _valorControler = TextEditingController();

  Future<void> _submitForm(BuildContext context) async {
    if (_valorControler.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Valor vazio!'),
          content: const Text(
              'Por favor, insira o valor a ser subtraido do dinheiro.'),
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
    if (double.parse(_valorControler.text) >= widget.valorAtual) {
      novoValor = double.parse(_valorControler.text) - widget.valorAtual;
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
      await Provider.of<DbData>(context, listen: false)
          .updateDinheiro(widget.id, novoValor);
      Provider.of<DbData>(context, listen: false).loadPessoas();
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Ocorreu um erro!'),
                content: Text(
                    'Ocorreu um erro ao adicionar um novo dinheiro emprestado! Error: $error'),
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
