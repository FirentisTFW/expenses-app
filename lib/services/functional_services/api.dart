import 'package:Expenses_app/datamodels/category.dart';
import 'package:Expenses_app/datamodels/expenditure.dart';
import 'package:Expenses_app/datamodels/total_monthly_expenses.dart';

abstract class Api {
  // EXPENDITURES

  Future<List<Expenditure>> getAllExpenditures();

  Future<List<Expenditure>> getExpendituresInTimeSpan(
      DateTime start, DateTime end);

  Future<void> addExpenditure(Expenditure expenditure);

  Future<List<Expenditure>> getLastExpenditures({int howMany});

  // END - EXPENDITURES

  // TOTAL EXPENSES

  Future<List<TotalMonthlyExpenses>> getLastMonthsTotalExpenses(
      int howManyMonths);

  // END - TOTAL EXPENSES

  // CAEGORIES

  Future<List<Category>> getAllCategories();

  Future<void> addCategory(Category category);

  // END - CATEGORIES
}
