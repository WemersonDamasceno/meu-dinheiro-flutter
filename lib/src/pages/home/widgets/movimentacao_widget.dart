import 'package:flutter/material.dart';

class ItemMovimentacaoWidget extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String data;
  final String valor;
  final bool despesa;
  final Color colorIcon;
  const ItemMovimentacaoWidget({
    Key? key,
    required this.titulo,
    required this.data,
    required this.valor,
    required this.icon,
    required this.despesa,
    required this.colorIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 80,
      width: size.width * .9,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: ElevatedButton(
                    child: SizedBox(
                      child: Icon(icon),
                      height: 50,
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: colorIcon,
                      shape: const CircleBorder(),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w800),
                    ),
                    Text(data),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: despesa
                  ? Text("- $valor",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800))
                  : Text("+ $valor",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
  }
}
