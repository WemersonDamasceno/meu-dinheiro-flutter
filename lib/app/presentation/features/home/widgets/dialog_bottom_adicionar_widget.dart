import 'package:finances/app/data/models/movimentacoes.dart';
import 'package:finances/app/presentation/features/home/widgets/input_widget.dart';
import 'package:finances/app/presentation/stores/movimentacoes/movimentacoes_store.dart';
import 'package:flutter/material.dart';

class DialogBottomAdd extends StatefulWidget {
  const DialogBottomAdd({
    required this.storeMov,
    Key? key,
  }) : super(key: key);
  //Instancia do store
  final MovimentacoesStore storeMov;

  @override
  _DialogBottomAddState createState() => _DialogBottomAddState();
}

class _DialogBottomAddState extends State<DialogBottomAdd> {
//Instancia do store
  final storeMov = MovimentacoesStore();
  final controllerTitulo = TextEditingController();
  final controllerValor = TextEditingController();
  var controllerIcon = -1;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SizedBox(
          height: size.height,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 8),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Adicionar uma renda',
                      style: TextStyle(fontSize: 17),
                    )),
              ),
              InputWidget(
                labelText: "Titulo",
                icon: Icons.message,
                txtController: controllerTitulo,
              ),
              const SizedBox(
                height: 10,
              ),
              InputWidget(
                labelText: "Valor",
                icon: Icons.monetization_on_rounded,
                type: TextInputType.number,
                txtController: controllerValor,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Escolha um icone',
                      style: TextStyle(fontSize: 17),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() {
                        controllerIcon = 1;
                      }),
                      child: Container(
                        height: 70,
                        width: 90,
                        color: controllerIcon == 1 ? Colors.red : Colors.transparent,
                        child: const Card(elevation: 1, child: Icon(Icons.account_balance_wallet_rounded)),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        controllerIcon = 2;
                      }),
                      child: Container(
                        height: 70,
                        width: 90,
                        color: controllerIcon == 2 ? Colors.red : Colors.transparent,
                        child: const Card(elevation: 1, child: Icon(Icons.monetization_on_outlined)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .05,
              ),
              SizedBox(
                width: size.width,
                height: size.height * .05,
                child: ElevatedButton(
                    child: const Text(
                      'Adicionar',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      String dia = "${DateTime.now().day}";
                      String mes = "${DateTime.now().month}";
                      if (DateTime.now().day < 10) {
                        dia = "0${DateTime.now().day}";
                      }
                      if (DateTime.now().month < 10) {
                        mes = "0${DateTime.now().month}";
                      }

                      final item = ItemMovimentacao(
                        isDespesa: false,
                        data: "$dia/$mes/${DateTime.now().year}",
                        id: 0,
                        titulo: controllerTitulo.text,
                        valor: controllerValor.text,
                        icon: Icons.account_balance_wallet_rounded,
                      );

                      storeMov.addItemMovimentacao(item);
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
