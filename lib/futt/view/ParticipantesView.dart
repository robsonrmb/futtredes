import 'package:futt/futt/view/subview/ParticipantesSubView.dart';
import 'package:flutter/material.dart';

class ParticipantesView extends StatefulWidget {

  int idRede;
  String nomeRede;
  String paisRede;
  String cidadeRede;
  String localRede;
  bool donoRede;
  ParticipantesView({this.idRede, this.nomeRede, this.paisRede, this.cidadeRede, this.localRede, this.donoRede});

  @override
  _ParticipantesViewState createState() => _ParticipantesViewState();
}

class _ParticipantesViewState extends State<ParticipantesView> {

  int _inclui = 0;
  String _mensagem = "";
  TextEditingController _controllerEmail = TextEditingController();

  _adicionaParticipante() async {
    if (_controllerEmail.text == "") {
      setState(() {
        _mensagem = "Informe o email do atleta.";
      });
    }else{
      //enviar mensagem
      setState(() {
        _inclui = 2;
      });
      Navigator.pop(context);
    }
  }

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
        title: Text("Participantes"),
      ),
      floatingActionButton: widget.donoRede ? FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text("Adicione um atleta"),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Email",
                      ),
                      controller: _controllerEmail,
                    ),
                    new Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Text(_mensagem),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: RaisedButton(
                    color: Color(0xff086ba4),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Incluir",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Candal',
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  onPressed: () {
                    _adicionaParticipante();
                  },
                ),
              ],
            );
          });
        },
      ) : null,
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                /*image: DecorationImage(
                    image: NetworkImage('${ConstantesRest.URL_BASE_AMAZON}semImagem.png'),
                    fit: BoxFit.cover
                ),*/
                borderRadius: BorderRadius.circular(5),
                color: Colors.orangeAccent,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                    child: Text("${widget.nomeRede}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Candal'
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Text("${widget.paisRede} - ${widget.cidadeRede}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Text("${widget.localRede}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ParticipantesSubView(widget.idRede, widget.donoRede, _inclui),
            )
          ],
        ),
      ),
    );
  }
}
