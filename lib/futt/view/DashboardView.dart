import 'package:futt/futt/view/EstatisticasView.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: EstatisticasView(0, 0, "Robsonnn", "semFoto.jpg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
