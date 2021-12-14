import 'package:finances/src/controllers/movimentacao_controller.dart';
import 'package:flutter/material.dart';

import 'input_widget.dart';

class DialogBottomAdd extends StatefulWidget {
  const DialogBottomAdd({Key? key}) : super(key: key);

  @override
  _DialogBottomAddState createState() => _DialogBottomAddState();
}

class _DialogBottomAddState extends State<DialogBottomAdd> {
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
                txtController: MovimentacaoController.instance.controllerTitulo,
              ),
              const SizedBox(
                height: 10,
              ),
              InputWidget(
                labelText: "Valor",
                icon: Icons.monetization_on_rounded,
                type: TextInputType.number,
                txtController: MovimentacaoController.instance.controllerValor,
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
                        MovimentacaoController.instance.controllerIcon = 1;
                      }),
                      child: Container(
                        height: 70,
                        width: 90,
                        color:
                            MovimentacaoController.instance.controllerIcon == 1
                                ? Colors.red
                                : Colors.transparent,
                        child: const Card(
                            elevation: 1,
                            child: Icon(Icons.account_balance_wallet_rounded)),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        MovimentacaoController.instance.controllerIcon = 2;
                      }),
                      child: Container(
                        height: 70,
                        width: 90,
                        color:
                            MovimentacaoController.instance.controllerIcon == 2
                                ? Colors.red
                                : Colors.transparent,
                        child: const Card(
                            elevation: 1,
                            child: Icon(Icons.monetization_on_outlined)),
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
                  onPressed: () => Navigator.pop(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
