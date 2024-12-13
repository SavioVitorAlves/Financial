import 'package:financial/models/emprestado.dart';

class Pessoa {
  final int id;
  final String nome;
  final List<Emprestado> dinheiro;

  Pessoa({required this.id, required this.nome, required this.dinheiro});
}
