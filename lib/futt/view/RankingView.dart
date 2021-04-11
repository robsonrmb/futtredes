import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/components/TopoInterno.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/subview/RankingSubView.dart';

import '../constantes/ConstantesConfig.dart';
import '../constantes/ConstantesRest.dart';
import '../model/RankingModel.dart';
import '../service/RankingService.dart';
import 'EstatisticasAtletasView.dart';
import 'package:shimmer/shimmer.dart';

class RankingView extends StatefulWidget {
  int idRede;
  String nomeRede;
  int statusRede;
  int ano;
  String cidade;

  RankingView(this.idRede, this.nomeRede, this.statusRede, this.ano,this.cidade);

  @override
  _RankingViewState createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView>
    with TickerProviderStateMixin {
  TabController _controllerRanking;
  String rankSelecionado = 'Media';
  List<String> ranks = new List();
  int number = 4;

  int anoSelect = 0;
  int ano1 = 0;
  int ano2 = 0;
  int ano3 = 0;

  Color colorDefault = Color(0xFF0D47A1);
  Color colorAno1 = Colors.grey[400];
  Color colorAno2 = Colors.grey[400];
  Color colorAno3 = Colors.grey[400];

  Color colorDefaultText = Colors.white;
  Color colorAno1Text = Colors.grey[800];
  Color colorAno2Text = Colors.grey[800];
  Color colorAno3Text = Colors.grey[800];

  @override
  void initState() {
    super.initState();
    _controllerRanking = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    ranks = [
      'Media',
      'Vitoria',
      'Jogos',
      'Pontos',
    ];
    DateTime now = DateTime.now();
    int year = now.year;
    ano1 = year;
    ano2 = year - 1;
    ano3 = year - 2;
    print(year);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
            opacity: 1,
          ),
          textTheme:
              TextTheme(title: TextStyle(color: Colors.white, fontSize: 20)),
          title: Text("Rankings",style: new TextStyle(fontWeight: FontWeight.bold,color: AppColors.colorTextAppNav,
          ),),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[AppColors.colorFundoClaroApp,AppColors.colorFundoEscuroApp])),
          ),
          centerTitle: true,
          // bottom: TabBar(
          //     controller: _controllerRanking,
          //     onTap: (index) {},
          //     tabs: <Widget>[
          //       Tab(text: "Vitórias",),
          //       Tab(text: "Jogos",),
          //       Tab(text: "Pontos",),
          //     ],
          //   )
        ),
        body: new ListView(
          children: [
            TopoInterno().getTopo(widget.nomeRede, widget.statusRede),
            // new Container(
            //   margin: const EdgeInsets.only(left: 16, top: 20),
            //   child: new Text(
            //     'Ranking',
            //     style: new TextStyle(
            //         color: Colors.black,
            //         fontSize: 18,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            new Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              child: new Text(
                'Selecione o ranking:',
                style: new TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            new Container(
              height: 50,
              width: 200,
              margin: const EdgeInsets.only(right: 16, left: 16),
              child: new Card(
                elevation: 5,
                color: Colors.white,
                child: _buildDropRanks(),
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(right: 16, left: 16, top: 16),
              child: new Card(
                  elevation: 5,
                  color: Colors.white,
                  child: new Column(
                    children: [
                      // new Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     new Container(
                      //       margin: const EdgeInsets.only(top: 10, right: 10),
                      //       child: new Text(
                      //         '10/04/2020',
                      //         style: new TextStyle(fontWeight: FontWeight.bold),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      new Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildYears('Últimos 3 anos', colorDefaultText, colorDefault, 1),
                            buildYears(ano1.toString(), colorAno1Text, colorAno1, 2),
                            buildYears(ano2.toString(), colorAno2Text, colorAno2, 3),
                            buildYears(ano3.toString(),colorAno3Text, colorAno3, 4),
                          ],
                        ),
                      ),
                      // new Row(
                      //   children: [
                      //     new Container(
                      //       margin: const EdgeInsets.only(
                      //         left: 20,
                      //         top: 20
                      //       ),
                      //       width: 50,
                      //       height: 50,
                      //       decoration: BoxDecoration(
                      //           image: DecorationImage(
                      //               image: AssetImage("images/torneios.png"),
                      //               fit: BoxFit.cover)),
                      //     ),
                      //     new Container(
                      //       margin: const EdgeInsets.only(left: 8),
                      //       child: new Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           new Text(
                      //             'CBFV',
                      //             style: new TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 18),
                      //           ),
                      //           new Container(
                      //             height: 4,
                      //           ),
                      //           new Text(
                      //             widget.cidade??"",
                      //             style: new TextStyle(color: Colors.grey),
                      //           ),
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                      new Container(
                        height: 30,
                      ),
                      new Container(
                        child: FutureBuilder<List<RankingModel>>(
                          future: _listaRanking(number),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return ListView.builder(
                                  itemCount: 6,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return AnimatedListShimmer(index: index);
                                  },
                                );
                                break;
                              case ConnectionState.active:
                              case ConnectionState.done:
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      List<RankingModel> ranking =
                                          snapshot.data;
                                      RankingModel resultado = ranking[index];
                                      String subText = '';
                                      if (number == 1) {
                                        subText =
                                            '${resultado.pontuacao} Vitorias';
                                      }
                                      if (number == 2) {
                                        subText =
                                            '${resultado.pontuacao} Jogos';
                                      }
                                      if (number == 3) {
                                        subText =
                                            '${resultado.pontuacao} Pontos';
                                      }
                                      if (number == 4) {
                                        subText =
                                            " ${resultado.mediaFormatada}";
                                      }

                                      // return Container(
                                      //   margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.grey[300],
                                      //     borderRadius: BorderRadius.circular(5),
                                      //   ),
                                      //   child: ListTile(
                                      //     leading: CircleAvatar(
                                      //       backgroundImage: NetworkImage(ConstantesRest.URL_BASE_AMAZON + resultado.fotoUsuario),
                                      //       radius: 30.0,
                                      //     ),
                                      //     title: Row(
                                      //       children: <Widget>[
                                      //         Container(
                                      //           decoration: BoxDecoration(
                                      //             color: Color(0xff093352),
                                      //             borderRadius: BorderRadius.circular(50),
                                      //           ),
                                      //           child: Center(
                                      //             child: Text(
                                      //               " ${index+1} ",
                                      //               style: TextStyle(
                                      //                 fontFamily: 'Candal',
                                      //                 color: Colors.white,
                                      //                 fontSize: 20,
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         Flexible(
                                      //           child: Text(
                                      //             " ${resultado.getApelidoFormatado()}",
                                      //             style: TextStyle(
                                      //               fontSize: 14,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     subtitle: Row(
                                      //       children: <Widget>[
                                      //         Text(
                                      //           "  ${resultado.pontuacao2} jogos / ${resultado.pontuacao} vitórias",
                                      //           style: TextStyle(
                                      //             fontSize: 12,
                                      //             fontWeight: FontWeight.bold,
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     trailing: Row(
                                      //         mainAxisSize: MainAxisSize.min,
                                      //         children: <Widget>[
                                      //           Container(
                                      //             width: 50,
                                      //             decoration: BoxDecoration(
                                      //               color: Colors.white,
                                      //               borderRadius: BorderRadius.circular(50),
                                      //             ),
                                      //             child: Center(
                                      //               child: Text(
                                      //                 number == 4?" ${resultado.mediaFormatada} ":'${resultado.pontuacao}',
                                      //                 style: TextStyle(
                                      //                   color: Colors.blue,
                                      //                   fontSize: 16,
                                      //                   fontWeight: FontWeight.bold,
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //           GestureDetector(
                                      //             child: Padding(
                                      //               padding: EdgeInsets.only(left: 20),
                                      //               child: Icon(Icons.insert_chart),
                                      //             ),
                                      //             onTap: (){
                                      //               Navigator.push(context, MaterialPageRoute(
                                      //                 builder: (context) => EstatisticasAtletasView(resultado.idUsuario, widget.idRede, widget.nomeRede, resultado.nomeUsuario, resultado.fotoUsuario),
                                      //               ));
                                      //             },
                                      //           ),
                                      //         ]),
                                      //   ),
                                      // );

                                      return new InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                  transitionDuration: Duration(milliseconds: 700),
                                                  pageBuilder: (_, __, ___) => EstatisticasAtletasView(
                                                    resultado.idUsuario,
                                                    widget.idRede,
                                                    widget.nomeRede,
                                                    resultado.nomeUsuario,
                                                    resultado.fotoUsuario,
                                                    hero: 'user$index',
                                                    colocacao: index+1,
                                                    apelido: resultado.apelidoUsuario,

                                                  ),));
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           EstatisticasAtletasView(
                                          //               resultado.idUsuario,
                                          //               widget.idRede,
                                          //               widget.nomeRede,
                                          //               resultado.nomeUsuario,
                                          //               resultado.fotoUsuario,
                                          //             hero: 'user$index',
                                          //
                                          //           ),
                                          //     ));
                                        },
                                        child: new Column(
                                          children: [
                                            new Row(
                                              children: [
                                                new Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    new Hero(tag: 'user$index', child: new Container(
                                                      height: 58,
                                                      width: 58,
                                                      padding:
                                                      const EdgeInsets.all(
                                                          6),
                                                      margin:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                      child: CircleAvatar(
                                                        backgroundImage: NetworkImage(
                                                            ConstantesRest
                                                                .URL_BASE_AMAZON +
                                                                resultado
                                                                    .fotoUsuario),
                                                        radius: 30.0,
                                                      ),
                                                    ),),
                                                    index < 3?
                                                    _buildStar(index):
                                                        new Container(
                                                          margin: const EdgeInsets.only(right: 10),
                                                          child: new Text('${index+1}',style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                                        )
                                                  ],
                                                ),
                                                new Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 8),
                                                  child: new Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      new Text(
                                                        '${resultado.getApelidoFormatado()}',
                                                        style: new TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      new Container(
                                                        height: 4,
                                                      ),
                                                      new Text(
                                                        subText,
                                                        style: new TextStyle(
                                                            color:
                                                                Colors.orange),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            new Container(
                                              height: 1,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              width: double.infinity,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: Text("Sem valores!!!"),
                                  );
                                }
                                break;
                            }
                            return null;
                          },
                        ),
                      )
                      // new Container(
                      //     child: new ListView.builder(
                      //         itemCount: 10,
                      //         shrinkWrap: true,
                      //         physics: NeverScrollableScrollPhysics(),
                      //         itemBuilder: (BuildContext c, i) {
                      //           return new Column(
                      //             children: [
                      //               new Row(
                      //                 children: [
                      //                   new Container(
                      //                     height: 46,
                      //                     width: 46,
                      //                     margin: const EdgeInsets.only(left: 20),
                      //                     child: CircleAvatar(
                      //                       radius: 30.0,
                      //                       backgroundImage: NetworkImage(
                      //                           "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                      //                       backgroundColor: Colors.transparent,
                      //                     ),
                      //                   ),
                      //                   new Container(
                      //                     margin: const EdgeInsets.only(left: 8),
                      //                     child: new Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         new Text(
                      //                           'Monica dos Santos',
                      //                           style: new TextStyle(
                      //                               fontWeight: FontWeight.bold,
                      //                               fontSize: 16),
                      //                         ),
                      //                         new Container(
                      //                           height: 4,
                      //                         ),
                      //                         new Text(
                      //                           '170 pontos',
                      //                           style: new TextStyle(
                      //                               color: Colors.orange),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   )
                      //                 ],
                      //               ),
                      //               new Container(
                      //                 height: 1,
                      //                 color: Colors.grey.withOpacity(0.5),
                      //                 width: double.infinity,
                      //                 margin: const EdgeInsets.symmetric(
                      //                     horizontal: 20, vertical: 10),
                      //               )
                      //             ],
                      //           );
                      //         }))
                    ],
                  )),
            )
          ],
        )

        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: <Widget>[
        //     TopoInterno().getTopo(widget.nomeRede, widget.statusRede),
        //     Expanded(
        //       child: TabBarView(
        //         controller: _controllerRanking,
        //         children: <Widget>[
        //           RankingSubView(widget.idRede, widget.nomeRede, widget.ano, 1),
        //           RankingSubView(widget.idRede, widget.nomeRede, widget.ano, 2),
        //           RankingSubView(widget.idRede, widget.nomeRede, widget.ano, 3),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
        );
  }

  Widget _buildDropRanks() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Expanded(
          child: Container(
            height: 30,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            padding: EdgeInsets.only(left: 6),
            child: new Container(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text(
                    "  Selecione",
                    style: new TextStyle(color: Colors.grey),
                  ),
                  value: rankSelecionado,
                  style: new TextStyle(color: Colors.black),
                  onChanged: (newValue) {
                    if (newValue == 'Media') {
                      number = 4;
                    }
                    if (newValue == 'Vitoria') {
                      number = 1;
                    }
                    if (newValue == 'Jogos') {
                      number = 2;
                    }
                    if (newValue == 'Pontos') {
                      number = 3;
                    }
                    setState(() {
                      rankSelecionado = newValue;
                    });
                  },
                  items: ranks.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildStar(int ind) {
    switch (ind) {
      case 0:
        return new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            new Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/star1.png"),
                      fit: BoxFit.cover)),
            ),
          ],
        );
        break;
      case 1:
        return new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            new Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/star2.png"),
                      fit: BoxFit.cover)),
            ),
          ],
        );
        break;
      case 2:
        return new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            new Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/star3.png"),
                      fit: BoxFit.cover)),
            ),
          ],
        );
        break;
      default:
        return new Container();
    }
  }

  Future<List<RankingModel>> _listaRanking(int number) async {
    RankingService rankingService = RankingService();
    // int ano = widget.ano;
    // if (ano == 0) {
    //   var now = new DateTime.now();
    //   ano = now.year;
    // }
    return rankingService.listaRankingRede(
        widget.idRede, anoSelect, number, ConstantesConfig.SERVICO_FIXO);
  }


  Widget buildYears(String title, Color colorText, Color color, int index) {
    return new GestureDetector(
      onTap: () {
        selectItemYears(index);
        setState(() {});
      },
      child: new Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: new BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(8)),
        child: new Text(
          title,
          style: new TextStyle(color: colorText),
        ),
      ),
    );
  }

  void selectItemYears(int years) {
    switch (years) {
      case 1:
        anoSelect = 0;
        colorDefault =  Color(0xFF0D47A1);
        colorAno1 = Colors.grey[400];
        colorAno2 = Colors.grey[400];
        colorAno3 = Colors.grey[400];

        colorDefaultText = Colors.white;
        colorAno1Text = Colors.grey[800];
        colorAno2Text = Colors.grey[800];
        colorAno3Text = Colors.grey[800];
        break;
      case 2:
        anoSelect = ano1;
        colorDefault = Colors.grey[400];
        colorAno1 =  Color(0xFF0D47A1);
        colorAno2 = Colors.grey[400];
        colorAno3 = Colors.grey[400];
        colorDefaultText = Colors.grey[800];
        colorAno1Text = Colors.white;
        colorAno2Text = Colors.grey[800];
        colorAno3Text = Colors.grey[800];
        break;
      case 3:
        anoSelect = ano2;
        colorDefault =Colors.grey[400];
        colorAno1 = Colors.grey[400];
        colorAno2 =  Color(0xFF0D47A1);
        colorAno3 = Colors.grey[400];
        colorDefaultText = Colors.grey[800];
        colorAno1Text = Colors.grey[800];
        colorAno2Text = Colors.white;
        colorAno3Text = Colors.grey[800];
        break;
      case 4:
        anoSelect = ano3;
        colorDefault = Colors.grey[400];
        colorAno1 = Colors.grey[400];
        colorAno2 = Colors.grey[400];
        colorAno3 =  Color(0xFF0D47A1);
        colorDefaultText = Colors.grey[800];
        colorAno1Text = Colors.grey[800];
        colorAno2Text = Colors.grey[800];
        colorAno3Text =  Colors.white;
        break;
      default:
        break;
    }
  }
}

class AnimatedListShimmer extends StatefulWidget {
  int index;
  AnimatedListShimmer({this.index});
  @override
  _AnimatedListShimmerState createState() => _AnimatedListShimmerState();
}

class _AnimatedListShimmerState extends State<AnimatedListShimmer> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

      _controller = AnimationController(
        duration: const Duration(milliseconds: 700),
        vsync: this,
      );
      _animation = Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ));
    Future.delayed(Duration(milliseconds: 60*(widget.index+1)),(){
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new SlideTransition(
      position: _animation,
      child: Column(
        children: [
          new Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 26, bottom: 3, top: 3),
                child: Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.5),
                    highlightColor: Colors.white,
                    child: new Container(
                      height: 50,
                      width: 50,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    )),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 8),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.5),
                          highlightColor: Colors.white,
                          child: new Container(
                            height: 20,
                            width: 200,
                            decoration: new BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8)),
                          )),
                    ),
                    new Container(
                      height: 4,
                    ),
                    Container(
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.5),
                          highlightColor: Colors.white,
                          child: new Container(
                            height: 16,
                            width: 140,
                            decoration: new BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8)),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
          new Container(
            height: 1,
            color: Colors.grey.withOpacity(0.5),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          )
        ],
      ),
    );
  }


  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
}
