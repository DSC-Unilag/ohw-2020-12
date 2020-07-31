import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipesaver/Screen/addRecipie.dart';
import 'package:recipesaver/Screen/infoPage.dart';
import 'package:recipesaver/Screen/profileScreen.dart';
import 'package:recipesaver/router.dart';
import 'package:recipesaver/Screen/startup_view.dart';
import 'package:recipesaver/services/navigation_service.dart';
import 'package:recipesaver/viewmodel/web_recipe_list_viewmodel.dart';

import 'Screen/home.dart';
import 'Screen/homePage.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Saver',
      navigatorKey: locator<NavigationService>().navigationKey,
      home: StartUpView(),
      onGenerateRoute: generateRoute,
    );
  }
}
