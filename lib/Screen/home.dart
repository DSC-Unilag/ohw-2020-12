import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:recipesaver/viewmodel/base_model.dart';
import 'package:recipesaver/widgets/bottomheet.dart';
import 'package:recipesaver/widgets/customTexts.dart';

import '../constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BaseModel>.withConsumer(
        viewModel: BaseModel(),
      builder: (context, model, child) {
          print(model.currentUser.fullname);
        return Scaffold(
          backgroundColor: kbackgoundColor,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                    child: TextField(
                      decoration: kInputBoxDecoration2,
                    ),
                  ),
                  Row(
                    children: [
                      discover(),
                      Spacer(),
                      SvgPicture.asset('assets/images/Vector2.svg'),
                      SvgPicture.asset('assets/images/Vector.svg',
                          color: Colors.red),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: null,
            backgroundColor: Hexcolor('#FE6D73'),
            child: Icon(
              Icons.add,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: bottomapp(context),
        );
      }
    );
  }
}
