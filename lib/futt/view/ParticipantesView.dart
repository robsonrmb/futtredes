import 'package:futt/futt/view/subview/ParticipantesTorneioSubView.dart';
import 'package:flutter/material.dart';

class ParticipantesView extends StatefulWidget {

  int idTorneio;
  String nomeTorneio;
  String paisTorneio;
  String cidadeTorneio;
  String dataTorneio;
  int statusTorneio;
  ParticipantesView({this.idTorneio, this.nomeTorneio, this.paisTorneio, this.cidadeTorneio, this.dataTorneio, this.statusTorneio});

  @override
  _ParticipantesViewState createState() => _ParticipantesViewState();
}

class _ParticipantesViewState extends State<ParticipantesView> {

  String _mensagem = "";
  int _idTorneio;
  TextEditingController _controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _idTorneio = widget.idTorneio;

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
        title: Text("Participantes"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
            child: Text("${widget.nomeTorneio}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Candal'
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Image.asset("images/torneios.png", height: 46, width: 46,),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                        padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: Text("${widget.dataTorneio}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _mensagem == "" ? new Padding(
            padding: EdgeInsets.fromLTRB(0, 2, 10, 0),
          ) : new Padding(
            padding: EdgeInsets.fromLTRB(0, 2, 10, 0),
            child: Center(
              child: Text("${_mensagem}",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ParticipantesTorneioSubView(_idTorneio),
          )
        ],
      ),
    );
  }
}
