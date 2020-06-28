import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/UsuarioModel.dart';
import 'package:futt/futt/service/UsuarioService.dart';
import 'package:futt/futt/view/EstatisticasView.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  @override
  void initState() {
    _buscaUsuarioLogado();
  }

  Future<UsuarioModel> _buscaUsuarioLogado() async {
    UsuarioService usuarioService = UsuarioService();
    Future<UsuarioModel> usuario = usuarioService.buscaLogado(ConstantesConfig.SERVICO_FIXO);
    return usuario;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<UsuarioModel>(
                future: _buscaUsuarioLogado(),
                builder: (context, snapshot) {
                  switch( snapshot.connectionState ) {
                    case ConnectionState.none :
                    case ConnectionState.waiting :
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.active :
                    case ConnectionState.done :
                      if( snapshot.hasData ) {

                        UsuarioModel usuario = snapshot.data;

                        return Container(
                          child: EstatisticasView(0, 0, usuario.nome, usuario.nomeFoto),
                        );
                      }else{
                        return Container();
                      }
                      break;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
