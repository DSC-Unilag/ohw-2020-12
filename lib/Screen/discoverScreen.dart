import 'package:flutter/material.dart';
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
    return Column(
      children: [
        Container(
          height: 50,
          margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
          child: TextField(
            decoration: kInputBoxDecoration2,
          ),
        ),
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
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              recipieCards(height, 'assets/images/slice_2.png',
                  'Blueberrry Toast Recipe', 3),
              recipieCards(height, 'assets/images/slice_2.png',
                  'Blueberrry Toast Recipe', 5),
            ],
          ),
        ),
      ],
    );
  }
}
