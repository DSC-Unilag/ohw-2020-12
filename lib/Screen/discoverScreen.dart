import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:recipesaver/viewmodel/web_recipe_list_viewmodel.dart';
import 'package:recipesaver/widgets/recipeCards.dart';

import '../constants.dart';
import '../widgets/customTexts.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ViewModelProvider<WebRecipeListViewModel>.withConsumer(
        viewModel: WebRecipeListViewModel(),
      onModelReady: (model)=> model.getRecipes(),
      builder: (context, model, child) {
          print(model.recipes.length);
        return Column(
          children: [
           SizedBox(height: 40,),
            Row(
              children: [
                discover(),
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: model.recipes.length,
                  itemBuilder: (context, index){
                    return recipieCards(height, model.recipes[index].image,
                      model.recipes[index].title, 3);
                  }
              )
//              ListView(
//                shrinkWrap: true,
//                scrollDirection: Axis.horizontal,
//                children: [
//                  recipieCards(height, 'assets/images/slice_2.png',
//                      'Blueberrry Toast Recipe', 3),
//                  recipieCards(height, 'assets/images/slice_2.png',
//                      'Blueberrry Toast Recipe', 5),
//                ],
//              ),
            ),
          ],
        );
      }
    );
  }
}
