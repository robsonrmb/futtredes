import 'package:futt/futt/view/subview/MinhasRedesSubView.dart';
import 'package:flutter/material.dart';

class MinhasRedesView extends StatefulWidget {
  @override
  _MinhasRedesViewState createState() => _MinhasRedesViewState();
}

class _MinhasRedesViewState extends State<MinhasRedesView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: MinhasRedesSubView(),
            )
          ],
        ),
      ),
    );
  }
}
