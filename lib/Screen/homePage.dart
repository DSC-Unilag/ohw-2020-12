import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recipesaver/widgets/buttons.dart';
import 'package:recipesaver/widgets/customTexts.dart';
import 'package:recipesaver/widgets/photocard.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:recipesaver/viewmodel/base_model.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ViewModelProvider<BaseModel>.withConsumer(
        viewModel: BaseModel(),
      builder: (context, model, child) {
        return Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Container(
                child: Column(
                  children: [
                    recipieSaverCard(width, height),
                    Expanded(
                      child: Container(
                        width: width,
                        decoration: kborderRadius,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            textInput1('Welcome to Recipe Saver'),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 247,
                              height: 42,
                              child: Text(
                                'A place to you have the access to any recipe of your choice',
                                textAlign: TextAlign.center,
                                style: kotherHeadertextStyle,
                              ),
                            ),
                            SizedBox(
                              height: 55,
                            ),
                            buttons(
                                height: 54,
                                width: 265,
                                boxColor: '#FE6D73',
                                textColor: '#F2F2F2',
                                text: 'Sign-in',
                                onPressed: () {
                                  //sign in
                                  model.navigationService.navigateTo(LoginViewRoute);
                                }),
                            SizedBox(
                              height: 34,
                            ),
                            InkWell(
                              onTap: (){
                                model.navigationService.navigateTo(LoginViewRoute);
                              },
                              child: buttons(
                                  height: 54,
                                  width: 265,
                                  boxColor: '#FFFFFF',
                                  textColor: '#333333',
                                  text: 'create an account',
                                  onPressed: () {
                                    //navigate to create account
                                    print("Create pressed");
                                    model.navigationService.navigateTo(SignUpViewRoute);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
      }
    );
  }
}
