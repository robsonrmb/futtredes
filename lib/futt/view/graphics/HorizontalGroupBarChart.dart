import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart';

class HorizontalGroupBarChart extends StatelessWidget {

  List<charts.Series> seriesList;
  bool animate;

  HorizontalGroupBarChart(this.seriesList, this.animate);

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList as List<Series<dynamic, String>>,
      animate: animate,
      animationDuration: Duration(milliseconds: 700),
      vertical: false,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [new charts.SeriesLegend()],
    );
  }
}



