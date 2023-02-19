import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/EstadoModel.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/PaisesModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/model/UsuarioModel.dart';
import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/service/UsuarioService.dart';
import 'package:futt/futt/service/UtilService.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NovaRedeView extends StatefulWidget {

  UsuarioModel? userModel;
  bool? assinante;

  NovaRedeView({this.userModel,this.assinante:true});

  @override
  _NovaRedeViewState createState() => _NovaRedeViewState();
}

class _NovaRedeViewState extends State<NovaRedeView> {

  String? _mensagem = "";
  TextEditingController _controllerNome = TextEditingController();
  String _controllerPaisRede = "";
  TextEditingController _controllerCidade = TextEditingController();
  TextEditingController _controllerLocal = TextEditingController();
  TextEditingController _controllerQtdIntegrantes = TextEditingController();
  TextEditingController _controllerMais = TextEditingController();
  List<String?> listDropEstado = [];
  List<EstadosModel> estadosList = [];
  String? estadoSelecionado = '';
  String? paisSelecionado = '';
  List<String?> listDropPais = [];

  @override
  void initState() {
    super.initState();
    _buscaPais();
    _buscaEstado();
  }

  void _cadastraNovaRede(BuildContext context) async {
    try {
      _mensagem = "";
      if (_controllerNome.text == "") {
        _mensagem = "Informe o nome.";
      }else if (paisSelecionado == "") {
        _mensagem = "Informe o país.";
      }
      else if(paisSelecionado == "Brasil"){
        if(estadoSelecionado == ""){
          _mensagem = "Informe o estado.";
        }else{
      if (_controllerCidade.text == "") {
        _mensagem = "Informe a cidade.";
      }else if(_controllerLocal.text == null || _controllerLocal.text == ""){
        _mensagem = "Informe o local.";
      }
        }
      }else{
        if (_controllerCidade.text == "") {
          _mensagem = "Informe a cidade.";
        }else if(_controllerLocal.text == null || _controllerLocal.text == ""){
          _mensagem = "Informe o local.";
        }
      }


      /*else if (int.parse(_controllerQtdIntegrantes.text) <= 0 || int.parse(_controllerQtdIntegrantes.text) > 999) {
        _mensagem = "Qtd de integrantes incorreto.";
      }*/

      if (_mensagem != "") {
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Mensagem", "${_mensagem}");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);

        throw Exception(_mensagem);
      }
      String? enviaEstado = estadoSelecionado;
      if(paisSelecionado != 'Brasil'){
        estadoSelecionado = '';
      }else{
        for(int i = 0; i < estadosList.length; i++){
          if(estadoSelecionado == estadosList[i].texto){
            enviaEstado = estadosList[i].codigo;
          }
        }
        estadoSelecionado = enviaEstado;
      }

      RedeModel redeModel = RedeModel.Novo(
          _controllerNome.text, paisSelecionado,estadoSelecionado, _controllerCidade.text,
          _controllerLocal.text, int.parse('50'), _controllerMais.text
      );

      var _url = "${ConstantesRest.URL_REDE}/adiciona";
      var _dados = redeModel.toJson();

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN)!;

      http.Response response = await http.post(Uri.parse(_url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
          body: jsonEncode(_dados)
      );

      if (response.statusCode == 201) {
        _mensagem = "Rede inserida com sucesso!!!";

        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingSucess(context, "Nova rede", "${_mensagem}");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);
        Navigator.pop(context);

      }else{
        setState(() {
          var _dadosJson = jsonDecode(response.body);
          ExceptionModel exceptionModel = ExceptionModel.fromJson(_dadosJson);
          _mensagem = exceptionModel.msg;
        });
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingError(context, "Rede", "${_mensagem}");
        await Future.delayed(Duration(seconds: 10));
        Navigator.pop(context);
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

  Future<List<PaisModel>> _listaPaises() async {
    UtilService utilService = UtilService();
    return utilService.listaPaises();
  }

  @override
  Widget build(BuildContext context) {
    _controllerQtdIntegrantes.text = "Integrantes por rede: 50";
    return Scaffold(
        backgroundColor: Color(0xfff7f7f7),

        appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          opacity: 1,
        ),
        title: Text("Cadastro de redes",style: new TextStyle(fontWeight: FontWeight.bold, color: AppColors.colorTextAppNav, fontSize: 20
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
      body: Container(
       // color: Colors.grey[300],
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      rows('Nome','',_controllerNome),
                      new Container(
                        //color: Colors.red,
                        margin: const EdgeInsets.only(
                          top: 20,
                          left: 16,
                          bottom: 4,
                        ),
                        child: new Text(
                          'País',
                          style: TextStyle(
                              color: Color(0xff112841),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                      _buildDropPais(),
                      paisSelecionado == 'Brasil'?
                      new Container(
                        //color: Colors.red,
                        margin: const EdgeInsets.only(
                          top: 20,
                          left: 16,
                          bottom: 4,
                        ),
                        child: new Text(
                          'Estado',
                          style: TextStyle(
                              color: Color(0xff112841),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ):new Container(),
                      _buildDropEstado(),
                      rows('Cidade ', '',
                          _controllerCidade),
                      rows('Local ', '',
                          _controllerLocal),
                      rowsQtInte('Limite de integrantes', '20',
                          _controllerQtdIntegrantes),
                      new Container(
                        //color: Colors.red,
                        margin: const EdgeInsets.only(
                          top: 20,
                          left: 16,
                          bottom: 4,
                        ),
                        child: new Text(
                          'Observação',
                          style: TextStyle(
                              color: Color(0xff112841),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                      Container(
                        margin:
                        const EdgeInsets.only(right: 16, left: 16),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              width: 1.0,
                              color: Colors.grey[400]!,
                            )),
                        child: TextField(
                          maxLines: 10,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration.collapsed(
                            hintText:
                            "Acrescente alguma observação(opcional)",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                          style: TextStyle(
                              fontSize: 16, color: Colors.black),
                          controller: _controllerMais,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child:
        new Container(
          margin: const EdgeInsets.only(bottom: 16,right: 16,left: 16),
          height: 50,
          child: !widget.assinante! && widget.userModel!.qtdRedePromocional! > 0?
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.withOpacity(0.3),
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            child: Text(
              "SOMENTE ASSINANTES",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: FontFamily.fontSpecial,
              ),
            ),

            onPressed: () {},
          ):
          ElevatedButton(
            onPressed:(){
              _cadastraNovaRede(context);
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.withOpacity(0.3),
              padding: const EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
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
                child: const Text(
                  "Cadastrar",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        )
      )
    );
  }

  Widget rows(String title, String hint, TextEditingController controller) {
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
                    height: 40,
                    padding:
                    EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.black12,
                              color: Colors.black12,
                              blurRadius: 5)
                        ]),
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
  Widget rowsQtInte(
      String title, String hint, TextEditingController controller) {
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
                    height: 40,
                    padding:
                    EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: Color(0xB3FFFFFF),
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.black12,
                              color: Colors.black12,
                              blurRadius: 5)
                        ]),
                    child: TextField(
                      controller: controller,
                      enabled: false,
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

  Widget _buildDropPais(){
    return new Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.all(Radius.circular(4)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              // color: Colors.black12,
                color: Colors.black12,
                blurRadius: 5)
          ]),
      margin:
      const EdgeInsets.only(right: 16, left: 16),
      child: new Container(
        padding: const EdgeInsets.only(left: 16),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(
              "Selecione o País",
              style: new TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            value: paisSelecionado,
            style: new TextStyle(
                color: Colors.black,
                fontSize: 14),
            dropdownColor: Colors.white,
            //, Color(0xff112841),
            onChanged: (newValue) {
              setState(() {
                paisSelecionado = newValue;
                estadoSelecionado = "";
                //controllerNomeCartaoContaBancaria.text = newValue;
              });
            },
            items: listDropPais.map((String? value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value!),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDropEstado(){
    if(paisSelecionado == 'Brasil'){
      return new Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.all(Radius.circular(4)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                // color: Colors.black12,
                  color: Colors.black12,
                  blurRadius: 5)
            ]),
        margin:
        const EdgeInsets.only(right: 16, left: 16),
        child: new Container(
          padding: const EdgeInsets.only(left: 16),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(
                "Selecione o Estado",
                style: new TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
              value: estadoSelecionado,
              style: new TextStyle(
                  color: Colors.black,
                  fontSize: 14),
              dropdownColor: Colors.white,
              //, Color(0xff112841),
              onChanged: (newValue) {
                setState(() {
                  estadoSelecionado = newValue;
                  //controllerNomeCartaoContaBancaria.text = newValue;
                });
              },
              items: listDropEstado.map((String? value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value!),
                );
              }).toList(),
            ),
          ),
        ),
      );
    }
    return new Container();
  }

  void _buscaEstado() async {
    listDropEstado.add('');
    UsuarioService usuarioService = UsuarioService();
    List<EstadosModel>? estados = await usuarioService.listaEstados();
    if (estados != null) {
      estadosList = estados;
      for (int i = 0; i < estados.length; i++) {
        listDropEstado.add(estados[i].texto);
      }
    }
    setState(() {});
  }


  void _buscaPais() async {
    listDropPais.add('');
    UsuarioService usuarioService = UsuarioService();
    List<PaisesModel>? paises = await usuarioService.listaPaises();
    if (paises != null) {
      for (int i = 0; i < paises.length; i++) {
        listDropPais.add(paises[i].texto);
      }
    }
  }

}
