import 'package:financial/models/emprestado.dart';
import 'package:financial/models/pessoa.dart';
import 'package:financial/widgets/emprestado_form.dart';
import 'package:financial/widgets/widget_emprestado.dart';
import 'package:financial/widgets/widget_pessoa.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPessoaScreen extends StatefulWidget {
  const DetailPessoaScreen({super.key});

  @override
  State<DetailPessoaScreen> createState() => _DetailPessoaScreenState();
}

class _DetailPessoaScreenState extends State<DetailPessoaScreen> {
  _openEmprestadoFormModal(BuildContext context, int id) {
    showModalBottomSheet(
        context: context,
        builder: (_) => EmprestadoForm(
              id: id,
            ));
  }

  double valorTotal(List<Emprestado> emprestado) {
    double valorTotal = 0.0;
    for (var dinheiro in emprestado) {
      valorTotal += dinheiro.valor;
    }
    return valorTotal;
  }

  String formatarValor(double valor) {
    final formatador = NumberFormat.currency(
      locale: 'en_US',
      symbol: '', // Sem símbolo de moeda
      decimalDigits: 2,
    );
    return formatador.format(valor);
  }

  @override
  Widget build(BuildContext context) {
    Pessoa pessoa = ModalRoute.of(context)!.settings.arguments as Pessoa;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pessoa.nome, // nome da pessoa vindo do bando de dados no appBar
          style: const TextStyle(
              color: Color.fromARGB(255, 2, 19, 119), fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.monetization_on_outlined,
                      size: 30,
                      color: Color.fromARGB(255, 2, 19, 119),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      formatarValor(valorTotal(pessoa.dinheiro)),
                      style: TextStyle(
                          color: Color.fromARGB(255, 2, 19, 119),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 500,
                  child: pessoa.dinheiro.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhum dinheiro foi registrado.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: pessoa.dinheiro.length,
                          itemBuilder: (context, index) {
                            return WidgetEmprestado(
                              emprestado: pessoa.dinheiro[index],
                            );
                          }),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    backgroundColor: const Color.fromARGB(255, 2, 19, 119),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => _openEmprestadoFormModal(context, pessoa.id),
                  child: const Text('Adicionar Dinheiro',
                      style: TextStyle(color: Colors.white)),
                ), // ,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
