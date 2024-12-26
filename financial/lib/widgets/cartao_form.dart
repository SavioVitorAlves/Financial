import 'package:financial/services/db_data.dart';
import 'package:financial/widgets/colorPicker.dart';
import 'package:financial/widgets/datePicker.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CartaoForm extends StatefulWidget {
  const CartaoForm({super.key});

  @override
  State<CartaoForm> createState() => _CartaoFormState();
}

class _CartaoFormState extends State<CartaoForm> {
  final _nomeControler = TextEditingController();
  final _nomePessoaControler = TextEditingController();
  Color _selectedColor = const Color(0xff0000FF);

  String colorParaHex(Color color) {
    return '${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
  }

  Future<void> _submitForm(BuildContext context) async {
    if (_nomeControler.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Nome vazio!'),
          content: const Text(
              'Por favor, insira um nome ao cartão antes de adicionar.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'))
          ],
        ),
      );
      return;
    } else if (_nomePessoaControler.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Nome vazio!'),
          content: const Text(
              'Por favor, insira um nome ao usuario antes de adicionar.'),
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
    final String nomePessoa = _nomePessoaControler.text;
    print('Nome do Cartão: $nome, Nome do Dono: $nomePessoa');
    try {
      await Provider.of<DbData>(context, listen: false)
          .insertCartao(nome, nomePessoa, colorParaHex(_selectedColor));
      Provider.of<DbData>(context, listen: false).loadCartoes();
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Ocorreu um erro!'),
                content: Text(
                    'Ocorreu um erro ao adicionar um novo cartão de credito! Error: $error'),
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
              decoration: const InputDecoration(label: Text('Nome do Cartão')),
            ),
            TextField(
              controller: _nomePessoaControler,
              decoration: const InputDecoration(label: Text('Nome do Dono')),
            ),
            ColorPicker(
                onColorChanged: (newDate) {
                  setState(() {
                    _selectedColor = newDate;
                  });
                },
                selectedColor: _selectedColor),
            FilledButton(
                onPressed: () => _submitForm(context),
                child: const Text('Adicionar Cartão')),
          ],
        ),
      ),
    ));
  }
}
