import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/view/NovoJogoView.dart';
import 'package:futt/futt/view/components/CabecalhoLista.dart';
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
      floatingActionButton: widget.donoRede && (widget.redeModel.status == 1 || widget.redeModel.status == 2) ? FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => NovoJogoView(widget.redeModel),
          ));
        },
      ) : null,
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CabecalhoLista().cabecalho(widget.redeModel.nome, widget.redeModel.pais, widget.redeModel.cidade, widget.redeModel.local, widget.redeModel.status),
            Expanded(
              child: JogosSubView(widget.redeModel, widget.donoRede),
            )
          ],
        ),
      ),
    );
  }
}
