import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker(
      {required this.onColorChanged, required this.selectedColor, super.key});

  final Color selectedColor;
  final Function(Color) onColorChanged;
  String colorParaHex(Color color) {
    return '#${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
  }

  _showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Paleta de Cores'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: selectedColor,
              onColorChanged: onColorChanged,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('SELECT'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onColorChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      child: Row(
        children: [
          Text(selectedColor == null
              ? 'Nenhuma cor selecionada'
              : 'Cor Selecionada: ${colorParaHex(selectedColor)}'),
          const Spacer(),
          TextButton(
              onPressed: () => _showDatePicker(context),
              child: const Text('Selecionar Cor'))
        ],
      ),
    );
  }
}
