import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:recipesaver/Screen/infoPage.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:recipesaver/model/recipe.dart';
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
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Hey, ${model.currentUser.fullname}", style: headingtextStyle.copyWith(
                    fontSize: 18, color: Colors.grey),),
                Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.person, color: Colors.red,),),
                    Text("Sign out", style: kDetailtextStyle,),
                    SizedBox(width: 20,)
                  ],
                )
              ],
            ),
           SizedBox(height: 20,),
            Row(
              children: [
                discover(),
                Spacer(),
                CircleAvatar(
                  radius: 20,
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
                    return InkWell(
                      onTap: (){
                        var concatenate = StringBuffer();
                        model.recipes[index].ingredients.forEach((item){
                          concatenate.write(item);
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (_) => InfoPage(
                          recipe: Recipe(
                            ownerid: model.recipes[index].id,
                            utensils: "Not available",
                            time: model.recipes[index].createdAt,
                            description: model.recipes[index].instructions,
                            ingredients: concatenate.toString(),


                          ),
                        )));
                      },
                      child: recipieCards(height, model.recipes[index].image,
                        model.recipes[index].title, 3),
                    );
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
