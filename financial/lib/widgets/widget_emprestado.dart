import 'package:financial/models/emprestado.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetEmprestado extends StatelessWidget {
  final Emprestado emprestado;

  const WidgetEmprestado({required this.emprestado, super.key});

  @override
  Widget build(BuildContext context) {
    double valorTotal(List<Emprestado> emprestado) {
      double valorTotal = 0.0;
      for (var dinheiro in emprestado) {
        valorTotal += dinheiro.valor;
      }
      return valorTotal;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      height: 70,
      width: double.infinity,
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
              child: Text(
                emprestado.valor.toString(), //valor que foi pegado
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
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
                  style:
                      const TextStyle(color: Color.fromARGB(255, 2, 19, 119))),
              Text(
                  DateFormat('dd/MM/yy').format(
                      emprestado.date), //data que pegou o dinheiro emprestado
                  style:
                      const TextStyle(color: Color.fromARGB(255, 2, 19, 119))),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.remove_circle,
                size: 35,
                color: Color.fromARGB(255, 2, 19, 119),
              ))
        ],
      ),
    );
  }
}
