import 'package:financial/services/db_data.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LojaForm extends StatefulWidget {
  const LojaForm({super.key});

  @override
  State<LojaForm> createState() => _LojaFormState();
}

class _LojaFormState extends State<LojaForm> {
  final _nomeControler = TextEditingController();

  Future<void> _submitForm(BuildContext context) async {
    if (_nomeControler.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Nome vazio!'),
          content: const Text(
              'Por favor, insira o nome da loja antes de adicionar.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'))
          ],
        ),
      );
      return;
    }

    final String nome = _nomeControler.text;

    try {
      await Provider.of<DbData>(context, listen: false).insertLoja(nome);
      Provider.of<DbData>(context, listen: false).loadLojas();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Loja adicionada com sucesso!')));
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Ocorreu um erro!'),
                content: Text(
                    'Ocorreu um erro ao adicionar uma nova loja! Error: $error'),
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
              controller: _nomeControler,
              decoration: const InputDecoration(label: Text('Nome')),
            ),
            FilledButton(
                onPressed: () => _submitForm(context),
                child: const Text('Adicionar Loja')),
          ],
        ),
      ),
    ));
  }
}
