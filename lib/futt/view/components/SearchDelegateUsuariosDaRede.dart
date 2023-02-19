import 'package:flutter/material.dart';

class SearchDelegateUsuariosDaRede extends SearchDelegate<String> {

  List<String> integrantes;
  SearchDelegateUsuariosDaRede(this.integrantes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, "");
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> lf = [];
    lf = integrantes.where(
            (texto) => texto.toLowerCase().startsWith( query.toLowerCase() )
    ).toList();

    return ListView.builder(
        itemCount: lf.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              close(context, lf[index]);
            },
            title: Text( lf[index]),
          );
        }
    );
  }

}