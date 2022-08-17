import 'package:finances/app/domain/entities/movimentacao_entity.dart';
import 'package:flutter/cupertino.dart';

class ItemMovimentacao extends MovimentacaoEntity {
  int? id;
  String? titulo;
  String? data;
  String? valor;
  bool? isDespesa;
  IconData? icon;
  Color? colorIcon;

  ItemMovimentacao({
    required this.id,
    required this.titulo,
    required this.data,
    required this.valor,
    required this.isDespesa,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    int despesa = isDespesa! ? 0 : 1;
    int code = icon!.codePoint;

    var map = <String, dynamic>{
      'id': id,
      'titulo': titulo,
      'data': data,
      'valor': valor,
      'isDespesa': despesa,
      'icon': code,
    };
    return map;
  }

  ItemMovimentacao.fromMap(Map<String, dynamic> map) {
    int despesa = map['isDespesa'];
    int code = map['icon'];

    id = map['id'];
    titulo = map['titulo'];
    data = map['data'];
    valor = map['valor'];
    isDespesa = despesa == 0 ? true : false;
    icon = IconData(code, fontFamily: 'MaterialIcons');
  }
}
