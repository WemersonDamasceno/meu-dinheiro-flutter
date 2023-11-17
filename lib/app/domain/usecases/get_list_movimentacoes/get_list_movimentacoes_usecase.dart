import 'package:dinheiro_certo/app/domain/entities/movimentacao_entity.dart';
import 'package:dinheiro_certo/app/domain/repositories/movimentacao_repository.dart';

class GetListMovimentacoes {
  GetListMovimentacoes(this._repositorie);
  late final MovimentacaoRepository _repositorie;

  Future<List<MovimentacaoEntity>> getList() async {
    return await _repositorie.getListMovimentacoes();
  }
}
