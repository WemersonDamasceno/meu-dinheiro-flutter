import 'package:finances/src/models/movimentacoes.dart';
import 'package:finances/src/pages/home/widgets/movimentacao_widget.dart';
import 'package:finances/src/repositories/movimentacao_repositories.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repositorie = MovimentacaoRespositories();
    final List<ItemMovimentacao> listMovimentacao = [];
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * .25,
                width: size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFF08148),
                      Color(0xFFF96C25),
                      Color(0xFFC70C0C),
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                      vertical: size.height * .08),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Olá, Wemerson",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Seja bem vindo!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * .18,
                left: size.width * .05,
                child: SizedBox(
                  height: 100,
                  width: size.width * .9,
                  child: Card(
                    color: const Color(0xFFFF4328),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "Saldo disponível",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "R\$ 0,00",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              color: Colors.white,
                            ),
                            Icon(Icons.visibility_off, color: Colors.white),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 250,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: const Text(
                    "Saldo financeiro",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 80,
                    width: size.width * .4,
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Entradas"),
                          Text(
                            "R\$ 0,00",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: size.width * .4,
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Saidas"),
                          Text("R\$ 0,00",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                          top: 10),
                      child: const Text(
                        "Movimentações",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .44,
                    child: listMovimentacao == []
                        ? ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: listMovimentacao.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemMovimentacaoWidget(
                                  titulo: listMovimentacao[index].titulo,
                                  data: listMovimentacao[index].data,
                                  valor: listMovimentacao[index].valor,
                                  icon: listMovimentacao[index].icon,
                                  despesa: listMovimentacao[index].despesa,
                                  colorIcon: listMovimentacao[index].colorIcon);
                            })
                        : Column(
                            children: [
                              SizedBox(
                                width: size.width * .6,
                                child: LottieBuilder.asset(
                                    "assets/lottie/pig_animation.json"),
                              ),
                              const Text("Você ainda não possui movimentações"),
                            ],
                          ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _configurandoModalBottomSheet(context);
        },
        backgroundColor: const Color(0xFFFF4328),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _configurandoModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: [
              ListTile(
                  leading: const Icon(
                    Icons.add_circle,
                    color: Colors.green,
                  ),
                  title: const Text('Renda ou receita'),
                  onTap: () => {}),
              ListTile(
                leading: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                title: const Text('Despesa'),
                onTap: () => {},
              ),
            ],
          );
        });
  }
}
