import 'package:Expenses_app/datamodels/enums/grouping_method.dart';
import 'package:Expenses_app/ui/universal_widgets/error_info.dart';
import 'package:Expenses_app/ui/universal_widgets/expenses_pie_chart.dart';
import 'package:Expenses_app/ui/universal_widgets/last_months_bar_chart.dart';
import 'package:Expenses_app/ui/universal_widgets/loading_spinner.dart';
import 'package:Expenses_app/ui/views/trends/selection_fields.dart';
import 'package:Expenses_app/ui/views/trends/trends_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TrendsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TrendsViewModel>.reactive(
      builder: (context, child, model) => Scaffold(
        body: ListView(
          children: [
            SelectionFields(),
            TrendsChart(),
          ],
        ),
      ),
      viewModelBuilder: () => TrendsViewModel(),
    );
  }
}

class TrendsChart extends ViewModelWidget<TrendsViewModel> {
  @override
  Widget build(BuildContext context, TrendsViewModel model) {
    return model.isBusy
        ? LoadingSpinner(
            padding: EdgeInsets.symmetric(
              vertical: 50.0,
            ),
          )
        : !model.hasError
            ? model.isDataFetched
                ? model.data.isNotEmpty
                    ? _buildChart(model)
                    : noDataInfo
                : const SizedBox()
            : Container(
                padding: const EdgeInsets.all(30.0),
                child: ErrorInfo(model.modelError.toString()),
              );
  }

  Widget _buildChart(TrendsViewModel model) {
    Widget child;

    switch (model.groupingMethod) {
      case GroupingMethod.ByMonths:
        child = LastMonthsBarChart.buildFromData(
          initialData: model.data,
        );
        break;
      case GroupingMethod.ByCategories:
        child = ExpensesPieChart.buildFromData(
          initialData: model.dataSortedByAmout,
          legend: true,
        );
        break;
      default:
        child = const SizedBox.shrink();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          child,
          _buildTotalExpenses(model),
        ],
      ),
    );
  }

  Widget _buildTotalExpenses(TrendsViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'Suma: ${model.totalDataAmount.toStringAsFixed(2)}',
        style: TextStyle(
          fontSize: 22.0,
        ),
      ),
    );
  }

  final noDataInfo = Container(
    child: const Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: 40.0,
        ),
        child: Text('Brak danych dla wybranego okresu'),
      ),
    ),
  );
}
