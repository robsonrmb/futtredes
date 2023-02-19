import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/BannerModel.dart';
import 'package:futt/futt/service/BannerService.dart';
import 'package:futt/futt/view/subview/MinhasRedesSubView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MinhasRedesView extends StatefulWidget {
  @override
  _MinhasRedesViewState createState() => _MinhasRedesViewState();
}

Future<BannerModel> _buscaPermissaoBanners() async {
  BannerService bannerService = BannerService();
  BannerModel banner = await bannerService.buscaPermissaoBanners();
  return banner;
}

_clickBanner(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _MinhasRedesViewState extends State<MinhasRedesView> {
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
                  body: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: MinhasRedesSubView(),
                        ),
                        GestureDetector(
                          onTap: () => _clickBanner(snapshot.data!.linkMinhasRedes!),
                          child: Visibility(
                            visible: snapshot.data!.showMinhasRedes!,
                            maintainSize: false,
                            maintainAnimation: true,
                            maintainState: true,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[300]!.withOpacity(0.5),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        ConstantesRest.URL_STATIC_BANNERS +
                                            "bannerMinhasRedes.png"),
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
                        ),
                      ],
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
