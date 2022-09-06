import 'package:finances/app/data/datasources/db_Provider.dart';
import 'package:finances/app/data/models/movimentacoes.dart';
import 'package:finances/app/presentation/features/home/widgets/input_widget.dart';
import 'package:finances/app/presentation/features/home/widgets/movimentacao_widget.dart';
import 'package:finances/app/presentation/stores/auth/auth_store.dart';
import 'package:finances/app/presentation/stores/entradas_saidas/entradas_saidas_store.dart';
import 'package:finances/app/presentation/stores/movimentacoes/movimentacoes_store.dart';
import 'package:finances/core/shared_preferences.dart';
import 'package:finances/core/utils/showcase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:showcaseview/showcaseview.dart';

//Instancia dos stores
final storeMov = MovimentacoesStore();
final storeSaldo = EntradasSaidas();
final storeAuth = AuthStore();

//instancia do SQLite
MovimentacoesDbProvider dbSQLite = MovimentacoesDbProvider();

//Controller dos inputs
TextEditingController controllerTitulo = TextEditingController();
TextEditingController controllerValor = TextEditingController();
var controllerIcon = 1;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _oneKey = GlobalKey();
  final _twoKey = GlobalKey();
  final _threeKey = GlobalKey();

  bool exibirSaldo = false;
  bool _isShowcase = false;
  var movimentacoes = [];
  String? name = "";

  @override
  void dispose() {
    controllerIcon = 1;
    controllerTitulo.dispose();
    controllerValor.dispose();
    super.dispose();
  }

  @override
  void initState() {
    buscarMovimentacoesNoSQLite();
    initShowcase();
    super.initState();
  }

  void initShowcase() async {
    _isShowcase = await SharedPref().read("showcase") ?? true;
    if (_isShowcase) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([
          _oneKey,
          _twoKey,
          _threeKey,
        ]),
      );
    }
  }

  Future<void> buscarMovimentacoesNoSQLite() async {
    name = await SharedPref().read("name");
    storeAuth.setName(name!);
    WidgetsFlutterBinding.ensureInitialized();
    movimentacoes = await dbSQLite.buscarMovimentacoes();
    if (movimentacoes.length > 0) {
      movimentacoes.forEach((element) {
        storeMov.addItemMovimentacao(element);
      });

      storeMov.listMovimentacao.forEach((item) {
        double valor = double.parse(item.valor!);
        if (item.isDespesa!) {
          storeSaldo.addSaidas(valor);
        } else {
          storeSaldo.addEntradas(valor);
        }
      });

      storeSaldo.atualizarSaldo();
    }
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      body: homePageBodyWidget(_size),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _exibirModalBottomSheet(context);
        },
        backgroundColor: const Color(0xFFFF4328),
        child: CustomShowCase(
            isShowCase: _isShowcase,
            keyGlobal: _threeKey,
            title: "Adicione uma nova movimentação",
            description: "Clique aqui para adicionar uma nova movimentação",
            child: const Icon(Icons.add)),
      ),
    );
  }

  Widget homePageBodyWidget(Size _size) {
    return SizedBox(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: _size.height * .25,
                width: _size.width,
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
                  padding: EdgeInsets.symmetric(horizontal: _size.width * 0.1, vertical: _size.height * .08),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Observer(
                              builder: (context) {
                                return Text(
                                  "Olá, ${storeAuth.name}",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                            Text(
                              "Seja bem vindo!",
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              await storeAuth.logout();
                              Navigator.popAndPushNamed(context, '/splash');
                            },
                            icon: CustomShowCase(
                              isShowCase: _isShowcase,
                              keyGlobal: _oneKey,
                              title: "Faça Logout",
                              description: 'Ao fazer logout todo o\nseu historico é apagado',
                              child: Icon(
                                Icons.output_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: _size.height * .18,
                left: _size.width * .05,
                child: SizedBox(
                  height: _size.height * .13,
                  width: _size.width * .9,
                  child: Card(
                    color: const Color(0xFFFF4328),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Saldo disponível",
                              style: TextStyle(color: Colors.white),
                            ),
                            Observer(
                                builder: (context) => Row(
                                      children: [
                                        !exibirSaldo
                                            ? CustomShowCase(
                                                keyGlobal: _twoKey,
                                                title: "Seu saldo",
                                                isShowCase: _isShowcase,
                                                description: "Aqui está seu saldo em reais",
                                                child: Text(
                                                    "${NumberFormat.currency(symbol: "R\$", decimalDigits: 2).format(storeSaldo.saldo)}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w700)),
                                              )
                                            : Container(
                                                height: 20,
                                                width: 100,
                                                color: Colors.red.shade200,
                                              )
                                      ],
                                    )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              Icons.account_balance_wallet_outlined,
                              color: Colors.white,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    exibirSaldo = !exibirSaldo;
                                  });
                                },
                                icon: exibirSaldo
                                    ? Icon(Icons.visibility_off, color: Colors.white)
                                    : Icon(Icons.visibility_rounded, color: Colors.white))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: _size.height * .32,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: _size.width * 0.05),
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
                    width: _size.width * .5,
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Entradas"),
                          Observer(
                            builder: (context) => Text(
                              "R\$ ${storeSaldo.entradasTotal.toStringAsFixed(2)}",
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: _size.width * .5,
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Saidas"),
                          Observer(
                            builder: (context) => Text(
                              "R\$ ${storeSaldo.saidasTotal.toStringAsFixed(2)}",
                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
                            ),
                          ),
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
                      padding: EdgeInsets.only(left: _size.width * 0.05, right: _size.width * 0.05, top: 10),
                      child: const Text(
                        "Movimentações",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Observer(
                    builder: (_) => SizedBox(
                      height: _size.height * .44,
                      child: storeMov.listMovimentacao.length > 0
                          ? Observer(
                              builder: (_) => ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: storeMov.listMovimentacao.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    final item = ItemMovimentacaoWidget(
                                      titulo: storeMov.listMovimentacao[index].titulo!,
                                      data: storeMov.listMovimentacao[index].data!,
                                      valor: storeMov.listMovimentacao[index].valor!,
                                      icon: storeMov.listMovimentacao[index].icon!,
                                      despesa: storeMov.listMovimentacao[index].isDespesa!,
                                    );

                                    return Slidable(
                                      child: item,
                                      actionPane: const SlidableDrawerActionPane(),
                                      actionExtentRatio: 0.25,
                                      actions: [
                                        IconSlideAction(
                                          caption: "Deletar",
                                          icon: Icons.delete,
                                          color: Colors.red,
                                          foregroundColor: Colors.white,
                                          onTap: () async {
                                            double valor = double.parse(storeMov.listMovimentacao[index].valor!);

                                            valor = valor * -1;
                                            if (storeMov.listMovimentacao[index].isDespesa!) {
                                              storeSaldo.addSaidas(valor);
                                            } else {
                                              storeSaldo.addEntradas(valor);
                                            }
                                            storeSaldo.atualizarSaldo();
                                            //remover do banco
                                            await dbSQLite.deletarMovimentacoes(storeMov.listMovimentacao[index].id!);

                                            //Tirar da lista
                                            storeMov.removeItemMovimentacao(storeMov.listMovimentacao[index]);
                                          },
                                        )
                                      ],
                                    );
                                  }),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  width: _size.width * .6,
                                  child: LottieBuilder.asset("lib/core/assets/lottie/pig_animation.json"),
                                ),
                                const Text("Você ainda não possui movimentações"),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _exibirModalBottomSheet(context) {
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
                  title: const Text('Entradas'),
                  onTap: () {
                    Navigator.pop(context);
                    _exibirDialogEntradas(context);
                  }),
              ListTile(
                  leading: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                  title: const Text('Despesas'),
                  onTap: () {
                    Navigator.pop(context);
                    _exibirDialogSaidas(context);
                  }),
            ],
          );
        });
  }

  void _exibirDialogEntradas(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return DialogAddEntradas();
        });
  }

  void _exibirDialogSaidas(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return DialogAddSaidas();
        });
  }
}

