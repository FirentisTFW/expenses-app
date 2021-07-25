import 'package:Expenses_app/app/locator.dart';
import 'package:Expenses_app/ui/views/last_expenditures/last_expenditures_viewmodel.dart';
import 'package:Expenses_app/ui/views/last_expenditures/smart_widgets/short_list_of_expenses.dart';
import 'package:Expenses_app/ui/views/last_expenditures/smart_widgets/last_months_expenses_chart.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LastExpendituresView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LastExpendituresViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              title,
              ShortListOfExpenses(),
              LastMonthsExpensesChart(),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => locator<LastExpendituresViewModel>(),
    );
  }

  final title = Container(
    padding: const EdgeInsets.only(top: 50, bottom: 25),
    width: double.infinity,
    child: const Text(
      'Last Expenditures',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 28),
    ),
  );
}
