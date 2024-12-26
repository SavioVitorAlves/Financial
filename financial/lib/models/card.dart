import 'package:financial/models/credito.dart';

class Card {
  final int id;
  final String name;
  final String name_pessoa;
  final String cor;
  final List<Credito> credito;
  Card(
      {required this.id,
      required this.name,
      required this.name_pessoa,
      required this.cor,
      required this.credito});
}
