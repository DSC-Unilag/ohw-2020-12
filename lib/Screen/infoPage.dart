import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:recipesaver/constants.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
                  Text(
                    'Food Info',
                    style: kotherHeadertextStyle.copyWith(
                        fontSize: 18, color: Hexcolor('#333333')),
                  )
                ],
              ),
              Container(
                height: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/pizza.png',
                        ))),
              ),
              foodValue(20, 30, 40),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: width * 0.9,
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Odio pellentesque duis in nisl venenatis iaculis aliquam. Massa ornare vestibulum aenean velit pretium.',
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
                    'written by Helen Stone',
                    style: kotherHeadertextStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Ingredients',
                style: kDetailtextStyle.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: 40,
              ),
              Text('Process', style: kDetailtextStyle.copyWith(fontSize: 18))
            ],
          ),
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
      Spacer(),
      RichText(
          text: TextSpan(children: [
        TextSpan(text: weight.toString(), style: kDetailtextStyle2),
        TextSpan(text: 'Kg', style: kDetailtextStyle2.copyWith(fontSize: 14))
      ])),
      Spacer(),
      RichText(
          text: TextSpan(children: [
        TextSpan(text: calories.toString(), style: kDetailtextStyle2),
        TextSpan(text: 'Cal', style: kDetailtextStyle2.copyWith(fontSize: 14))
      ])),
    ],
  );
}
