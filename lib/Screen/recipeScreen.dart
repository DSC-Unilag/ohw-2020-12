import 'package:flutter/material.dart';

import 'package:recipesaver/widgets/recipePage.dart';
import 'package:recipesaver/Screen/infoPage.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:recipesaver/viewmodel/get_recipe_viewmodel.dart';

import '../constants.dart';

class RecipieScreen extends StatefulWidget {
  @override
  _RecipieScreenState createState() => _RecipieScreenState();
}

class _RecipieScreenState extends State<RecipieScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ViewModelProvider<GetRecipeViewModel>.withConsumer(
        viewModel: GetRecipeViewModel(),
        onModelReady: (model) => model.fetchRecipe(),
        builder: (context, model, child) {
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recipie',
                    style: kotherHeadertextStyle.copyWith(fontSize: 18),
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/slice_2.png'),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: height * 0.7,
                  child: model.busy
                      ? Center(
                          child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation(Colors.red),
                        ))
                      : ListView.builder(
                          itemCount: model.recipe.length,
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => InfoPage(
                                              recipe: model.recipe[index],
                                            )));
                              },
                              child: fromRecipiePageCard(
                                  image: model.recipe[index].url,
                                  save: true,
                                  title: model.recipe[index].title,
                                  about: model.recipe[index].description,
                                  author: model.recipe[index].user == null
                                      ? "Babalola Gbogo"
                                      : model.recipe[index].user,
                                  onPressed: () {
                                    model.saveRecipe(model.recipe[index]);
                                  }),
                            );
                          })
//              ListView(
//                shrinkWrap: true,
//                scrollDirection: Axis.vertical,
//                children: [
//                  fromRecipiePageCard('assets/images//slice_2.png', 'Beef pizza',
//                      'ththSththhttddddddddddddththththrrhrhrhrdd', ' Armby Helen'),
//                  fromRecipiePageCard('assets/images//slice_2.png', 'Beef pizza',
//                      'ththSththhttddddddddddddththththrrhrhrhrdd', ' Armby Helen'),
//                  fromRecipiePageCard('assets/images//slice_2.png', 'Beef pizza',
//                      'ththSththhttddddddddddddththththrrhrhrhrdd', ' Armby Helen'),
//                  fromRecipiePageCard('assets/images//slice_2.png', 'Beef pizza',
//                      'ththSththhttddddddddddddththththrrhrhrhrdd', ' Armby Helen'),
//                ],
//              ),
                  ),
            ],
          );
        });
  }
}
