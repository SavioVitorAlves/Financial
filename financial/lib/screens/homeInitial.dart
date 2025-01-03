import 'package:financial/services/db_data.dart';
import 'package:financial/utils/app_routes.dart';
import 'package:financial/widgets/funcionalidades.dart';
import 'package:financial/widgets/update_saldo_form.dart';
import 'package:financial/widgets/widget_extrato.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Homeinitial extends StatefulWidget {
  const Homeinitial({super.key});

  @override
  State<Homeinitial> createState() => _HomeinitialState();
}

class _HomeinitialState extends State<Homeinitial> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DbData>(context, listen: false).loadConta();
    Provider.of<DbData>(context, listen: false).loadExtrato();
  }

  _openUpdateSaldoFormModal(BuildContext context, double valor) {
    showModalBottomSheet(
        context: context,
        builder: (_) => SaldoForm(
              valor: valor,
            ));
  }

  String _mensagem(double saldo) {
    String msg = "Continue assim!";
    if (saldo < 600) {
      msg = "Seu saldo esta muito baixo!";
    } else if (saldo >= 600 && saldo < 1000) {
      msg = "Mantenha o seu saldo acima do atual.";
    } else if (saldo >= 1000 && saldo < 2000) {
      msg = "Otimo! Esse é um bom saldo.";
    } else if (saldo >= 2000) {
      msg = "Perfeito! Sua saude financeira esta otima.";
    }
    return msg;
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
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Consumer<DbData>(builder: (context, valor, child) {
              if (valor.conta == null || valor.conta.isEmpty) {
                // Se os dados não estão carregados, exibe o CircularProgressIndicator
                return const Center(child: CircularProgressIndicator());
              }
              final saldo = valor.conta;
              print('Saldo: $saldo');
              return Container(
                height: MediaQuery.of(context).size.height * .25,
                width: double.infinity,
                color: const Color.fromARGB(255, 2, 19, 119),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          FittedBox(
                            child: Text(
                              saldo['saldo'] == {}
                                  ? "00"
                                  : formatarValor(saldo['saldo']),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(100, 10),
                              backgroundColor:
                                  const Color.fromARGB(120, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () => _openUpdateSaldoFormModal(
                                context, saldo['saldo']),
                            child: const Text('ADD/SUB',
                                style: TextStyle(color: Colors.white)),
                          ), // Botão no
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(120, 255, 255, 255),
                            ),
                            child: const Icon(
                              Icons.crisis_alert_outlined,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            _mensagem(saldo['saldo']),
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
            Container(
              height: MediaQuery.of(context).size.height * .75,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Operações',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: const Funcionalidades(
                              name: 'Emprestado',
                              url: 'lib/assets/imgs/transacao.png'),
                          onTap: () => Navigator.of(context)
                              .pushNamed(AppRoutes.EMPRESTADO),
                        ),
                        GestureDetector(
                          child: const Funcionalidades(
                              name: 'Parcelado',
                              url: 'lib/assets/imgs/moeda.png'),
                          onTap: () => Navigator.of(context)
                              .pushNamed(AppRoutes.PARCELADO),
                        ),
                        GestureDetector(
                          child: const Funcionalidades(
                              name: 'Cartões',
                              url: 'lib/assets/imgs/cartao.png'),
                          onTap: () => Navigator.of(context)
                              .pushNamed(AppRoutes.CARTOES),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Operações Recentes',
                      ),
                    ),
                    Consumer<DbData>(
                      builder: (context, value, child) {
                        final extrato = value.extrato;
                        return Container(
                          height: 410,
                          child: extrato.isEmpty
                              ? const Center(
                                  child: Text(
                                    'Não há nenhuma transação.',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: extrato.length,
                                  itemBuilder: (context, index) {
                                    return WidgetExtrato(
                                      extrato: extrato[index],
                                    );
                                  }),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
