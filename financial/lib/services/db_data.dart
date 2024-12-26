import 'package:financial/models/credito.dart';
import 'package:financial/models/emprestado.dart';
import 'package:financial/models/gasto.dart';
import 'package:financial/models/loja.dart';
import 'package:financial/models/pessoa.dart';
import 'package:financial/utils/db_util.dart';
import 'package:flutter/material.dart';
import 'package:financial/models/card.dart' as custom_card;

class DbData with ChangeNotifier {
  List<Pessoa> _pessoas = [];

  List<Pessoa> get pessoas {
    return [..._pessoas];
  }

  DbData([this._pessoas = const [], this._lojas = const []]);

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
    dbData.deleteDinheiroEmprestado(db, id);
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
    /*final pessoas = _pessoas;
    for (var pessoa in pessoas) {
      if (pessoa.id == id) {
        pessoa.dinheiro.add(
            Emprestado(id: id, descricao: descricao, valor: valor, date: date));
      }
    }*/
    notifyListeners();
  }

  Future<void> updateDinheiro(int id, double valor) async {
    final dbData = DbUtil();
    final db = await dbData.database();

    dbData.updateDinheiroEmprestado(db, id, valor);
    loadPessoas();
    notifyListeners();
  }

  //================
  List<Loja> _lojas = [];

  List<Loja> get lojas {
    return [..._lojas];
  }

  Future<void> loadLojas() async {
    final dbData = DbUtil();
    final db = await dbData.database();

    final result = await dbData.getLojaComGastos(db);
    print('Resultado vindo do banco: $result');

    List<Loja> listLojas = [];
    for (var loja in result) {
      print('loja: $loja');

      List<Gasto> compras = [];
      if (loja['compra'] != []) {
        for (var compra in loja['compra']) {
          compras.add(Gasto(
              id: compra['id'],
              descricao: compra['descricao'],
              valor: compra['valor'],
              date: DateTime.parse(compra['data'])));
        }
        listLojas
            .add(Loja(id: loja['id'], nome: loja['name'], compra: compras));
      } else if (loja['compra'] == []) {
        listLojas.add(Loja(id: loja['id'], nome: loja['name'], compra: []));
      }
    }
    _lojas = listLojas.toList();
    notifyListeners();
  }

  Future<void> insertLoja(String nome) async {
    final dbData = DbUtil();
    final db = await dbData.database();
    dbData.insertLoja(db, nome);
    loadLojas();

    notifyListeners();
  }

  Future<void> deleteLoja(int id) async {
    final dbData = DbUtil();
    final db = await dbData.database();
    dbData.deleteLoja(db, id);
    loadLojas();
    notifyListeners();
  }

  Future<void> deleteGasto(int id) async {
    final dbData = DbUtil();
    final db = await dbData.database();
    dbData.deleteGastosDeLoja(db, id);
    loadLojas();
    notifyListeners();
  }

  Future<void> insertGasto(
      int id, String descricao, double valor, DateTime date) async {
    final dbData = DbUtil();
    final db = await dbData.database();

    final Map<String, dynamic> gasto = {
      'id': id,
      'descricao': descricao,
      'valor': valor,
      'data': date.toIso8601String(),
    };

    dbData.insertGastos(db, gasto);
    loadLojas();
    /*final pessoas = _pessoas;
    for (var pessoa in pessoas) {
      if (pessoa.id == id) {
        pessoa.dinheiro.add(
            Emprestado(id: id, descricao: descricao, valor: valor, date: date));
      }
    }*/
    notifyListeners();
  }

  Future<void> updateGasto(int id, double valor) async {
    final dbData = DbUtil();
    final db = await dbData.database();

    dbData.updateGastosDeLoja(db, id, valor);
    loadLojas();
    notifyListeners();
  }

  //================
  List<custom_card.Card> _cartoes = [];

  List<custom_card.Card> get cartoes {
    return [..._cartoes];
  }

  Future<void> loadCartoes() async {
    final dbData = DbUtil();
    final db = await dbData.database();

    final result = await dbData.getCartaoComCreditos(db);
    print('Resultado vindo do banco: $result');

    List<custom_card.Card> listCartoes = [];
    for (var cartao in result) {
      print('Cartao: $cartao');

      List<Credito> listCredito = [];
      if (cartao['credito'] != []) {
        for (var credito in cartao['credito']) {
          listCredito.add(Credito(
              id: credito['id'],
              descricao: credito['descricao'],
              valor: credito['valor'],
              date: DateTime.parse(credito['data'])));
        }
        listCartoes.add(custom_card.Card(
            id: cartao['id'],
            name: cartao['name'],
            name_pessoa: cartao['name_pessoa'],
            cor: cartao['cor'],
            credito: listCredito));
      } else if (cartao['credito'] == []) {
        listCartoes.add(custom_card.Card(
            id: cartao['id'],
            name: cartao['name'],
            name_pessoa: cartao['name_pessoa'],
            cor: cartao['cor'],
            credito: []));
      }
    }
    _cartoes = listCartoes.toList();
    notifyListeners();
  }

  Future<void> insertCartao(String nome, String nome_pessoa, String cor) async {
    final dbData = DbUtil();
    final db = await dbData.database();
    final Map<String, dynamic> cartao = {
      'name': nome,
      'name_pessoa': nome,
      'cor': cor,
    };
    dbData.insertCartao(db, cartao);
    loadCartoes();

    notifyListeners();
  }

  Future<void> deleteCartao(int id) async {
    final dbData = DbUtil();
    final db = await dbData.database();
    dbData.deleteCartao(db, id);
    loadCartoes();
    notifyListeners();
  }

  Future<void> deleteCredito(int id) async {
    final dbData = DbUtil();
    final db = await dbData.database();
    dbData.deleteCreditoDeCartao(db, id);
    loadCartoes();
    notifyListeners();
  }

  Future<void> insertCredito(
      int id, String descricao, double valor, DateTime date) async {
    final dbData = DbUtil();
    final db = await dbData.database();

    final Map<String, dynamic> credito = {
      'id': id,
      'descricao': descricao,
      'valor': valor,
      'data': date.toIso8601String(),
    };

    dbData.insertGastos(db, credito);
    loadCartoes();
    /*final pessoas = _pessoas;
    for (var pessoa in pessoas) {
      if (pessoa.id == id) {
        pessoa.dinheiro.add(
            Emprestado(id: id, descricao: descricao, valor: valor, date: date));
      }
    }*/
    notifyListeners();
  }

  Future<void> updateCredito(int id, double valor) async {
    final dbData = DbUtil();
    final db = await dbData.database();

    dbData.updateCreditoDeCartao(db, id, valor);
    loadCartoes();
    notifyListeners();
  }
}
