import 'package:dinheiro_certo/app/domain/entities/movimentacao_entity.dart';

abstract class MovimentacaoRepository {
  Future<List<MovimentacaoEntity>> getListMovimentacoes();
}
