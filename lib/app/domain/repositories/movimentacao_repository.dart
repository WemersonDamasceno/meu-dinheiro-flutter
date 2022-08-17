import 'package:finances/app/domain/entities/movimentacao_entity.dart';

abstract class MovimentacaoRepository {
  Future<List<MovimentacaoEntity>> getListMovimentacoes();
}
