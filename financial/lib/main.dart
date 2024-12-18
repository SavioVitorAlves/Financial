import 'package:financial/screens/detail_screen.dart';
import 'package:financial/screens/money.dart';
import 'package:financial/screens/cards.dart';
import 'package:financial/screens/homeInitial.dart';
import 'package:financial/screens/parcelado.dart';
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
          AppRoutes.HOME: (ctx) => const Homeinitial(),
          AppRoutes.EMPRESTADO: (ctx) => const Money(),
          AppRoutes.PARCELADO: (ctx) => const Parcelado(),
          AppRoutes.CARTOES: (ctx) => const Cards(),
          AppRoutes.DETAIL_SCREEN: (ctx) => const DetailScreen(),
        },
      ),
    );
  }
}
