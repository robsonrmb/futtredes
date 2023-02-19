import 'package:futt/futt/model/EscolinhaModel.dart';
import 'package:futt/futt/service/EscolinhaService.dart';
import 'package:flutter/material.dart';

class EscolinhaSubView extends StatefulWidget {

  String? pais;
  String cidade;
  String paisDefault;
  String cidadeDefault;
  EscolinhaSubView(this.pais, this.cidade, this.paisDefault, this.cidadeDefault);

  @override
  _EscolinhaSubViewState createState() => _EscolinhaSubViewState();
}

class _EscolinhaSubViewState extends State<EscolinhaSubView> {

  Future<List<EscolinhaModel>> _listaEscolinha() async {
    if (widget.pais == "" && widget.cidade == "") {
      EscolinhaService escolinhaService = EscolinhaService();
      return escolinhaService.listaEscolinhas(
          widget.paisDefault, widget.cidadeDefault);
    }else{
      EscolinhaService escolinhaService = EscolinhaService();
      return escolinhaService.listaEscolinhas(
          widget.pais, widget.cidade);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EscolinhaModel>>(
      future: _listaEscolinha(),
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
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {

                  List<EscolinhaModel> escolinha = snapshot.data!;
                  EscolinhaModel resultado = escolinha[index];

                  return Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: GestureDetector(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage('${resultado.fotoResponsavel}'),
                          radius: 30.0,
                        ),
                        title: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                " ${resultado.nomeResponsavel}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                " ${resultado.nomeProfessor1}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "  ${resultado.telefone}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      ),
                      onTap: () {
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            titleTextStyle: TextStyle(
                              color: Color(0xff086ba4),
                              fontSize: 20,
                              fontFamily: "Candal",
                            ),
                            title: Text("${resultado.nome}"),
                            content: SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    width: 1.0
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text("${resultado.telefone}",
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    ),
                                    Text("País",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text("${resultado.pais}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                    ),
                                    Text("Cidade",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text("${resultado.cidade}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                    ),
                                    Text("Responsável",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text("${resultado.nomeResponsavel}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                    ),
                                    Text("Professor",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text("${resultado.nomeProfessor1}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("${resultado.nomeProfessor2}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("${resultado.nomeProfessor3}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(

                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                  backgroundColor: Color(0xff086ba4),
                                  padding: EdgeInsets.all(15),
                                ),
                                child: Text(
                                  "Fechar",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: 'Candal',
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                      },
                    ),
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
