import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbUtil {
  Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'financial.db'),
        onCreate: _onCreate, version: 1);
  }

  _onCreate(db, version) async {
    await db.execute(_pessoas);
    await db.execute(_emprestado);
    await db.execute(_lojas);
    await db.execute(_compras);
    await db.execute(_cartoes);
    await db.execute(_credito);
    await db.execute(_conta);
    await db.insert('Conta', {'saldo': 0.0});
    await db.execute(_extrato);

    //===== Triggers ======
    await db.execute(_triggerAfterInsertExtrato);
  }

  String get _pessoas => '''
    CREATE TABLE Pessoas (
	    id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL
    );
  ''';
  String get _emprestado => '''
    CREATE TABLE Emprestado (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pessoa_id INTEGER NOT NULL,
    descricao TEXT NOT NULL,
    valor REAL NOT NULL,
    data TEXT NOT NULL,
    FOREIGN KEY (pessoa_id) REFERENCES Pessoas (id) ON DELETE CASCADE
  );
  ''';
  String get _lojas => '''
    CREATE TABLE Lojas (
	    id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL
    );
  ''';
  String get _compras => '''
    CREATE TABLE Compras (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    loja_id INTEGER NOT NULL,
    descricao TEXT NOT NULL,
    valor REAL NOT NULL,
    data TEXT NOT NULL,
    FOREIGN KEY (loja_id) REFERENCES Lojas (id) ON DELETE CASCADE
  );
  ''';
  String get _conta => '''
    CREATE TABLE Conta (
      saldo REAL NOT NULL
    );
  ''';

  String get _cartoes => '''
    CREATE TABLE Cartoes (
	    id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      name_pessoa TEXT NOT NULL,
      cor TEXT NOT NULL
    );
  ''';
  String get _credito => '''
    CREATE TABLE Creditos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cartao_id INTEGER NOT NULL,
    descricao TEXT NOT NULL,
    valor REAL NOT NULL,
    data TEXT NOT NULL,
    FOREIGN KEY (cartao_id) REFERENCES Lojas (id) ON DELETE CASCADE
  );
  ''';
  String get _extrato => '''
    CREATE TABLE Extrato (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      descricao TEXT NOT NULL,
      valor REAL NOT NULL,
      data TEXT NOT NULL,
    );
  ''';
  //INSERIR PESSOA
  Future<void> insertPessoa(Database db, String nome) async {
    await db.insert('Pessoas', {'name': nome});
  }

  //INSERIR DINHEIRO EMPRESTADO
  Future<void> insertDinheiro(Database db, Map<String, dynamic> data) async {
    await db.insert('Emprestado', {
      'pessoa_id': data['id'],
      'descricao': data['descricao'],
      'valor': data['valor'],
      'data': data['data'],
    });
  }

  //PEGAR OS DADOS DE UMA PESSOA
  Future<List<Map<String, dynamic>>> getPessoaComDinheiro(Database db) async {
    final List<Map<String, dynamic>> pessoas = await db.query('Pessoas');
    print('tabela pessoas: $pessoas');

    final List<Map<String, dynamic>> peoplesList = [];
    for (var pessoa in pessoas) {
      print('Local: ${pessoa['name']}');

      final List<Map<String, dynamic>> emprestados = await db.query(
        'Emprestado',
        where: 'pessoa_id = ?',
        whereArgs: [pessoa['id']],
      );
      print('tabela emprestados: $emprestados');
      final List<Map<String, dynamic>> emprestadoList = [];

      if (emprestados.isNotEmpty) {
        for (var dinheiro in emprestados) {
          print(
              '  Descrição: ${dinheiro['descricao']}, Valor: ${dinheiro['valor']}, Data: ${dinheiro['data']}');
          final Map<String, dynamic> map = {
            'id': dinheiro['id'],
            'descricao': dinheiro['descricao'],
            'valor': dinheiro['valor'],
            'data': dinheiro['data'],
          };
          emprestadoList.add(map);
        }
        final Map<String, dynamic> map = {
          'id': pessoa['id'],
          'name': pessoa['name'],
          'emprestado': emprestadoList
        };
        peoplesList.add(map);
      } else {
        final Map<String, dynamic> map = {
          'id': pessoa['id'],
          'name': pessoa['name'],
          'emprestado': []
        };
        peoplesList.add(map);
      }
    }
    print('Resultado final: $peoplesList');
    return peoplesList.toList();
  }

  //SUBTRAIR OS DADOS DE DINHEIRO EMPRESTADO DE UMA PESSOA
  Future<void> updateDinheiroEmprestado(
      Database db, int pessoaId, double novoValor) async {
    await db.update(
      'Emprestado',
      {
        'valor': novoValor,
      },
      where: 'id = ?',
      whereArgs: [pessoaId],
    );
  }

  //DELETAR ITEM DA LISTA DE EMPRESTADO
  Future<void> deleteDinheiroEmprestado(Database db, int id) async {
    await db.delete('Emprestado', where: 'id = ?', whereArgs: [id]);
  }

  //DELETA PESSOA
  Future<void> deletePessoa(Database db, int id) async {
    await db.delete('Pessoas', where: 'id = ?', whereArgs: [id]);
  }

  //================================

  //INSERIR LOJA
  Future<void> insertLoja(Database db, String nome) async {
    await db.insert('Lojas', {'name': nome});
  }

  //INSERIR GASTOS
  Future<void> insertGastos(Database db, Map<String, dynamic> data) async {
    await db.insert('Compras', {
      'loja_id': data['id'],
      'descricao': data['descricao'],
      'valor': data['valor'],
      'data': data['data'],
    });
  }

  //PEGAR A LOJA E SUA LISTA DE GASTOS
  Future<List<Map<String, dynamic>>> getLojaComGastos(Database db) async {
    final List<Map<String, dynamic>> lojas = await db.query('Lojas');
    print('tabela lojas: $lojas');

    final List<Map<String, dynamic>> storeList = [];
    for (var loja in lojas) {
      print('Local: ${loja['name']}');

      final List<Map<String, dynamic>> gastos = await db.query(
        'Compras',
        where: 'loja_id = ?',
        whereArgs: [loja['id']],
      );

      print('tabela gastos: $gastos');
      final List<Map<String, dynamic>> gastoList = [];
      if (gastos.isNotEmpty) {
        for (var gasto in gastos) {
          print(
              '  Descrição: ${gasto['descricao']}, Valor: ${gasto['valor']}, Data: ${gasto['data']}');
          final Map<String, dynamic> map = {
            'id': gasto['id'],
            'descricao': gasto['descricao'],
            'valor': gasto['valor'],
            'data': gasto['data'],
          };
          gastoList.add(map);
        }
        final Map<String, dynamic> map = {
          'id': loja['id'],
          'name': loja['name'],
          'compra': gastoList
        };
        storeList.add(map);
      } else {
        final Map<String, dynamic> map = {
          'id': loja['id'],
          'name': loja['name'],
          'compra': []
        };
        storeList.add(map);
      }
    }
    print('Resultado final lojas: $storeList');
    return storeList.toList();
  }

  //SUBTRAIR VALOR DE UMA CONTA
  Future<void> updateGastosDeLoja(
      Database db, int lojaId, double novoValor) async {
    await db.update(
      'Compras',
      {
        'valor': novoValor,
      },
      where: 'id = ?',
      whereArgs: [lojaId],
    );
  }

  //DELETA UM GASTO
  Future<void> deleteGastosDeLoja(Database db, int id) async {
    await db.delete('Compras', where: 'id = ?', whereArgs: [id]);
  }

  //DELETA LOJA
  Future<void> deleteLoja(Database db, int id) async {
    await db.delete('Lojas', where: 'id = ?', whereArgs: [id]);
  }

