import 'package:financial/models/gasto.dart';

class Loja {
  final int id;
  final String nome;
  final List<Gasto> compra;

  Loja({required this.id, required this.nome, required this.compra});
}
