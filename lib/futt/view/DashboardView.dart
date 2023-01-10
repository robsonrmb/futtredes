import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/BannerModel.dart';
import 'package:futt/futt/model/UsuarioModel.dart';
import 'package:futt/futt/service/BannerService.dart';
import 'package:futt/futt/service/UsuarioService.dart';
import 'package:futt/futt/view/EstatisticasView.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  String apelido;
  String nome;
  String nomeFoto;
  String pais;
  String user;
  String estado;
  String localOndeJoga;
  String posicao;
  int idUser;

  DashboardView(
      {this.nome, this.nomeFoto, this.pais, this.apelido, this.user,this.estado,this.localOndeJoga,this.posicao,this.idUser});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    //_buscaUsuarioLogado();
  }

  Future<BannerModel> _buscaPermissaoBanners() async {
    BannerService bannerService = BannerService();
    BannerModel banner = await bannerService.buscaPermissaoBanners();
    return banner;
  }

  Future<UsuarioModel> _buscaUsuarioLogado() async {
    UsuarioService usuarioService = UsuarioService();
    Future<UsuarioModel> usuario =
        usuarioService.buscaLogado(ConstantesConfig.SERVICO_FIXO);
    return usuario;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BannerModel>(
        future: _buscaPermissaoBanners(),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none :
            case ConnectionState.active :
            case ConnectionState.waiting :
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done :
              if (snapshot.hasData) {
                return new Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: EstatisticasView(
                                widget.idUser,
                                0,
                                null,
                                widget.nome,
                                widget.nomeFoto,
                                pais: widget.pais,
                                apelido: widget.apelido,
                                user: widget.user,
                                estado: widget.estado,
                                localOndeJoga: widget.localOndeJoga,
                                posicao: widget.posicao,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: snapshot.data.showDashboard,
                            maintainSize: false,
                            maintainAnimation: true,
                            maintainState: true,
                            child: Container(
                              height: 60,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey[300].withOpacity(0.5),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        ConstantesRest.URL_STATIC_BANNERS +
                                            "bannerDashboard.png"),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                  bottomLeft: Radius.circular(4.0),
                                  bottomRight: Radius.circular(4.0),
                                ), //borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
          }
        }
    );
  }
}
