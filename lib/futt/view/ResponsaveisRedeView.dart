import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResponsaveisRedeView extends StatefulWidget {

  RedeModel redeModel;
  ResponsaveisRedeView({this.redeModel});

  @override
  _ResponsaveisRedeViewState createState() => _ResponsaveisRedeViewState();
}

class _ResponsaveisRedeViewState extends State<ResponsaveisRedeView> {

  String _mensagem = "";
  TextEditingController _controllerResponsavel = TextEditingController();
  TextEditingController _controllerSubResponsavel1 = TextEditingController();
  TextEditingController _controllerSubResponsavel2 = TextEditingController();
  TextEditingController _controllerSubResponsavel3 = TextEditingController();

  String _tituloSub1 = "Subresponsável da rede";
  String _tituloSub2 = "Subresponsável da rede";
  String _tituloSub3 = "Subresponsável da rede";

  _atualizaResponsaveis() async {
    circularProgress(context);

    try {
      _mensagem = "";
      // if (_controllerResponsavel.text == "") {
      //   throw Exception('Informe ao menos o responsável principal da rede.');
      // }
      //
      // if (_mensagem != "") {
      //   DialogFutt dialogFutt = new DialogFutt();
      //   dialogFutt.waiting(context, "Mensagem", "${_mensagem}");
      //   await Future.delayed(Duration(seconds: 2));
      //   Navigator.pop(context);
      //
      //   throw Exception(_mensagem);
      // }

      RedeModel redeModel = RedeModel.Responsaveis(
        widget.redeModel.id, _controllerResponsavel.text,
        _controllerSubResponsavel1.text, _controllerSubResponsavel2.text, _controllerSubResponsavel3.text,
      );

      var _url = "${ConstantesRest.URL_REDE}/atualizaresponsaveis";
      var _dados = redeModel.toJson();

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts/1";
        _dados = jsonEncode({ 'userId': 1, 'id': 1, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.put(_url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
          body: jsonEncode(_dados)
      );

      if (response.statusCode == 201) {
        setState(() {
          _mensagem = "Responsáveis da rede atualizada com sucesso!!!";
        });

        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingSucess(context, "Rede", "${_mensagem}");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);
        Navigator.pop(context);

      }else{
        String source = Utf8Decoder().convert(response.bodyBytes);
        var _dadosJson = json.decode(source);
        ExceptionModel exceptionModel = ExceptionModel.fromJson(_dadosJson);
        _mensagem = exceptionModel.msg;

        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingError(context, "Erro", exceptionModel.msg);
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);
        Navigator.pop(context);
        setState(() {});
      }

    } on Exception catch (exception) {
      print(exception.toString());
      setState(() {
        _mensagem = exception.toString();
      });
    } catch (error) {
      setState(() {
        _mensagem = error.toString();
      });
    }
  }

  _atualizaValoresIniciais(RedeModel redeOrigem) {
    _controllerResponsavel.text = redeOrigem.emailResponsavelRede;
    _controllerSubResponsavel1.text = redeOrigem.emailResponsavelJogos1;
    _controllerSubResponsavel2.text = redeOrigem.emailResponsavelJogos2;
    _controllerSubResponsavel3.text = redeOrigem.emailResponsavelJogos3;

    if (redeOrigem.responsavelJogos1 != 0) {
      _tituloSub1 = redeOrigem.nomeResponsavelJogos1;
    }
    if (redeOrigem.responsavelJogos2 != 0) {
      _tituloSub2 = redeOrigem.nomeResponsavelJogos2;
    }
    if (redeOrigem.responsavelJogos3 != 0) {
      _tituloSub3 = redeOrigem.nomeResponsavelJogos3;
    }
  }

