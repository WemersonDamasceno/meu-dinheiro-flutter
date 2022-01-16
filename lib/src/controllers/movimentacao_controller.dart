import 'package:finances/src/models/movimentacoes.dart';
import 'package:finances/src/repositories/movimentacao_repositories.dart';

class MovimentacaoController {
  static MovimentacaoController instance = MovimentacaoController();
  final _repositorie = MovimentacaoRespositories();

  

  List<ItemMovimentacao> getList() {
    return _repositorie.getListMovimentacoes();
  }
}
