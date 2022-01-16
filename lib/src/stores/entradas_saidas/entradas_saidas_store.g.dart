// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entradas_saidas_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EntradasSaidas on _EntradasSaidas, Store {
  final _$saldoAtom = Atom(name: '_EntradasSaidas.saldo');

  @override
  double get saldo {
    _$saldoAtom.reportRead();
    return super.saldo;
  }

  @override
  set saldo(double value) {
    _$saldoAtom.reportWrite(value, super.saldo, () {
      super.saldo = value;
    });
  }

  final _$entradasTotalAtom = Atom(name: '_EntradasSaidas.entradasTotal');

  @override
  double get entradasTotal {
    _$entradasTotalAtom.reportRead();
    return super.entradasTotal;
  }

  @override
  set entradasTotal(double value) {
    _$entradasTotalAtom.reportWrite(value, super.entradasTotal, () {
      super.entradasTotal = value;
    });
  }

  final _$saidasTotalAtom = Atom(name: '_EntradasSaidas.saidasTotal');

  @override
  double get saidasTotal {
    _$saidasTotalAtom.reportRead();
    return super.saidasTotal;
  }

  @override
  set saidasTotal(double value) {
    _$saidasTotalAtom.reportWrite(value, super.saidasTotal, () {
      super.saidasTotal = value;
    });
  }

  final _$_EntradasSaidasActionController =
      ActionController(name: '_EntradasSaidas');

  @override
  dynamic addEntradas(double valor) {
    final _$actionInfo = _$_EntradasSaidasActionController.startAction(
        name: '_EntradasSaidas.addEntradas');
    try {
      return super.addEntradas(valor);
    } finally {
      _$_EntradasSaidasActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addSaidas(double valor) {
    final _$actionInfo = _$_EntradasSaidasActionController.startAction(
        name: '_EntradasSaidas.addSaidas');
    try {
      return super.addSaidas(valor);
    } finally {
      _$_EntradasSaidasActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic atualizarSaldo() {
    final _$actionInfo = _$_EntradasSaidasActionController.startAction(
        name: '_EntradasSaidas.atualizarSaldo');
    try {
      return super.atualizarSaldo();
    } finally {
      _$_EntradasSaidasActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
saldo: ${saldo},
entradasTotal: ${entradasTotal},
saidasTotal: ${saidasTotal}
    ''';
  }
}
