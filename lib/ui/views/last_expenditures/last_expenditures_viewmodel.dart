import 'package:Expenses_app/app/locator.dart';
import 'package:Expenses_app/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LastExpendituresViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future goToTrendsView() async =>
      await _navigationService.navigateTo(Routes.trendsView);
}
