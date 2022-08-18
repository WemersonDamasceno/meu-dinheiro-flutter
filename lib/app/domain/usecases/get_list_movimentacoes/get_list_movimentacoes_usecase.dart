import 'package:finances/app/domain/entities/movimentacao_entity.dart';
import 'package:finances/app/domain/repositories/movimentacao_repository.dart';

class GetListMovimentacoes {
  late MovimentacaoRepository _repositorie;

  GetListMovimentacoes(this._repositorie);

  Future<List<MovimentacaoEntity>> getList() async {
    return await _repositorie.getListMovimentacoes();
  }
}
