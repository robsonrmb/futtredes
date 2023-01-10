import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/service/RedeService.dart';
import 'package:futt/futt/view/JogosView.dart';
import 'package:futt/futt/view/IntegrantesView.dart';
import 'package:futt/futt/view/components/Apresentacao.dart';
import 'package:futt/futt/view/components/animation.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../RankingView.dart';

class RedesSubView extends StatefulWidget {
  @override
  _RedesSubViewState createState() => _RedesSubViewState();
}

class _RedesSubViewState extends State<RedesSubView> {
  Future<List<RedeModel>> _listaRedesQueParticipo() async {
    RedeService redeService = RedeService();
    return redeService.listaRedesQueParticipo(ConstantesConfig.SERVICO_FIXO);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RedeModel>>(
      future: _listaRedesQueParticipo(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: Text("None!!!"),
            );
          case ConnectionState.waiting:
            return ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return new FadeAnimation(
                  0.5 * index,
                  Column(
                    children: <Widget>[
                      Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.5),
                          highlightColor: Colors.white,
                          child: new Container(
                            height: 140,
                            decoration: new BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          )),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          //borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          child: ListTile(
                            title: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.5),
                                      highlightColor: Colors.white,
                                      child: new Container(
                                        height: 30,
                                        width: 100,
                                        decoration: new BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            subtitle: Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.5),
                                highlightColor: Colors.white,
                                child: new Container(
                                  height: 30,
                                  width: 150,
                                  decoration: new BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                )),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.5),
                                      highlightColor: Colors.white,
                                      child: new Container(
                                        height: 30,
                                        width: 30,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      )),
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.5),
                                      highlightColor: Colors.white,
                                      child: new Container(
                                        height: 30,
                                        width: 30,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      )),
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.5),
                                      highlightColor: Colors.white,
                                      child: new Container(
                                        height: 30,
                                        width: 30,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      )),
                                ]),
                          ),
                        ),
                      ),
                      Container(
                        height: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  horizontal: true,
                );
              },
            );
            break;
          case ConnectionState.active:
            return Center(
              child: Text("Active!!!"),
            );
          case ConnectionState.done:
            if (snapshot.hasData && snapshot.data.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  List<RedeModel> redes = snapshot.data;
                  RedeModel rede = redes[index];

                  return new Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: new Container(
                      decoration: new BoxDecoration(
                        border: Border.all(width: 2,color: Colors.white),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                                color: Colors.grey[300].withOpacity(0.5),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        ConstantesRest.URL_STATIC_REDES +
                                            rede.nomeFoto),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),                               //borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          new Container(height: 2,width: double.infinity,color: Colors.white,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(4.0),
                                bottomLeft: Radius.circular(4.0),
                              ),
                              gradient: LinearGradient(
                                colors: <Color>[AppColors.colorFundoCardClaro, AppColors.colorFundoCardEscuro],
                              ),
                              //borderRadius: BorderRadius.circular(5),
                            ),
                            child: GestureDetector(
                              child: ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        "${rede.nome}",
                                        style: TextStyle(
                                          fontSize: 16,

                                          color: rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorTextTitle : AppColors.colorRedeDesabilitadaTextICon,

                                          //AppColors.colorTextTitle,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle:
                                Text(
                                  _retorneSubtitulo(rede.pais, rede.cidade, rede.local),
                                  style: TextStyle(
                                    fontSize: 14,
                                      color: rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorSubTitle : AppColors.colorRedeDesabilitadaTextICon,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Container(
                                        height: 40,
                                        width: 40,
                                        //padding: const EdgeInsets.all(8),
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          gradient: LinearGradient(begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: <Color>[
                                                rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorEspecialPrimario1 : AppColors.colorRedeDesabilitadaTextICon,
                                                rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorEspecialPrimario2 : AppColors.colorRedeDesabilitadaTextICon,
                                              ]),
                                        ),
                                        child: GestureDetector(
                                          child: new Center(
                                            child:new Container(
                                              decoration: new BoxDecoration(
                                                //color: Colors.black,
                                                shape: BoxShape.circle
                                              ),
                                              child:  new FaIcon(FontAwesomeIcons.server,color:  AppColors.colorIconCardRede,size: 17,)
                                            )
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => JogosView(
                                                      redeModel: rede,
                                                      donoRede: false),
                                                ));
                                          },
                                        ),
                                      ),
                                      new Container(
                                        height: 40,
                                        width: 40,
                                        //padding: const EdgeInsets.all(8),
                                        margin: const EdgeInsets.only(left: 6),
                                        decoration: new BoxDecoration(
                                            gradient: LinearGradient(begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: <Color>[
                                                  rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorEspecialPrimario1 : AppColors.colorRedeDesabilitadaTextICon,
                                                  rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorEspecialPrimario2 : AppColors.colorRedeDesabilitadaTextICon,
                                                ]),
                                            shape: BoxShape.circle),
                                        child: GestureDetector(
                                          child: new Center(child: FaIcon(FontAwesomeIcons.userFriends,color:  AppColors.colorIconCardRede,size: 17,),),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        IntegrantesView(
                                                            redeModel: rede,
                                                            donoRede: false)));
                                          },
                                        ),
                                      ),
                                      new Container(
                                        height: 40,
                                        width: 40,
                                        //padding: const EdgeInsets.all(8),
                                        margin: const EdgeInsets.only(left: 6),
                                        decoration: new BoxDecoration(
                                            gradient: LinearGradient(begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: <Color>[
                                                  rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorEspecialPrimario1 : AppColors.colorRedeDesabilitadaTextICon,
                                                  rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorEspecialPrimario2 : AppColors.colorRedeDesabilitadaTextICon,
                                                ]),
                                            shape: BoxShape.circle),
                                        child: GestureDetector(
                                          child: new Center(
                                            child: new FaIcon(FontAwesomeIcons.listOl,color:  AppColors.colorIconCardRede,size: 17,),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RankingView(
                                                          rede.id,
                                                          rede.nome,
                                                          rede.status,
                                                          0,rede.cidade),
                                                ));
                                          },
                                        ),
                                      )
                                    ]),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JogosView(
                                          redeModel: rede, donoRede: false),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Apresentacao().getApresentacao(1,context);
              /*
              return GestureDetector(
                child: Apresentacao().getApresentacao(1),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => HomeView(),
                  ));
                },
              );
              */
            }
            break;
        }
        return Container();
      },
    );
  }


  _retorneSubtitulo(String pais, String cidade,String local) {
    if(pais ==""){
      pais = null;
    }
    if(cidade ==""){
      cidade = null;
    }
    if(local ==""){
      local = null;
    }
    if (pais == null && cidade == null && local == null) {
      return "";
    }
    else if(pais != null && cidade == null && local == null){
      String value = pais;
      return value;
    }
    else if(pais != null && cidade != null && local == null){
      String value = "${pais == 'Brasil'?'':'$pais - '}${pais == 'Brasil'?'$cidade':''}";
      return value;
    }
    else if(pais != null && cidade != null && local != null){
      String value = "${pais == 'Brasil'?'':'$pais - '}${pais == 'Brasil'?'$cidade -':''} $local";
      return value;
    }
    else if(pais == null && cidade == null && local != null){
      String value = local;
      return value;
    }
    else if(pais == null && cidade != null && local != null){
      String value = "$cidade - $local";
      return value;
    }
    else if(pais != null && cidade == null && local != null){
      String value = "${pais == 'Brasil'?'':'$pais - '} $local";
      return value;
    }
  }
}
