import 'package:financial/models/pessoa.dart';
import 'package:financial/utils/db_util.dart';

class DbData {
  List<Pessoa> _pessoas = [];

  List<Pessoa> get pessoas {
    return [..._pessoas];
  }

  DbData([this._pessoas = const []]);

  Future<void> loadPessoas() async {
    final dbData = DbUtil();
    final db = await dbData.database();

    final result = await dbData.getPessoaComDinheiro(db);
    List<Pessoa> listPessoa = [];
    result.forEach((pessoa) {
      pessoa.forEach((key, people) {
        listPessoa.add(Pessoa(
            id: int.parse(key),
            nome: people['name'],
            dinheiro: people['emprestado']));
      });
    });
    _pessoas = listPessoa.toList();
  }

  Future<void> insertPessoa(String nome) async {
    final dbData = DbUtil();
    final db = await dbData.database();
    dbData.insertPessoa(db, nome);
    loadPessoas();
  }

  Future<void> deletePessoa(int id) async {
    final dbData = DbUtil();
    final db = await dbData.database();
    dbData.deletePessoa(db, id);
    loadPessoas();
  }

  Future<void> deleteDinheiro(int id) async {
    final dbData = DbUtil();
    final db = await dbData.database();
    dbData.deletePessoa(db, id);
    loadPessoas();
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
  }

  Future<void> updateDinheiro(int id, String descricao, double valor,
      DateTime date, double diminuir) async {
    final dbData = DbUtil();
    final db = await dbData.database();

    final resultado = valor - diminuir;

    final Map<String, dynamic> dinheiroAtualizado = {
      'pessoa_id': id,
      'descricao': descricao,
      'valor': resultado,
      'data': date.toIso8601String(),
    };

    dbData.updateDinheiroEmprestado(db, dinheiroAtualizado);
    loadPessoas();
  }
}
