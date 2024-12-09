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
    await db.execute(_conta);
    await db.insert('conta', {'saldo': 0.0});
  }

  String get _pessoas => '''
    CREATE TABLE Pessoas (
	    id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOTNULL,
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
      name TEXT NOTNULL,
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
      saldo REAL NOTNULL,
    );
  ''';

  //INSERIR PESSOA
  Future<void> insertPessoa(Database db, String nome) async {
    await db.insert('Peoples', {'nome': nome});
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
  Future<void> getPessoaComDinheiro(Database db) async {
    final List<Map<String, dynamic>> pessoas = await db.query('Pessoas');

    for (var pessoa in pessoas) {
      print('Local: ${pessoa['nome']}');

      final List<Map<String, dynamic>> emprestados = await db.query(
        'Emprestado',
        where: 'pessoa_id = ?',
        whereArgs: [pessoa['id']],
      );

      for (var dinheiro in emprestados) {
        print(
            '  Descrição: ${dinheiro['descricao']}, Valor: ${dinheiro['valor']}, Data: ${dinheiro['data']}');
      }
    }
  }

  //SUBTRAIR OS DADOS DE DINHEIRO EMPRESTADO DE UMA PESSOA
  Future<void> updateDinheiroEmprestado(
      Database db, Map<String, dynamic> data) async {
    await db.update(
      'Emprestado',
      {
        'descricao': data['descricao'],
        'valor': data['valor'],
        'data': data['data'],
      },
      where: 'id = ?',
      whereArgs: [data['pessoa_id']],
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
    await db.insert('Lojas', {'nome': nome});
  }

  //INSERIR GASTOS
  Future<void> insertGastos(Database db, Map<String, dynamic> data) async {
    await db.insert('Gastos', {
      'pessoa_id': data['id'],
      'descricao': data['descricao'],
      'valor': data['valor'],
      'data': data['data'],
    });
  }

  //PEGAR A LOJA E SUA LISTA DE GASTOS
  Future<void> getLojaComGastos(Database db) async {
    final List<Map<String, dynamic>> lojas = await db.query('Lojas');

    for (var loja in lojas) {
      print('Local: ${loja['nome']}');

      final List<Map<String, dynamic>> gastos = await db.query(
        'Gastos',
        where: 'loja_id = ?',
        whereArgs: [loja['id']],
      );

      for (var gasto in gastos) {
        print(
            '  Descrição: ${gasto['descricao']}, Valor: ${gasto['valor']}, Data: ${gasto['data']}');
      }
    }
  }

  //SUBTRAIR VALOR DE UMA CONTA
  Future<void> updateGastosDeLoja(
      Database db, Map<String, dynamic> data) async {
    await db.update(
      'Gastos',
      {
        'descricao': data['descricao'],
        'valor': data['valor'],
        'data': data['data'],
      },
      where: 'id = ?',
      whereArgs: [data['loja_id']],
    );
  }

  //DELETA UM GASTO
  Future<void> deleteGastosDeLoja(Database db, int id) async {
    await db.delete('Gastos', where: 'id = ?', whereArgs: [id]);
  }

  //DELETA LOJA
  Future<void> deleteLoja(Database db, int id) async {
    await db.delete('Lojas', where: 'id = ?', whereArgs: [id]);
  }
}
