import 'package:flutter/material.dart';

import 'package:recipesaver/widgets/recipePage.dart';

import '../constants.dart';

class RecipieScreen extends StatefulWidget {
  @override
  _RecipieScreenState createState() => _RecipieScreenState();
}

class _RecipieScreenState extends State<RecipieScreen> {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
            SizedBox(width: 40),
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
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              fromRecipiePageCard('assets/images//slice_2.png', 'Beef pizza',
                  'ththSththhttddddddddddddththththrrhrhrhrdd', ' Armby Helen'),
              fromRecipiePageCard('assets/images//slice_2.png', 'Beef pizza',
                  'ththSththhttddddddddddddththththrrhrhrhrdd', ' Armby Helen'),
              fromRecipiePageCard('assets/images//slice_2.png', 'Beef pizza',
                  'ththSththhttddddddddddddththththrrhrhrhrdd', ' Armby Helen'),
              fromRecipiePageCard('assets/images//slice_2.png', 'Beef pizza',
                  'ththSththhttddddddddddddththththrrhrhrhrdd', ' Armby Helen'),
            ],
          ),
        ),
      ],
    );
  }
}
