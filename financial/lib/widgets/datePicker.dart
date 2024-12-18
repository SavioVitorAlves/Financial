import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  const DatePicker(
      {required this.onDateChanged, required this.selectedDate, super.key});

  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  _showDatePicker(BuildContext context) {
    final _quantDays = 100 * 365;
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: _quantDays)),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      child: Row(
        children: [
          Text(selectedDate == null
              ? 'Nenhuma data selecionada'
              : 'Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}'),
          const Spacer(),
          TextButton(
              onPressed: () => _showDatePicker(context),
              child: const Text('Selecionar Data'))
        ],
      ),
    );
  }
}
