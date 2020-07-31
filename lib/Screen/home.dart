import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:recipesaver/Screen/addRecipie.dart';
import 'package:recipesaver/Screen/profileScreen.dart';
import 'package:recipesaver/Screen/recipeScreen.dart';
import 'package:recipesaver/Screen/savedRecipe.dart';
import 'package:recipesaver/viewmodel/base_model.dart';
import 'package:recipesaver/widgets/bottomheet.dart';
import 'package:recipesaver/widgets/customTexts.dart';
import 'package:recipesaver/widgets/recipeCards.dart';

import '../constants.dart';
import '../constants.dart';
import 'discoverScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedIndex = 0;
  var index = 0;

  void itemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ViewModelProvider<BaseModel>.withConsumer(
        viewModel: BaseModel(),
        builder: (context, model, child) {
          // print(_selectedIndex);
          // print(model.currentUser.fullname);
          return Scaffold(
            backgroundColor: kbackgoundColor,
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    _selectedIndex == 0
                        ? DiscoverPage()
                        : _selectedIndex == 1
                            ? RecipieScreen()
                            : _selectedIndex == 2
                                ? null
                                : _selectedIndex == 3
                                    ? SavedRecipe()
                                    : Container(),
                  ],
                ),
              ),
            ),
            resizeToAvoidBottomPadding: false,
            extendBody: true,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddRecipePage()));
              },
              backgroundColor: Hexcolor('#FE6D73'),
              child: Icon(
                Icons.add,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: bottomSheet(itemTapped, _selectedIndex),
          );
        });
  }
}
