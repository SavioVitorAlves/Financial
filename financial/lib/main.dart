import 'package:financial/screens/detail_cartao_screen.dart';
import 'package:financial/screens/detail_loja_screen.dart';
import 'package:financial/screens/detail_pessoa_screen.dart';
import 'package:financial/screens/money.dart';
import 'package:financial/screens/cards.dart';
import 'package:financial/screens/homeInitial.dart';
import 'package:financial/screens/parcelado.dart';
import 'package:financial/screens/start.dart';
import 'package:financial/screens/successfully/deleting_successfully.dart';
import 'package:financial/screens/successfully/pagamento_successfully.dart';
import 'package:financial/services/db_data.dart';
import 'package:financial/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DbData(),
      child: MaterialApp(
        title: 'Financial',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //home: const Homeinitial(),
        routes: {
          AppRoutes.INICIAL: (ctx) => const Start(),
          AppRoutes.HOME: (ctx) => const Homeinitial(),
          AppRoutes.EMPRESTADO: (ctx) => const Money(),
          AppRoutes.PARCELADO: (ctx) => const Parcelado(),
          AppRoutes.CARTOES: (ctx) => const Cards(),
          AppRoutes.DETAIL_PESSOA_SCREEN: (ctx) => const DetailPessoaScreen(),
          AppRoutes.DETAIL_LOJA_SCREEN: (ctx) => const DetailLojaScreen(),
          AppRoutes.DETAIL_CARTAO_SCREEN: (ctx) => const DetailCartaoScreen(),
          AppRoutes.DELETING_SUCCESSFULLY: (ctx) =>
              const DeletingSuccessfully(),
          AppRoutes.PAGAMENTO_SUCCESSFULLY: (ctx) =>
              const PagamentoSuccessfully(),
        },
      ),
    );
  }
}

class DetailCreditoScreen {
  const DetailCreditoScreen();
}
