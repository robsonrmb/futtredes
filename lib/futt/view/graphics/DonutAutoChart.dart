import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:futt/futt/view/style/colors.dart';

class DonutAutoChart extends StatelessWidget {
  List<charts.Series> seriesList;
  bool animate;

  DonutAutoChart(this.seriesList, this.animate);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
        seriesList,
        animate: animate,
        vertical: true,

        /*
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()])
        */
        /*
        behaviors: [
          new charts.DatumLegend(
          position: charts.BehaviorPosition.end,
          outsideJustification: charts.OutsideJustification.endDrawArea,
          horizontalFirst: false,
          desiredMaxRows: 2,
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          entryTextStyle: charts.TextStyleSpec(
            color: charts.MaterialPalette.purple.shadeDefault,
            fontFamily: 'Georgia',
            fontSize: 11),
          )
        ]
        */

        barRendererDecorator: new charts.BarLabelDecorator<String>(),
        // Hide domain axis.
        domainAxis: new charts.OrdinalAxisSpec(
            renderSpec: new charts.NoneRenderSpec())
    );
    return new ShaderMask(
      child: charts.BarChart(
          seriesList,
          animate: animate,
          vertical: true,

          /*
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()])
        */
          /*
        behaviors: [
          new charts.DatumLegend(
          position: charts.BehaviorPosition.end,
          outsideJustification: charts.OutsideJustification.endDrawArea,
          horizontalFirst: false,
          desiredMaxRows: 2,
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          entryTextStyle: charts.TextStyleSpec(
            color: charts.MaterialPalette.purple.shadeDefault,
            fontFamily: 'Georgia',
            fontSize: 11),
          )
        ]
        */

          barRendererDecorator: new charts.BarLabelDecorator<String>(),
          // Hide domain axis.
          domainAxis: new charts.OrdinalAxisSpec(
              renderSpec: new charts.NoneRenderSpec())
      ),
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: <Color>[
            AppColors.colorEspecialPrimario1,
            AppColors.colorEspecialPrimario2],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
    );
  }
}
