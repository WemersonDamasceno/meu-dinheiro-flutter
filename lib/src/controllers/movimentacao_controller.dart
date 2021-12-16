import 'package:finances/src/models/movimentacoes.dart';
import 'package:finances/src/repositories/movimentacao_repositories.dart';
import 'package:flutter/material.dart';

class MovimentacaoController {
  static MovimentacaoController instance = MovimentacaoController();
  final _repositorie = MovimentacaoRespositories();

  final controllerTitulo = TextEditingController();
  final controllerValor = TextEditingController();
  var controllerIcon = -1;

  List<ItemMovimentacao> getList() {
    return _repositorie.getListMovimentacoes();
  }
}
