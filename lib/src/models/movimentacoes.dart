import 'package:flutter/cupertino.dart';

class ItemMovimentacao {
  final String titulo;
  final String data;
  final String valor;
  final bool despesa;
  final IconData icon;
  final Color colorIcon;

  ItemMovimentacao(
      {required this.colorIcon,
      required this.titulo,
      required this.data,
      required this.valor,
      required this.despesa,
      required this.icon});
}
