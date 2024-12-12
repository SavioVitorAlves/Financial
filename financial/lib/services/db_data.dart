import 'package:financial/models/pessoa.dart';
import 'package:financial/utils/db_util.dart';

class DbData {
  List<Pessoa> _pessoas = [];

  List<Pessoa> get meses {
    return [..._pessoas];
  }

  DbData([this._pessoas = const []]);

  Future<void> loadPessoas() async {
    final dbData = DbUtil();
    final db = await dbData.database();

    final result = await dbData.getPessoaComDinheiro(db);
  }
}
