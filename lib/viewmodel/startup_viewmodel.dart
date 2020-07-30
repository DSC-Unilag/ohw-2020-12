

import 'package:recipesaver/constants.dart';
import 'package:recipesaver/services/authentication_service.dart';
import 'package:recipesaver/services/navigation_service.dart';

import '../locator.dart';
import 'base_model.dart';

class StartUpViewModel extends BaseModel{
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async{
    var datetime = DateTime.now();
    DateTime date = new DateTime(datetime.year, datetime.month, datetime.day);
    date.add(Duration(days: 60));
    print(date);
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if(hasLoggedInUser){
      navigationService.pop();
      _navigationService.navigateTo(HomeViewRoute);
    }else{
      navigationService.pop();
      _navigationService.navigateTo(HomePageVieRoute);
    }
  }
}