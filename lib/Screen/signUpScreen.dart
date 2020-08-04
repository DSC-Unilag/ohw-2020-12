import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:recipesaver/viewmodel/signup_viewmodel.dart';
import 'package:recipesaver/widgets/buttons.dart';
import 'package:recipesaver/widgets/customTexts.dart';
import 'package:recipesaver/widgets/photocard.dart';

import '../constants.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return ViewModelProvider<SignUpVIewModel>.withConsumer(
        viewModel: SignUpVIewModel(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Container(
                width: width,
                height: height,
                child: ListView(
                  children: [
                    recipieSaverCard(width, height - 200),
                    Container(
                      decoration: kborderRadius,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          textInput1('Sign in to Recipe Saver'),
                          SizedBox(
                            height: 10,
                          ),
//                          googlebuttons(54, 315, '#3246FA', '#F2F2F2',
//                              'Sign in with Google'),
                          SizedBox(
                            height: 35,
                          ),
                          Form(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textInput2('Fullname'),
                                  TextFormField(
                                      controller: _fullnameController,
                                      decoration: kInputBoxDecoration),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  textInput2('Username'),
                                  TextFormField(
                                      controller: _usernameController,
                                      decoration: kInputBoxDecoration),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  textInput2('Email'),
                                  TextFormField(
                                      controller: _emailController,
                                      decoration: kInputBoxDecoration),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  textInput2('Password'),
                                  TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: kInputBoxDecoration),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Checkbox(
                                  value: checkBoxValue, onChanged: (val) {}),
                              SizedBox(
                                width: width * 0.8,
                                child: textInput2(
                                    'Creating an account means you agree with our Terms and Condition'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          model.busy ? CircularProgressIndicator(strokeWidth: 3,) : buttons(
                              height: 56,
                              width: 314,
                              boxColor: '#FE6D73',
                              textColor: '#F2F2F2',
                              text: 'Sign In',
                              onPressed: () {
                                model.SignUpWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    fullname: _fullnameController.text,
                                    username: _usernameController.text);
                              })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
