import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/components/collection-list.dart';
import 'package:futt/futt/view/style/colors.dart';

class Collection extends StatefulWidget {
  final TextEditingController controller;
  final String titulo;
  final List<String> lista;
  final ValueChanged<String> onChange;
  final String valorPadrao;
  final Color colorStyle;
  final int skip;
  final int take;
  final bool solicitacaoAgendamento;
  final bool mesmoEstadoQueReside;
  final bool escondeSearch;

  Collection({
    Key key,
    @required this.titulo,
    @required this.lista,
    this.onChange,
    this.valorPadrao,
    this.solicitacaoAgendamento: false,
    this.mesmoEstadoQueReside:false,
    this.colorStyle: const Color(0xff2bbab4),
    this.skip: 0,
    this.take: 0,
    this.escondeSearch: false,
    this.controller
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CollectionState();
}

class CollectionState extends State<Collection> {
  String _itemSelecionado  = '';
  String _anterior = "Selecione";


  @override
  void initState() {
    if(widget.valorPadrao != null){
      _itemSelecionado = widget.valorPadrao;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width/1.2,
        height: 45,
        padding: EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              bottomLeft: Radius.circular(8),
              topLeft: Radius.circular(8),
              bottomRight: Radius.circular(40),

            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                // color: Colors.black12,
                  color: Colors.black12,
                  blurRadius: 5)
            ]),
        child:
        // SimpleAutoCompleteTextField(
        //   key: key,
        //   controller: controller,
        //   suggestions: integrantes,minLength: 0,
        //   clearOnSubmit: false,
        //   suggestionsAmount: integrantes.length,
        //   textSubmitted: (sugesstion) {
        //     //_view.encontrarIdEspecialidade(sugesstion);
        //   },
        //   decoration: new InputDecoration.collapsed(
        //       hintText: hint,
        //       hintStyle: new TextStyle(fontFamily: 'Lato')),
        //   textChanged: (text) => currentText = text,
        // ),
        new Row(
          children: [
            new Expanded(
              flex: 85,
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  //hintText: hint,
                ),
              ),
            ),
            new Expanded(
                flex: 15,
                child: new GestureDetector(
                  onTap: _irParaSelecaoDeItemHorizontal,
                  child: new Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: new BoxDecoration(
                          gradient: LinearGradient(begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                AppColors.colorEspecialPrimario1,
                                AppColors.colorEspecialPrimario2,
                              ]),
                          shape: BoxShape.circle
                      ),
                      child: new Center(
                        child: Icon(Icons.search,color: Colors.white,),
                      )
                  ),
                )
            ),
          ],
        ));
  }

  void buscarValorPadrao(List<String> lista) {
    if (lista != null && lista.length > 0) {
      if (widget.valorPadrao != null) {
        var vP =
            lista.where((lista) => lista == widget.valorPadrao).first;
        if (vP != null) {
          setState(() {
            _itemSelecionado = vP;
          });
        }
      }
    }
  }

  void setarvalor() {
    if (_itemSelecionado != null) {
      setState(() {
        _anterior = _itemSelecionado;
      });
    }
  }

  void _irParaSelecaoDeItemHorizontal() async {
    _itemSelecionado = await Navigator.push<String>(
        context,
        new PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return CollectionList(
              lista: widget.lista,
              titulo: widget.titulo,
              ultimoValor: _itemSelecionado,
              color: widget.colorStyle,
              skip: widget.skip,
              take: widget.take,
              escondeSearch: widget.escondeSearch,
            );
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: new SlideTransition(
                position: new Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(1.0, 0.0),
                ).animate(secondaryAnimation),
                child: child,
              ),
            );
          },
        ));
    if (widget.onChange != null) widget.onChange(_itemSelecionado);

    setState(() {});
  }
}