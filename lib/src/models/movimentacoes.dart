import 'package:flutter/cupertino.dart';

class ItemMovimentacao {
  int id;
  String titulo;
  String data;
  String valor;
  bool isDespesa;
  IconData icon;
  Color colorIcon;

  ItemMovimentacao({
    required this.id,
    required this.colorIcon,
    required this.titulo,
    required this.data,
    required this.valor,
    required this.isDespesa,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'titulo': titulo,
      'data': data,
      'valor': valor,
      'colorIcon': colorIcon,
      'isDespesa': isDespesa,
      'icon': icon,
    };
    return map;
  }

  ItemMovimentacao fromMap(Map<String, dynamic> map) {
    id = map['id'];
    titulo = map['titulo'];
    data = map['data'];
    valor = map['valor'];
    colorIcon = map['colorIcon'];
    isDespesa = map['isDespesa'];
    icon = map['icon'];

    return ItemMovimentacao(
        id: id,
        colorIcon: colorIcon,
        titulo: titulo,
        data: data,
        valor: valor,
        isDespesa: isDespesa,
        icon: icon);
  }
}
