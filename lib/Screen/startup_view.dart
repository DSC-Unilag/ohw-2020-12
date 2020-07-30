import 'package:flutter/material.dart';
import 'package:recipesaver/viewmodel/startup_viewmodel.dart';
import 'package:provider_architecture/provider_architecture.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<StartUpViewModel>.withConsumer(
      viewModel: StartUpViewModel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(width: 300, height: 100, child: Icon(Icons.stars),),
              CircularProgressIndicator(strokeWidth: 3, valueColor: AlwaysStoppedAnimation(Colors.red),)
            ],
          ),
        ),
      ),
    );
  }
}