class DialogAddSaidas extends StatefulWidget {
  const DialogAddSaidas({Key? key}) : super(key: key);

  @override
  _DialogAddSaidasState createState() => _DialogAddSaidasState();
}

class _DialogAddSaidasState extends State<DialogAddSaidas> {
  @override
  void dispose() {
    controllerIcon = 1;
    controllerTitulo.dispose();
    controllerValor.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controllerIcon = 1;
    controllerValor = TextEditingController();
    controllerTitulo = TextEditingController();
    super.initState();
  }

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
                      'Adicionar uma despesa',
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
                        child: const Card(elevation: 1, child: Icon(Icons.water_damage_outlined)),
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
                        child: const Card(elevation: 1, child: Icon(Icons.money_off)),
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
                    onPressed: () async {
                      String dia = "${DateTime.now().day}";
                      String mes = "${DateTime.now().month}";
                      if (DateTime.now().day < 10) {
                        dia = "0${DateTime.now().day}";
                      }
                      if (DateTime.now().month < 10) {
                        mes = "0${DateTime.now().month}";
                      }

                      int? idItem = 0;

                      if (storeMov.listMovimentacao.isEmpty) {
                        idItem = 0;
                      } else {
                        idItem = storeMov.listMovimentacao.last.id! + 1;
                      }

                      final item = ItemMovimentacao(
                        isDespesa: true,
                        data: "$dia/$mes/${DateTime.now().year}",
                        id: idItem,
                        titulo: controllerTitulo.text,
                        valor: controllerValor.text,
                        icon: controllerIcon == 1 ? Icons.water_damage_outlined : Icons.money_off,
                      );

                      //Metodo do store para adicionar na lista
                      storeMov.addItemMovimentacao(item);

                      //Salvar no bd
                      await dbSQLite.addItem(item);

                      double valor = double.parse(controllerValor.text);
                      storeSaldo.addSaidas(valor);
                      storeSaldo.atualizarSaldo();
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

class DialogAddEntradas extends StatefulWidget {
  const DialogAddEntradas({Key? key}) : super(key: key);

  @override
  _DialogAddEntradasState createState() => _DialogAddEntradasState();
}

class _DialogAddEntradasState extends State<DialogAddEntradas> {
  @override
  void dispose() {
    controllerIcon = 1;
    controllerTitulo.dispose();
    controllerValor.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controllerIcon = 1;
    controllerValor = TextEditingController();
    controllerTitulo = TextEditingController();
    super.initState();
  }

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
                        child: const Card(
                          elevation: 1,
                          child: Icon(Icons.account_balance_wallet_rounded),
                        ),
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
                    onPressed: () async {
                      String dia = "${DateTime.now().day}";
                      String mes = "${DateTime.now().month}";
                      if (DateTime.now().day < 10) {
                        dia = "0${DateTime.now().day}";
                      }
                      if (DateTime.now().month < 10) {
                        mes = "0${DateTime.now().month}";
                      }

                      int? idItem = 0;

                      if (storeMov.listMovimentacao.isEmpty) {
                        idItem = 0;
                      } else {
                        idItem = storeMov.listMovimentacao.last.id! + 1;
                      }
                      final item = ItemMovimentacao(
                        isDespesa: false,
                        data: "$dia/$mes/${DateTime.now().year}",
                        id: idItem,
                        titulo: controllerTitulo.text,
                        valor: controllerValor.text,
                        icon:
                            controllerIcon == 1 ? Icons.account_balance_wallet_rounded : Icons.monetization_on_outlined,
                      );

                      storeMov.addItemMovimentacao(item);
                      //Salvar no bd
                      await dbSQLite.addItem(item);

                      double valor = double.parse(controllerValor.text);
                      storeSaldo.addEntradas(valor);
                      storeSaldo.atualizarSaldo();

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
