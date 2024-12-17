import 'package:financial/models/emprestado.dart';
import 'package:financial/models/pessoa.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WidgetPessoa extends StatelessWidget {
  final Pessoa pessoa;

  const WidgetPessoa({required this.pessoa, super.key});

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
                pessoa.nome.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
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
              Text(pessoa.nome,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 2, 19, 119))),
              Text(valorTotal(pessoa.dinheiro).toString(),
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
