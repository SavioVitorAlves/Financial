import 'package:financial/services/db_data.dart';
import 'package:financial/utils/app_routes.dart';
import 'package:financial/widgets/datePicker.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class GastoForm extends StatefulWidget {
  final int id;
  const GastoForm({required this.id, super.key});

  @override
  State<GastoForm> createState() => _GastoFormState();
}

class _GastoFormState extends State<GastoForm> {
  final _descricaoControler = TextEditingController();
  final _valorControler = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _submitForm(BuildContext context) async {
    if (_descricaoControler.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Descrição vazio!'),
          content: const Text(
              'Por favor, insira uma descrição a compra antes de adicionar.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'))
          ],
        ),
      );
      return;
    } else if (_valorControler.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Valor vazio!'),
          content: const Text(
              'Por favor, insira o valor da compra antes de adicionar.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'))
          ],
        ),
      );
      return;
    }

    final String descricao = _descricaoControler.text;
    final double valor = double.parse(_valorControler.text);
    final int id = widget.id;

    try {
      await Provider.of<DbData>(context, listen: false)
          .insertExtrato(descricao, valor, DateTime.now());
      await Provider.of<DbData>(context, listen: false)
          .insertGasto(id, descricao, valor, _selectedDate);
      Provider.of<DbData>(context, listen: false).loadLojas();
      Navigator.of(context).pushNamed(AppRoutes.PARCELADO);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Ocorreu um erro!'),
                content: Text(
                    'Ocorreu um erro ao adicionar uma nova compra no credito! Error: $error'),
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
              controller: _descricaoControler,
              decoration: const InputDecoration(label: Text('Descrição')),
            ),
            TextField(
              controller: _valorControler,
              decoration: const InputDecoration(label: Text('Valor')),
            ),
            DatePicker(
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
                selectedDate: _selectedDate),
            FilledButton(
                onPressed: () => _submitForm(context),
                child: const Text('Adicionar Compra')),
          ],
        ),
      ),
    ));
  }
}
