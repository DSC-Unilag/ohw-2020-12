import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:recipesaver/Screen/infoPage.dart';
import 'package:recipesaver/model/web_recipe.dart';
import 'package:recipesaver/services/web_services.dart';
import 'package:recipesaver/viewmodel/web_recipe_list_viewmodel.dart';
import 'package:recipesaver/viewmodel/web_recipe_viewmodel.dart';
import 'package:recipesaver/widgets/recipeCards.dart';

import '../constants.dart';
import '../widgets/customTexts.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final WebServices webServices = WebServices();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ViewModelProvider<WebRecipeViewModel>.withConsumer(
        viewModel: WebRecipeViewModel(),
      onModelReady: (_)=> _.fetchRecipe(),
      builder: (context, model, child) {
        return Column(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
//                    Text("Hey, ${model.currentUser.fullname}", style: headingtextStyle.copyWith(
//                        fontSize: 18, color: Colors.grey),),
                InkWell(
                  onTap: (){
                    model.signout();
                  },
                  child: Row(
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.person, color: Colors.red,),),
                      Text("Sign out", style: kDetailtextStyle,),
                      SizedBox(width: 20,)
                    ],
                  ),
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
                  backgroundImage: model.currentUser.imageurl == null ?AssetImage('assets/images/slice_2.png') : NetworkImage(model.currentUser.imageurl),
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
                child: model.busy ? Center(child: CircularProgressIndicator()) : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.recipe.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                        },
                        child: recipieCards(height: height, boximage: model.recipe[index].url,

                            recipiename: model.recipe[index].title, likes: 3, onPressed: (){
                              Navigator.of(context).push( MaterialPageRoute(builder: (_)=> InfoPage(recipe: model.recipe[index],)));
                            }),
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
