import 'package:mobx/mobx.dart';

part 'entradas_saidas_store.g.dart';

class EntradasSaidas = _EntradasSaidas with _$EntradasSaidas;

abstract class _EntradasSaidas with Store {
  @observable
  double saldo = 0;
  @observable
  double entradasTotal = 0;
  @observable
  double saidasTotal = 0;

  @action
  void addEntradas(double valor) {
    entradasTotal = entradasTotal + valor;
  }

  @action
  void addSaidas(double valor) {
    saidasTotal = saidasTotal + valor;
  }

  @action
  void atualizarSaldo() {
    saldo = entradasTotal - saidasTotal;
  }
}
