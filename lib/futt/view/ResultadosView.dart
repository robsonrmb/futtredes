import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/ResultadoModel.dart';
import 'package:futt/futt/service/ResultadoService.dart';
import 'package:futt/futt/view/subview/ResultadoTorneioSubView.dart';
import 'package:flutter/material.dart';

class ResultadosView extends StatefulWidget {

  int idTorneio;
  String nomeTorneio;
  String paisTorneio;
  String cidadeTorneio;
  String dataTorneio;
  ResultadosView({this.idTorneio, this.nomeTorneio, this.paisTorneio, this.cidadeTorneio, this.dataTorneio});

  @override
  _ResultadosViewState createState() => _ResultadosViewState();
}

class _ResultadosViewState extends State<ResultadosView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff093352),
          textTheme: TextTheme(
              title: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              )
          ),
          title: Text("Resultado"),
        ),
        body: new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Image.asset("images/torneios.png", height: 46, width: 46,),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("${widget.nomeTorneio}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Candal'
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("${widget.paisTorneio} - ${widget.cidadeTorneio}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("${widget.dataTorneio}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: ResultadoTorneioSubView(widget.idTorneio),
            )
          ],
        ),
    );
  }
}
