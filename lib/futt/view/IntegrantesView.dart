import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/IntegranteModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:futt/futt/view/components/TopoInterno.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';
import 'package:futt/futt/view/subview/IntegrantesSubView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IntegrantesView extends StatefulWidget {

  RedeModel redeModel;
  bool donoRede;
  IntegrantesView({this.redeModel, this.donoRede});

  @override
  _IntegrantesViewState createState() => _IntegrantesViewState();
}

class _IntegrantesViewState extends State<IntegrantesView> {

  int _inclui = 0;
  String _mensagem = "";
  TextEditingController _controllerEmail = TextEditingController();

  _adicionaIntegrante() async {
    try {
      if (_controllerEmail.text == "") {
        setState(() {
          _mensagem = "Informe o email ou username do atleta.";
        });
      }else{
        circularProgress(context);
        IntegranteModel integranteModel = IntegranteModel.Novo(widget.redeModel.id, _controllerEmail.text);

        var _url = "${ConstantesRest.URL_REDE}/adicionaintegrante";
        var _dados = integranteModel.toJson();

        final prefs = await SharedPreferences.getInstance();
        String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

        http.Response response = await http.post(_url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': token,
            },
            body: jsonEncode(_dados)
        );

        Navigator.pop(context);
        if (response.statusCode == 201) {
          DialogFutt dialogFutt = new DialogFutt();
          dialogFutt.waitingSucess(context, "Inclusão de atleta", "Atleta inserido com sucesso!!!");
          await Future.delayed(Duration(seconds: 3));
          Navigator.pop(context);
          Navigator.pop(context);
          setState(() {
            _inclui = 0;
          });

        }else{
          String source = Utf8Decoder().convert(response.bodyBytes);
          var _dadosJson = json.decode(source);
          ExceptionModel exceptionModel = ExceptionModel.fromJson(_dadosJson);
          DialogFutt dialogFutt = new DialogFutt();
          dialogFutt.waitingError(context, "Erro", exceptionModel.msg);
          await Future.delayed(Duration(seconds: 4));
          Navigator.pop(context);
        }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white,
                fontSize: 20
            )
        ),
        centerTitle: true,
        title: Text("Integrantes",style: new TextStyle(fontWeight: FontWeight.bold,color: AppColors.colorTextAppNav,
        ),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[AppColors.colorFundoClaroApp,AppColors.colorFundoEscuroApp])),
        ),
      ),
      floatingActionButton: widget.donoRede && (widget.redeModel.status == 1 || widget.redeModel.status == 2) ? FloatingActionButton(
        child: Icon(Icons.add,color: AppColors.colorIconFloatButton,),
        backgroundColor: AppColors.colorFloatButton,
        onPressed: () {
          _mensagem = "";
          _controllerEmail.text = "";
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text("Adicione um atleta"),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    rows('Email/Usuário','Digite o email ou o usuário',_controllerEmail),
                    new Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Text(_mensagem,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                          fontFamily: FontFamily.fontSpecial,
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(right: 6),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: AppColors.colorButtonDialog,
                    onPressed: () {
                      _adicionaIntegrante();
                    },
                    child: Text('Incluir',style: new TextStyle(color: Colors.white),),
                  ),
                )
              ],
            );
          });
        },
      ) : null,
      body: new SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //CabecalhoLista().cabecalho(widget.redeModel.nome, widget.redeModel.pais, widget.redeModel.cidade, widget.redeModel.local, widget.redeModel.status),
            TopoInterno().getTopo(widget.redeModel.nome, widget.redeModel.status),
            IntegrantesSubView(widget.redeModel, widget.donoRede, _inclui),
          ],
        ),
      )
    );
  }

  Widget rows(String title, String hint, TextEditingController controller) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Expanded(
            child: new Container(
              margin: const EdgeInsets.only(top: 16),
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
                    height: 40,
                    padding:
                    EdgeInsets.only(left: 16, right: 16, bottom: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5)
                        ]),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: new TextStyle(fontSize: 14)
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
