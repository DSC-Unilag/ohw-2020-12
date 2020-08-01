import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:recipesaver/model/recipe.dart';
import 'package:recipesaver/constants.dart';
import 'package:recipesaver/services/navigation_service.dart';
import 'package:recipesaver/locator.dart';

class InfoPage extends StatefulWidget {
  Recipe recipe;
  InfoPage({this.recipe});
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Food Info',
          style: kotherHeadertextStyle.copyWith(
              fontSize: 18, color: Hexcolor('#333333')),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(top: 10),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.recipe.url))),
            ),
            SizedBox(
              height: 20,
            ),
            foodValue(20, 30, 40),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: width * 0.9,
              child: Text(
                " ${widget.recipe.description}",
                style: kotherHeadertextStyle,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/slice_2.png'),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'written by ${widget.recipe.user}',
                  style: kotherHeadertextStyle,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Utensils Needed:',
              style: kDetailtextStyle.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "${widget.recipe.utensils}",
              style: kDetailtextStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Ingredients:',
              style: kDetailtextStyle.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "${widget.recipe.ingredients}",
              style: kDetailtextStyle,
            ),
            SizedBox(
              height: 20,
            ),
            Text('Process:',
                style: kDetailtextStyle.copyWith(
                    fontSize: 18, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}

Widget foodValue(int time, int weight, int calories) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      RichText(
          text: TextSpan(children: [
        TextSpan(text: time.toString(), style: kDetailtextStyle2),
        TextSpan(text: 'mins', style: kDetailtextStyle2.copyWith(fontSize: 14))
      ])),
//      Spacer(),
//      RichText(
//          text: TextSpan(children: [
//        TextSpan(text: weight.toString(), style: kDetailtextStyle2),
//        TextSpan(text: 'Kg', style: kDetailtextStyle2.copyWith(fontSize: 14))
//      ])),
//      Spacer(),
//      RichText(
//          text: TextSpan(children: [
//        TextSpan(text: calories.toString(), style: kDetailtextStyle2),
//        TextSpan(text: 'Cal', style: kDetailtextStyle2.copyWith(fontSize: 14))
//      ])),
    ],
  );
}
