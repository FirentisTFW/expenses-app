import 'package:Expenses_app/ui/universal_widgets/error_info.dart';
import 'package:Expenses_app/ui/universal_widgets/expenditure_item.dart';
import 'package:Expenses_app/ui/universal_widgets/loading_spinner.dart';
import 'package:Expenses_app/ui/views/last_expenditures/smart_widgets/short_list_of_expenses_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ShortListOfExpenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShortListOfExpensesViewModel>.reactive(
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Card(
          shape: _roundedBottomCorners,
          child: Column(
            children: [
              Container(
                height: 300,
                child: model.isBusy
                    ? LoadingSpinner()
                    : !model.hasError
                        ? model.data.length > 0
                            ? ListView(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                children: model.data
                                    .map((item) => ExpenditureItem(
                                          categoryId: item.categoryId,
                                          title: item.name,
                                          value: item.moneyAmount,
                                        ))
                                    .toList())
                            : noItemsYetInfo
                        : ErrorInfo(model.modelError.toString()),
              ),
              _ShowAllButton(),
            ],
          ),
        ),
      ),
      onViewModelReady: (model) => model.fetchData(),
      viewModelBuilder: () => ShortListOfExpensesViewModel(),
    );
  }

  final noItemsYetInfo = Container(
    child: Center(
      child: Text(
        'Brak wydatków',
      ),
    ),
  );
}

class _ShowAllButton extends ViewModelWidget<ShortListOfExpensesViewModel> {
  _ShowAllButton() : super(reactive: false);

  Widget build(BuildContext context, ShortListOfExpensesViewModel model) {
    return Container(
      width: double.infinity,
      height: 44,
      child: MaterialButton(
        shape: _roundedBottomCorners,
        color: Colors.red[400],
        child: Text(
          'Pokaż wszystkie wydatki',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: model.goToListOfExpensesView,
      ),
    );
  }
}

final _roundedBottomCorners = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
  bottomLeft: Radius.circular(14.0),
  bottomRight: Radius.circular(14.0),
));
