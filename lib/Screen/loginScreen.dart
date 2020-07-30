import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:recipesaver/viewmodel/login_view_model.dart';
import 'package:recipesaver/widgets/buttons.dart';
import 'package:recipesaver/widgets/customTexts.dart';
import 'package:recipesaver/widgets/photocard.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailCOntroller = TextEditingController();
  TextEditingController _passCOntroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ViewModelProvider<LoginViewModel>.withConsumer(
        viewModel: LoginViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              child: Column(
                children: [
                  recipieSaverCard(width, height - 180),
                  Expanded(
                    child: Container(
                      width: width,
                      decoration: kborderRadius,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              textInput1('Sign in to Recipe Saver'),
                              SizedBox(
                                height: 10,
                              ),
                              googlebuttons(54, 315, '#3246FA', '#F2F2F2',
                                  'Sign in with Google'),
                              SizedBox(
                                height: 40,
                              ),
                              Form(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 23),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      textInput2('Email Address'),
                                      SizedBox(height: 5,),
                                      TextFormField(
                                        controller: _emailCOntroller,
                                          decoration: kInputBoxDecoration),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      textInput2('password'),
                                      SizedBox(height: 5,),
                                      TextFormField(
                                        controller: _passCOntroller,
                                          obscureText: true,
                                          decoration: kInputBoxDecoration),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                             model.busy ? CircularProgressIndicator(strokeWidth: 3,) : buttons(
                                  height: 56,
                                  width: 314,
                                  boxColor: '#FE6D73',
                                  textColor: '#F2F2F2',
                                  text: 'Sign in',
                                  onPressed: () {
                                    model.login(email: _emailCOntroller.text, password: _passCOntroller.text);
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