  @override
  void initState() {
    super.initState();
    _atualizaValoresIniciais(widget.redeModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          opacity: 1,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[AppColors.colorFundoClaroApp,AppColors.colorFundoEscuroApp])),
        ),
        textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white,
                fontSize: 20
            )
        ),
        title: Text("Responsáveis da rede",style: new TextStyle(fontWeight: FontWeight.bold,color: AppColors.colorTextAppNav,
        ),),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xfff7f7f7),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // new Container(height: 20,),
              // new Stack(
              //   alignment: Alignment.center,
              //   children: [
              //     new Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: (){
              //           Navigator.pop(context);
              //         })
              //       ],
              //     ),
              //     new Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         new Container(
              //           margin: const EdgeInsets.only(bottom: 6),
              //           child: new Text('Responsáveis da rede',
              //             style: new TextStyle(
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.black,
              //                 fontFamily: 'Candal'),),
              //         )
              //       ],
              //     )
              //   ],
              // ),
              // new Container(height: 20,),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        // color: Colors.black12,
                          color: Colors.black.withOpacity(0.5),

                          blurRadius: 5
                      )
                    ]
                ),
                child: Column(
                  children: <Widget>[
                    new Container(
                      height: 5,
                      decoration: new BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(8),

                        ),
                        gradient:  LinearGradient(
                          colors: <Color>[AppColors.colorEspecialPrimario1, AppColors.colorEspecialPrimario2],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                      child: Text("Informe o email do responsável",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: FontFamily.fontSpecial,
                            color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Color(0xff093352): Color(0xFF0D47A1) : Colors.grey[800]
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: Text("Responsável: ${widget.redeModel.nomeResponsavelRede}",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Color(0xff093352): Color(0xFF0D47A1) : Colors.grey[800]
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                      child: Text("Indique até 3 subresponsáveis.",
                        style: TextStyle(
                            fontSize: 12,
                            color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Color(0xff093352): Color(0xFF0D47A1) : Colors.grey[800]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //rows('Responsável','Digite o responsável da rede',_controllerResponsavel),
              rows('Subresponsável','Digite o email ou usuário',_controllerSubResponsavel1),
              rows('Subresponsável','Digite o email ou usuário',_controllerSubResponsavel2),
              rows('Subresponsável','Digite o email ou usuário',_controllerSubResponsavel3),

              // Padding(
              //   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              //   child: TextField(
              //     keyboardType: TextInputType.text,
              //     decoration: InputDecoration(
              //       labelText: "Responsável da rede",
              //       labelStyle: TextStyle(
              //         color: Colors.grey[600],
              //       ),
              //       filled: true,
              //       fillColor: Colors.grey[300],
              //       border: OutlineInputBorder(
              //         gapPadding: 10,
              //       ),
              //     ),
              //     style: TextStyle(
              //         fontSize: 16,
              //         color: Colors.black
              //     ),
              //     controller: _controllerResponsavel,
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              //   child: TextField(
              //     keyboardType: TextInputType.text,
              //     decoration: InputDecoration(
              //       labelText: "${_tituloSub1}",
              //       labelStyle: TextStyle(
              //         color: Colors.grey[600],
              //       ),
              //       filled: true,
              //       fillColor: Colors.grey[300],
              //       border: OutlineInputBorder(
              //         gapPadding: 10,
              //       ),
              //     ),
              //     style: TextStyle(
              //         fontSize: 16,
              //         color: Colors.black
              //     ),
              //     controller: _controllerSubResponsavel1,
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              //   child: TextField(
              //     keyboardType: TextInputType.text,
              //     decoration: InputDecoration(
              //       labelText: "${_tituloSub2}",
              //       labelStyle: TextStyle(
              //         color: Colors.grey[600],
              //       ),
              //       filled: true,
              //       fillColor: Colors.grey[300],
              //       border: OutlineInputBorder(
              //         gapPadding: 10,
              //       ),
              //     ),
              //     style: TextStyle(
              //         fontSize: 16,
              //         color: Colors.black
              //     ),
              //     controller: _controllerSubResponsavel2,
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              //   child: TextField(
              //     keyboardType: TextInputType.text,
              //     decoration: InputDecoration(
              //       labelText: "${_tituloSub3}",
              //       labelStyle: TextStyle(
              //         color: Colors.grey[600],
              //       ),
              //       filled: true,
              //       fillColor: Colors.grey[300],
              //       border: OutlineInputBorder(
              //         gapPadding: 10,
              //       ),
              //     ),
              //     style: TextStyle(
              //         fontSize: 16,
              //         color: Colors.black
              //     ),
              //     controller: _controllerSubResponsavel3,
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        // color: Colors.black12,
                          color: Colors.black.withOpacity(0.5),

                          blurRadius: 5
                      )
                    ]
                ),
                child: Column(
                  children: <Widget>[
                    new Container(
                      height: 5,
                      decoration: new BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(8),

                        ),
                        gradient:  LinearGradient(
                          colors: <Color>[AppColors.colorEspecialPrimario1, AppColors.colorEspecialPrimario2],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text("Os subresponsáveis podem cadastrar:",
                        style: TextStyle(
                            fontSize: 12,
                            color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Color(0xff093352): Color(0xFF0D47A1): Colors.grey[800]
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                      child: Text("JOGOS, PLACARES, PARTICIPANTES, ENTRE OUTROS.",
                        style: TextStyle(
                            fontSize: 12,
                            color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Color(0xff093352): Color(0xFF0D47A1): Colors.grey[800]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Center(
                  child: Text(
                    _mensagem,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: FontFamily.fontSpecial,

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          height: 60,
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Color(0xfff7f7f7),
          child: widget.redeModel.status == 1 || widget.redeModel.status == 2 ?
          RaisedButton(
            onPressed: (){
                    _atualizaResponsaveis();
                  },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                gradient:  LinearGradient(
                  colors: <Color>[AppColors.colorEspecialSecundario1, AppColors.colorEspecialSecundario2],
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                alignment: Alignment.center,
                child: Text(
                  "Atualizar",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.colorTextLogCad,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          )

          // RaisedButton(
          //   color: Color(0xff086ba4),
          //   textColor: Colors.white,
          //   padding: EdgeInsets.all(15),
          //   child: Text(
          //     "Atualiza",
          //     style: TextStyle(
          //       fontSize: 16,
          //       fontFamily: 'Candal',
          //     ),
          //   ),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(2),
          //   ),
          //   onPressed: () {
          //     _atualizaResponsaveis();
          //   },
          // )
              :
          RaisedButton(
            color: Colors.grey.withOpacity(0.3),
            textColor: Colors.white,
            padding: EdgeInsets.all(15),
            child: Text(
              "REDE FECHADA OU DESATIVADA",
              style: TextStyle(
                fontSize: 16,
                fontFamily: FontFamily.fontSpecial,

              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            onPressed: () {},
          )
        ),
      ),
    );
  }

  Widget rows(String title,String hint, TextEditingController controller) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Expanded(
            child: new Container(
              //height: 60,
              //width: MediaQuery.of(context).size.width,

              margin: const EdgeInsets.only(top: 16, right: 14, left: 14),
             // padding: const EdgeInsets.only(left: 6),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    //color: Colors.red,
                    margin: const EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                    ),
                    child: new Text(
                      title,
                      style: TextStyle(
                          color: Color(0xff112841),
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                  Container(
                    //width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(8)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.black12,
                              color: Colors.black12,

                              blurRadius: 5
                          )
                        ]
                    ),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                      ),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }


  void circularProgress(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext bc) {
          return Center(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                )
              ],
            ),
          );
        });
  }

}
