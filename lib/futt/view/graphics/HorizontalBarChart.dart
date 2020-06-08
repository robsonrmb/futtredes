import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class HorizontalBarChart extends StatelessWidget {

  List<charts.Series> seriesList;
  bool animate;

  HorizontalBarChart(this.seriesList, this.animate);

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
    );
  }
}