//================================

  //PEGAR OS DADOS DE UM CARTÃO
  Future<List<Map<String, dynamic>>> getCartaoComCreditos(Database db) async {
    final List<Map<String, dynamic>> cartoes = await db.query('Cartoes');
    print('tabela cartoes: $cartoes');

    final List<Map<String, dynamic>> cartoesList = [];
    for (var cartao in cartoes) {
      print('Local: ${cartao['name']}');

      final List<Map<String, dynamic>> creditos = await db.query(
        'Creditos',
        where: 'cartao_id = ?',
        whereArgs: [cartao['id']],
      );
      print('tabela creditos: $creditos');
      final List<Map<String, dynamic>> comprasList = [];

      if (creditos.isNotEmpty) {
        for (var credito in creditos) {
          print(
              '  Descrição: ${credito['descricao']}, Valor: ${credito['valor']}, Data: ${credito['data']}');
          final Map<String, dynamic> map = {
            'id': credito['id'],
            'descricao': credito['descricao'],
            'valor': credito['valor'],
            'data': credito['data'],
          };
          comprasList.add(map);
        }
        final Map<String, dynamic> map = {
          'id': cartao['id'],
          'name': cartao['name'],
          'name_pessoa': cartao['name_pessoa'],
          'cor': cartao['cor'],
          'credito': comprasList
        };
        cartoesList.add(map);
      } else {
        final Map<String, dynamic> map = {
          'id': cartao['id'],
          'name': cartao['name'],
          'name_pessoa': cartao['name_pessoa'],
          'cor': cartao['cor'],
          'credito': []
        };
        cartoesList.add(map);
      }
    }
    print('Resultado final: $cartoesList');
    return cartoesList.toList();
  }

  //INSERIR CARTAO
  Future<void> insertCartao(Database db, Map<String, dynamic> data) async {
    await db.insert('Cartoes', {
      'name': data['name'],
      'name_pessoa': data['name_pessoa'],
      'cor': data['cor'],
    });
  }

  //INSERIR CREDITO
  Future<void> insertCredito(Database db, Map<String, dynamic> data) async {
    await db.insert('Creditos', {
      'cartao_id': data['id'],
      'descricao': data['descricao'],
      'valor': data['valor'],
      'data': data['data'],
    });
  }

  //SUBTRAIR VALOR DE UMA CREDITO
  Future<void> updateCreditoDeCartao(
      Database db, int lojaId, double novoValor) async {
    await db.update(
      'Creditos',
      {
        'valor': novoValor,
      },
      where: 'id = ?',
      whereArgs: [lojaId],
    );
  }

  //DELETA UM GASTO
  Future<void> deleteCreditoDeCartao(Database db, int id) async {
    await db.delete('Creditos', where: 'id = ?', whereArgs: [id]);
  }

  //DELETA LOJA
  Future<void> deleteCartao(Database db, int id) async {
    await db.delete('Cartoes', where: 'id = ?', whereArgs: [id]);
  }

  //==================
  //PEGAR OS DADOS DA CONTA
  Future<List<Map<String, dynamic>>> getContaComSaldo(Database db) async {
    final List<Map<String, dynamic>> conta = await db.query('Conta');
    print('tabela conta: $conta');

    return conta.toList();
  }

  //INSERIR VALOR NO SALDO DA CONTA
  Future<void> UpdateSaldo(Database db, double valor) async {
    await db.update('Conta', {
      'saldo': valor,
    });
  }
  //================

  //PEGAR OS DADOS DA CONTA
  Future<List<Map<String, dynamic>>> getExtrato(Database db) async {
    final List<Map<String, dynamic>> extratos = await db.query('Extrato');
    print('tabela Extrato: $extratos');

    final List<Map<String, dynamic>> cartoesList = [];
    for (var extrato in extratos) {
      print('Local: ${extrato['name']}');
      final Map<String, dynamic> map = {
        'id': extrato['id'],
        'descricao': extrato['descricao'],
        'valor': extrato['valor'],
        'data': extrato['data'],
      };
      cartoesList.add(map);
    }
    print('Resultado final: $cartoesList');
    return cartoesList.toList();
  }

  //INSERIR VALOR NO SALDO DA CONTA
  Future<void> insertExtrato(Database db, Map<String, dynamic> data) async {
    await db.insert('Extrato', {
      'descricao': data['descricao'],
      'valor': data['valor'],
      'data': data['data'],
    });
  }

  // ========= CRIAÇÃO DOS  TRIGGERS =========

  String get _triggerAfterInsertExtrato => '''
    CREATE TRIGGER after_insert_extrato
      AFTER INSERT ON Extrato
      BEGIN
      DELETE FROM extrato  WHERE id = (
        SELECT id FROM Extrato ORDER BY data ASC LIMIT 1
      );
    END;
  ''';
}
