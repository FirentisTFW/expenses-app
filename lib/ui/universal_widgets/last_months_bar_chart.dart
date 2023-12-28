import 'package:Expenses_app/datamodels/total_expenses.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';

class LastMonthsBarChart extends StatelessWidget {
  final bool animate;
  final List<charts.Series<TotalExpenses, String>> seriesList;

  LastMonthsBarChart({
    super.key,
    this.animate = true,
    required this.seriesList,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 350,
        padding: const EdgeInsets.all(20),
        child: charts.BarChart(
          seriesList,
          animate: animate,
          barRendererDecorator: charts.BarLabelDecorator<String>(),
          domainAxis: domainAxisSpec,
          primaryMeasureAxis: primaryMeasureAxisSpec,
        ),
      );

  factory LastMonthsBarChart.buildFromData({
    required List<TotalExpenses> initialData,
    bool animate = true,
  }) {
    return LastMonthsBarChart(
      seriesList: _tranformDataToSeriesList(initialData),
      animate: animate,
    );
  }

  factory LastMonthsBarChart.buildSampleData() {
    final sampleData = [
      TotalMonthlyExpenses(name: '8', totalMoneyAmount: 2154),
      TotalMonthlyExpenses(name: '9', totalMoneyAmount: 543),
      TotalMonthlyExpenses(name: '10', totalMoneyAmount: 2497),
      TotalMonthlyExpenses(name: '11', totalMoneyAmount: 1023),
    ];

    return LastMonthsBarChart(
      seriesList: _tranformDataToSeriesList(sampleData),
      animate: true,
    );
  }

  static List<charts.Series<TotalExpenses, String>> _tranformDataToSeriesList(
    List<TotalExpenses> initialData,
  ) {
    return [
      charts.Series(
        id: 'Expenses',
        data: initialData,
        domainFn: (expenses, _) => expenses.name,
        measureFn: (expenses, _) => expenses.totalMoneyAmount,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        labelAccessorFn: (expenses, _) =>
            expenses.totalMoneyAmount.round().toString(),
        insideLabelStyleAccessorFn: (_, __) => charts.TextStyleSpec(
          fontSize: 14,
          color: charts.MaterialPalette.white,
          lineHeight: 4.0,
        ),
        outsideLabelStyleAccessorFn: (_, __) => charts.TextStyleSpec(
          fontSize: 14,
          color: charts.MaterialPalette.gray.shade100,
        ),
      ),
    ];
  }

  // STYLING

  final domainAxisSpec = charts.OrdinalAxisSpec(
    renderSpec: charts.SmallTickRendererSpec(
      labelStyle: charts.TextStyleSpec(
        fontSize: 16,
        color: charts.MaterialPalette.gray.shade400,
      ),
      lineStyle:
          charts.LineStyleSpec(color: charts.MaterialPalette.gray.shade400),
    ),
  );

  final primaryMeasureAxisSpec = charts.NumericAxisSpec(
    renderSpec: charts.GridlineRendererSpec(
      labelStyle: charts.TextStyleSpec(
        fontSize: 14,
        color: charts.MaterialPalette.gray.shade400,
      ),
      lineStyle:
          charts.LineStyleSpec(color: charts.MaterialPalette.gray.shade400),
    ),
    tickProviderSpec: charts.BasicNumericTickProviderSpec(
        desiredTickCount: 4, zeroBound: true),
  );

  // END - STYLING
}
