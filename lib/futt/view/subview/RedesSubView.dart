import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/service/RedeService.dart';
import 'package:futt/futt/view/JogosView.dart';
import 'package:futt/futt/view/IntegrantesView.dart';
import 'package:futt/futt/view/RankingRedeView.dart';

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
        switch( snapshot.connectionState ) {
          case ConnectionState.none :
            return Center(
              child: Text("None!!!"),
            );
          case ConnectionState.waiting :
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active :
            return Center(
              child: Text("Active!!!"),
            );
          case ConnectionState.done :
            if( snapshot.hasData ) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {

                  List<RedeModel> redes = snapshot.data;
                  RedeModel rede = redes[index];

                  return Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300].withOpacity(0.5),
                          image: DecorationImage(
                              image: NetworkImage(ConstantesRest.URL_BASE_AMAZON + rede.nomeFoto),
                              fit: BoxFit.fill
                          ),
                          //borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey[300],
                          )
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          //borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          child:
                          ListTile(
                            title: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    "${rede.nome}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              "${rede.pais} - ${rede.cidade} - ${rede.local}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 1),
                                      child: Icon(Icons.play_circle_outline,
                                          color: rede.status < 3 ? (rede.status == 1) ? Color(0xff093352): Colors.lightBlue : Colors.grey
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => JogosView(redeModel: rede, donoRede: false),
                                      ));
                                    },
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Icon(Icons.people,
                                          color: Colors.lightBlue,
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => IntegrantesView(redeModel: rede, donoRede: false)
                                      ));
                                    },
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Icon(Icons.star_half,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => RankingRedeView(rede.id, rede.nome, rede.status, 0),
                                      ));
                                    },
                                  ),
                                ]
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => JogosView(redeModel: rede,donoRede: false),
                            ));
                          },
                        ),
                      ),
                      Container(
                        height: 5,
                        color: Colors.white,
                      ),
                    ],
                  );
                },
              );
            }else{
              return Center(
                child: Text("Sem valores!!!"),
              );
            }
            break;
        }
      },
    );
  }
}
