import 'package:financial/services/db_data.dart';
import 'package:financial/utils/app_routes.dart';
import 'package:financial/widgets/people_form.dart';
import 'package:financial/widgets/widget_pessoa.dart';
import 'package:flutter/material.dart';
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

    Provider.of<DbData>(context, listen: false).loadPessoas();
  }

  _openPeopleFormModal(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => const PeopleForm());
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
        builder: (context, people, child) {
          final pessoas = people.pessoas;
          print('Pessoas: $pessoas');
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
                    const Row(
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
                          '8,420.00',
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
                      height: 400,
                      child: pessoas.isEmpty
                          ? const Center(
                              child: Text(
                                'Nenhum cartão registrado.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: pessoas.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: WidgetPessoa(
                                    pessoa: pessoas[index],
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.DETAIL_PESSOA_SCREEN,
                                        arguments: pessoas[index]);
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
                      onPressed: () => _openPeopleFormModal(context),
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
