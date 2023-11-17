import 'package:dinheiro_certo/app/data/models/movimentacoes.dart';
import 'package:mobx/mobx.dart';

part 'movimentacoes_store.g.dart';

class MovimentacoesStore = _MovimentacoesStore with _$MovimentacoesStore;

abstract class _MovimentacoesStore with Store {
  @observable
  ObservableList<ItemMovimentacao> listMovimentacao =
      ObservableList<ItemMovimentacao>();

  @action
  void addItemMovimentacao(ItemMovimentacao item) {
    listMovimentacao.add(item);
  }

  @action
  void removeItemMovimentacao(ItemMovimentacao item) {
    listMovimentacao.remove(item);
  }
}
