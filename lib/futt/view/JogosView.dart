import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/view/NovoJogoView.dart';
import 'package:futt/futt/view/components/TopoInterno.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/subview/JogosSubView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JogosView extends StatefulWidget {

  RedeModel? redeModel;
  bool? donoRede;
  JogosView({this.redeModel, this.donoRede});

  @override
  _JogosViewState createState() => _JogosViewState();
}

class _JogosViewState extends State<JogosView> {

  bool? _meusJogos = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          opacity: 1,
        ),
        title: Text("Jogos",style: new TextStyle(fontWeight: FontWeight.bold,color: AppColors.colorTextAppNav,fontSize: 20
        ),),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[AppColors.colorFundoClaroApp,AppColors.colorFundoEscuroApp])),
        ),
      ),
      floatingActionButton: widget.donoRede! && (widget.redeModel!.status == 1 || widget.redeModel!.status == 2) ? FloatingActionButton(
        child: Icon(Icons.add,color: AppColors.colorIconFloatButton),
        backgroundColor: AppColors.colorFloatButton,

        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => NovoJogoView(widget.redeModel),
          ));
        },
      ) : null,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //CabecalhoLista().cabecalho(widget.redeModel.nome, widget.redeModel.pais, widget.redeModel.cidade, widget.redeModel.local, widget.redeModel.status),
            TopoInterno().getTopo(widget.redeModel!.nome!, widget.redeModel!.status!),
            Expanded(
              child: JogosSubView(widget.redeModel, widget.donoRede, _meusJogos),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            color: Colors.grey[100],
            child: CheckboxListTile(
              title:
                Text("Exibir somente meus jogos.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              //subtitle: Text("Exibição dos últimos 50 jogos."),
              activeColor: Colors.lightBlue,
              value: _meusJogos,
              onChanged: (bool? valor) {
                setState(() {
                  _meusJogos = valor;
                });
              },
            ),
          ),
        )
    );
  }
}
