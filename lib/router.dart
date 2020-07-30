
import 'package:flutter/material.dart';
import 'package:recipesaver/Screen/homePage.dart';
import 'package:recipesaver/Screen/signUpScreen.dart';

import 'Screen/home.dart';
import 'Screen/loginScreen.dart';
import 'constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginScreen(),
      );
      case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpScreen(),
      );
      case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: Home(),
      );
    case HomePageVieRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeScreen(),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
