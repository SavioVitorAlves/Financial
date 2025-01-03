import 'package:financial/services/db_data.dart';
import 'package:financial/utils/app_routes.dart';
import 'package:financial/widgets/cartao_form.dart';
import 'package:financial/widgets/people_form.dart';
import 'package:financial/widgets/widget_card.dart';
import 'package:financial/models/card.dart' as custom_card;
import 'package:financial/widgets/widget_pessoa.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Cards extends StatefulWidget {
  const Cards({super.key});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<DbData>(context, listen: false).loadCartoes();
  }

  _openCartaoFormModal(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => const CartaoForm());
  }

  double valorTotal(List<custom_card.Card> cards) {
    double valorTotal = 0.0;
    for (var cartoes in cards) {
      for (var credito in cartoes.credito) {
        valorTotal += credito.valor;
      }
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cartões de Credito',
          style:
              TextStyle(color: Color.fromARGB(255, 2, 19, 119), fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Consumer<DbData>(
        builder: (context, cartao, child) {
          final cartoes = cartao.cartoes;
          print('Cartoes: $cartoes');
          return Center(
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
                          'R\$ ${formatarValor(valorTotal(cartoes))}',
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
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Seus Cartões',
                        style: TextStyle(
                            color: Color.fromARGB(255, 2, 19, 119),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      height: 500,
                      child: cartoes.isEmpty
                          ? const Center(
                              child: Text(
                                'Nenhum cartão registrado.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: cartoes.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: WidgetCard(
                                    card: cartoes[index],
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.DETAIL_CARTAO_SCREEN,
                                        arguments: cartoes[index]);
                                  },
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
                      onPressed: () => _openCartaoFormModal(context),
                      child: const Text('Adicionar Cartão',
                          style: TextStyle(color: Colors.white)),
                    ), // ,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
