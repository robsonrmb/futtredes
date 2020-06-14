import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/view/subview/JogosSubView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JogosView extends StatefulWidget {

  RedeModel redeModel;
  bool donoRede;
  JogosView({this.redeModel, this.donoRede});

  @override
  _JogosViewState createState() => _JogosViewState();
}

class _JogosViewState extends State<JogosView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          opacity: 1,
        ),
        backgroundColor: Color(0xff093352),
        textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white,
                fontSize: 20
            )
        ),
        title: Text("Jogos"),
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
                color: Colors.grey[400],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                    child: Text("${widget.redeModel.nome}",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Candal',
                          color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Color(0xff093352): Color(0xff1D691D) : Colors.grey[800]
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Text("${widget.redeModel.pais} - ${widget.redeModel.cidade}",
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Color(0xff093352): Color(0xff1D691D) : Colors.grey[800]
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Text("${widget.redeModel.local}",
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Color(0xff093352): Color(0xff1D691D) : Colors.grey[800]
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: JogosSubView(widget.redeModel, widget.donoRede),
            )
          ],
        ),
      ),
    );
  }
}
