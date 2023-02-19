import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/style/colors.dart';

class CollectionList extends StatefulWidget {
  final List<String>? lista;
  final String titulo;
  final String? ultimoValor;
  final color;
  final bool escondeSearch;
  int skip;
  int take;

  CollectionList(
      {this.lista,
        this.titulo: "",
        this.ultimoValor,
        this.color,
        this.skip: 0,
        this.take: 0,
        this.escondeSearch: false});

  @override
  State<StatefulWidget> createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  List<String>? _listaFiltro;
  ScrollController? scrollController;
  TextEditingController controllerBusca = new TextEditingController();

  @override
  void initState() {
    _listaFiltro = [];
    scrollController = new ScrollController();
    //scrollController.addListener(_scrollListener);
    _initList();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new CupertinoNavigationBar(
      //     backgroundColor: widget.color,
      //     leading: new GestureDetector(
      //       onTap: () => _selecionarItem(widget.ultimoValor),
      //       child: new Container(
      //         padding: EdgeInsets.only(right: 20.0),
      //         color: Colors.transparent,
      //         child: new Icon(
      //           Icons.arrow_back_ios,
      //           size: 20.0,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //     middle: new Container(
      //       child: new Text(
      //         widget.titulo.toUpperCase(),
      //         style: new TextStyle(color: Colors.white,fontFamily: 'Lato'),
      //       ),
      //     )),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          opacity: 1,
        ),
            leading: new GestureDetector(
              onTap: () => _selecionarItem(widget.ultimoValor),
              child: new Container(
                padding: EdgeInsets.only(right: 20.0,left: 16),
                color: Colors.transparent,
                child: new Icon(
                  Icons.arrow_back,
                  size: 24.0,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(widget.titulo,style: new TextStyle(fontWeight: FontWeight.bold, color: AppColors.colorTextAppNav,fontSize: 20),),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[AppColors.colorFundoClaroApp,AppColors.colorFundoEscuroApp])),
        ),
      ),
      body: new Column(
        children: <Widget>[_buildFiltro(), new Expanded(child: _buildLista())],
      ),
    );
  }

  Widget _buildFiltro() {
    if(!widget.escondeSearch){
      return new Material(
          elevation: 5,
          child: new Row(
            children: <Widget>[
              new Expanded(
                flex: 85,
                child: new Container(
                  margin: const EdgeInsets.only(bottom: 6, top: 6.0),
                  child: new Container(
                    height: 36,
                    margin: EdgeInsets.only(left: 16, right: 2),
                    decoration: BoxDecoration(
                        color: Color(0xfff0f0f0),
                        borderRadius: BorderRadius.all(Radius.circular(9.0))),
                    child: new Row(
                      children: <Widget>[
                        new Container(
                            padding: EdgeInsets.only(left: 8.0),
                            child: new Icon(
                              Icons.search,
                              color: Color(0xff999999),
                            )),
                        new Expanded(
                            child: new CupertinoTextField(
                              controller: controllerBusca,
                              placeholderStyle: new TextStyle(
                                  color: Color(0xff999999), fontSize: 17,fontFamily: 'Lato'),
                              placeholder: "Busca",
                              decoration:
                              new BoxDecoration(color: Colors.transparent),
                              onChanged: (text) {
                                text = text.toLowerCase();
                                setState(() {
                                  if (text.length > 0)
                                    _listaFiltro = widget.lista!
                                        .where((x) =>
                                        x.toLowerCase().contains(text))
                                        .toList();
                                  else
                                    _listaFiltro = widget.lista;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              new Expanded(
                  flex: 15,
                  child: new IconButton(
                      icon: new Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          controllerBusca.clear();
                          _listaFiltro = widget.lista;
                        });
                      }))
            ],
          ));
    }
    return new Container();
  }

  Widget _buildLista() {
    return ListView.builder(
      itemCount: _listaFiltro!.length,
      controller: scrollController,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var item = _listaFiltro![index];
        return new ListTile(
          onTap: () {
            _selecionarItem(item);
          },
          title: new Text(
            "${_listaFiltro![index]}",style: new TextStyle(fontFamily: 'Lato'),
          ),
        );
      },
    );
  }

  void _selecionarItem(String? item) {
    Navigator.of(context).pop(item);
  }

  Future<void> _initList() async{
    if (widget.take == 0) {
      setState(() {
        _listaFiltro = widget.lista;
      });
    } else {
      var listaSkipTake =
      widget.lista!.skip(widget.skip).take(widget.take).toList();

      if (listaSkipTake != null && listaSkipTake.length > 0) {
        setState(() {
          _listaFiltro!.addAll(listaSkipTake);
          widget.skip += widget.take;
        });
      }
    }
  }

  Future<void> _scrollListener() async {
    if (widget.take > 0) {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        var listaSkipTake =
        widget.lista!.skip(widget.skip).take(widget.take).toList();
        if (listaSkipTake != null && listaSkipTake.length > 0) {
          setState(() {
            _listaFiltro!.addAll(listaSkipTake);
            widget.skip += widget.take;
          });
        }
      }
    }
  }
}