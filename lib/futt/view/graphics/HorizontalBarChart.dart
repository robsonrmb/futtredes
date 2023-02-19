import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart';

class HorizontalBarChart extends StatelessWidget {

  List<charts.Series> seriesList;
  bool animate;

  HorizontalBarChart(this.seriesList, this.animate);

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList as List<Series<dynamic, String>>,
      animate: animate,
      vertical: false,
    );
  }
}
