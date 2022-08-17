import 'package:flutter/material.dart';

class ItemMovimentacaoWidget extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String data;
  final String valor;
  final bool despesa;
  const ItemMovimentacaoWidget({
    Key? key,
    required this.titulo,
    required this.data,
    required this.valor,
    required this.icon,
    required this.despesa,
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
                      primary: despesa ? Colors.red.shade400 : Colors.green,
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
                  ? Text("- ${valor + ".00"}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800))
                  : Text("+ ${valor + ".00"}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
  }
}
