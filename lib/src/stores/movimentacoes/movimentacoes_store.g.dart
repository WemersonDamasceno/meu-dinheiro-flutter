// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movimentacoes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovimentacoesStore on _MovimentacoesStore, Store {
  final _$listMovimentacaoAtom =
      Atom(name: '_MovimentacoesStore.listMovimentacao');

  @override
  ObservableList<ItemMovimentacao> get listMovimentacao {
    _$listMovimentacaoAtom.reportRead();
    return super.listMovimentacao;
  }

  @override
  set listMovimentacao(ObservableList<ItemMovimentacao> value) {
    _$listMovimentacaoAtom.reportWrite(value, super.listMovimentacao, () {
      super.listMovimentacao = value;
    });
  }

  final _$_MovimentacoesStoreActionController =
      ActionController(name: '_MovimentacoesStore');

  @override
  dynamic addItemMovimentacao(ItemMovimentacao item) {
    final _$actionInfo = _$_MovimentacoesStoreActionController.startAction(
        name: '_MovimentacoesStore.addItemMovimentacao');
    try {
      return super.addItemMovimentacao(item);
    } finally {
      _$_MovimentacoesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeItemMovimentacao(ItemMovimentacao item) {
    final _$actionInfo = _$_MovimentacoesStoreActionController.startAction(
        name: '_MovimentacoesStore.removeItemMovimentacao');
    try {
      return super.removeItemMovimentacao(item);
    } finally {
      _$_MovimentacoesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listMovimentacao: ${listMovimentacao}
    ''';
  }
}
