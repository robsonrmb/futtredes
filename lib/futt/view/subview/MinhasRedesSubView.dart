import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/service/RedeService.dart';
import 'package:futt/futt/view/JogosView.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/ParticipantesView.dart';
import 'package:futt/futt/view/RankingView.dart';

class MinhasRedesSubView extends StatefulWidget {
  @override
  _MinhasRedesSubViewState createState() => _MinhasRedesSubViewState();
}

class _MinhasRedesSubViewState extends State<MinhasRedesSubView> {

  Future<List<RedeModel>> _listaMinhasRedes() async {
    RedeService redeService = RedeService();
    return redeService.listaMinhasRedes(ConstantesConfig.SERVICO_FIXO);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RedeModel>>(
      future: _listaMinhasRedes(),
      builder: (context, snapshot) {
        switch( snapshot.connectionState ) {
          case ConnectionState.none :
          case ConnectionState.waiting :
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active :
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
                          color: Colors.grey[300],
                          image: DecorationImage(
                              image: NetworkImage(ConstantesRest.URL_BASE_AMAZON + rede.nomeFoto),
                              fit: BoxFit.fill
                          ),
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
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(Icons.people,
                                        //color: Colors.black,
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ParticipantesView(idRede: rede.id,
                                              nomeRede: rede.nome,
                                              paisRede: rede.pais,
                                              cidadeRede: rede.cidade,
                                              localRede: rede.local,
                                              donoRede: true)
                                      ));
                                    },
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(Icons.edit,
                                        //color: Colors.black,
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => RankingView(2007, 1),
                                      ));
                                    },
                                  ),
                                ]
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => JogosView(idRede: rede.id,
                                  nomeRede: rede.nome,
                                  paisRede: rede.pais,
                                  cidadeRede: rede.cidade,
                                  localRede: rede.local,
                                  donoRede: true),
                            ));
                          },
                        ),
                      ),
                      Container(
                        height: 15,
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