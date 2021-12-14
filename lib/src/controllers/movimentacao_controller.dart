import 'package:flutter/material.dart';

class MovimentacaoController {
  static MovimentacaoController instance = MovimentacaoController();

  final controllerTitulo = TextEditingController();
  final controllerValor = TextEditingController();
  var controllerIcon = -1;
}
