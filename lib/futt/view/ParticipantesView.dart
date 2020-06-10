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
              child: ParticipantesSubView(widget.idRede),
            )
          ],
        ),
      ),
    );
  }
}
