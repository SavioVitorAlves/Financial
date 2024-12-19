import 'package:financial/models/emprestado.dart';
import 'package:financial/models/pessoa.dart';
import 'package:financial/utils/db_util.dart';
import 'package:flutter/material.dart';

class DbData with ChangeNotifier {
  List<Pessoa> _pessoas = [];

  List<Pessoa> get pessoas {
    return [..._pessoas];
  }

  DbData([this._pessoas = const []]);

  Future<void> loadPessoas() async {
    final dbData = DbUtil();
    final db = await dbData.database();

    final result = await dbData.getPessoaComDinheiro(db);
    print('Resultado vindo do banco: $result');

    List<Pessoa> listPessoa = [];
    for (var pessoa in result) {
      print('pessoas: $pessoa');

      List<Emprestado> emprestado = [];
      if (pessoa['emprestado'] != []) {
        for (var dinheiro in pessoa['emprestado']) {
          emprestado.add(Emprestado(
              id: dinheiro['id'],
              descricao: dinheiro['descricao'],
              valor: dinheiro['valor'],
              date: DateTime.parse(dinheiro['data'])));
        }
        listPessoa.add(Pessoa(
            id: pessoa['id'], nome: pessoa['name'], dinheiro: emprestado));
      } else if (pessoa['emprestado'] == []) {
        listPessoa
            .add(Pessoa(id: pessoa['id'], nome: pessoa['name'], dinheiro: []));
      }
    }
    _pessoas = listPessoa.toList();
    notifyListeners();
  }

  Future<void> insertPessoa(String nome) async {
    final dbData = DbUtil();
    final db = await dbData.database();
    dbData.insertPessoa(db, nome);
    loadPessoas();
    notifyListeners();
  }

  Future<void> deletePessoa(int id) async {
    final dbData = DbUtil();
    final db = await dbData.database();
    dbData.deletePessoa(db, id);
    loadPessoas();
    notifyListeners();
  }

  Future<void> deleteDinheiro(int id) async {
    final dbData = DbUtil();
    final db = await dbData.database();
    dbData.deletePessoa(db, id);
    loadPessoas();
    notifyListeners();
  }

  Future<void> insertDinheiro(
      int id, String descricao, double valor, DateTime date) async {
    final dbData = DbUtil();
    final db = await dbData.database();

    final Map<String, dynamic> dinheiro = {
      'id': id,
      'descricao': descricao,
      'valor': valor,
      'data': date.toIso8601String(),
    };

    dbData.insertDinheiro(db, dinheiro);
    loadPessoas();
    notifyListeners();
  }

  Future<void> updateDinheiro(int id, double valor) async {
    final dbData = DbUtil();
    final db = await dbData.database();

    dbData.updateDinheiroEmprestado(db, id, valor);
    loadPessoas();
    notifyListeners();
  }
}
