import 'package:finances/app/domain/entities/movimentacao_entity.dart';
import 'package:finances/app/domain/repositories/movimentacao_repository.dart';

class MovimentacaoRespositoryImp implements MovimentacaoRepository {
  @override
  Future<List<MovimentacaoEntity>> getListMovimentacoes() async {
    final res = <MovimentacaoEntity>[];
    return res;
  }
}
