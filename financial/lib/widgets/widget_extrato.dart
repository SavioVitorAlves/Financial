import 'package:financial/models/extrato.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetExtrato extends StatelessWidget {
  final Extrato extrato;

  const WidgetExtrato({required this.extrato, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: EdgeInsets.only(left: 3, right: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blue,
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  extrato.valor.toString(), //valor que foi pegado
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
              Text(extrato.descricao, // descrição do dinheiro emprestado
                  style:
                      const TextStyle(color: Color.fromARGB(255, 2, 19, 119))),
              Text(
                  DateFormat('dd/MM/yy').format(
                      extrato.date), //data que pegou o dinheiro emprestado
                  style:
                      const TextStyle(color: Color.fromARGB(255, 2, 19, 119))),
            ],
          ),
        ],
      ),
    );
  }
}
